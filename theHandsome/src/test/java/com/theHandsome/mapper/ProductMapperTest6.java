package com.theHandsome.mapper;

import java.util.List;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.thehandsome.domain.Criteria;
import com.thehandsome.domain.ProductVO;
import com.thehandsome.mapper.ProductMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : ProductMapper 테스트6
 * @author : 심지연
 * @Date : 2022.10.20
 ******************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProductMapperTest6 {

	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;

	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(12);
		List<ProductVO> list = mapper.getListWithPaging(cri, "WOMEN", "Top", "T-Shirts");
		list.forEach(product -> log.info("" + product));
	}
	
}