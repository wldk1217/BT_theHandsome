package com.theHandsome.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.thehandsome.domain.ProductCriteria;
import com.thehandsome.service.ProductService;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : ProductServiceTests
 * @author : 심지연
 * @Date : 2022.10.20
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml" })
@Log4j
public class ProductServiceTests {

	@Autowired
	private ProductService productservice;

	@Test
	public void getListTest() {
		productservice.getList(new ProductCriteria(2, 12), "WOMEN", "Top", "T-Shirts")
		.forEach(product -> log.info(product));
	}

	@Test
	public void produdctDetailTest() throws Exception {
		String pid = "YN2CAFOT063W";
		log.info(productservice.productGetDetail(pid));
	}
}
