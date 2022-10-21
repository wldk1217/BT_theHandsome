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
 * @function : ProductMapper 테스트
 * @author : 심지연
 * @Date : 2022.10.20
 ******************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProductMapperTest {
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;
	
	@Test
	public void productGetDetailTest() {
		
		String pid = "YN2CAFOT063W"; // 여성-아우터-재킷의 리버시블 램스 퍼 재킷 상품
		
		ProductVO result = mapper.productGetDetail(pid);
		
		System.out.println("상품 조회 데이터 : " + result);
	}
}
