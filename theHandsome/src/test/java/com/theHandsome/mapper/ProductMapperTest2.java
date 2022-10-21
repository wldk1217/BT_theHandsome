package com.theHandsome.mapper;

import java.util.List;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.thehandsome.domain.ColorVO;
import com.thehandsome.mapper.ProductMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : ProductMapper 테스트2
 * @author : 심지연
 * @Date : 2022.10.20
 ******************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ProductMapperTest2 {
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;
	
	@Test
	public void productGetColorTest() {
		
		String pid = "YN2CAFOT063W";
		
		List<ColorVO> result = mapper.productGetColor(pid);
		
		for(ColorVO vo : result) {
			System.out.println("상품 컬러 데이터 : " + vo);
		}
	}	
}