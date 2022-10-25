//김민선 생성
package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.CouponVO;
import com.thehandsome.mapper.CouponMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MakeCouponTest {

	@Autowired
	private CouponMapper mapper;
	
	@Test
	public void makeCoupon() throws Exception{
		CouponVO coupon = new CouponVO();
		coupon.setCcode("ABC1236");
		coupon.setMid("ms");
		coupon.setCname("ms coupon");
		
	    mapper.makeCoupon(coupon);

	}
}


