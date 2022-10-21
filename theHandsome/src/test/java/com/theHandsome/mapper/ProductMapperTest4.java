package com.theHandsome.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.ProductVO;
import com.thehandsome.mapper.ProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : ProductMapper 테스트4
 * @author : 심지연
 * @Date : 2022.10.20
 ******************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProductMapperTest4 {
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;
	
	@Test
	public void readTest() {
		
		String bname = "TIME";
		
		ProductVO result = mapper.read(bname);
		
		System.out.println("상품 조회 데이터 : " + result);
	}
}
