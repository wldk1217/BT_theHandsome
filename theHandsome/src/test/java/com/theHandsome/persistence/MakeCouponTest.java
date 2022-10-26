package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.thehandsome.domain.CouponVO;
import com.thehandsome.mapper.CouponMapper;

/*****************************************************
 * @function : MakeCouponTest
 * @author : 김민선
 * @Date : 2022.10.21
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")

public class MakeCouponTest {

	@Autowired
	private CouponMapper mapper;
	
	// 쿠폰 발급 테스트
	@Test
	public void makeCoupon() throws Exception{
		CouponVO coupon = new CouponVO();
		coupon.setCcode("ABC1236");
		coupon.setMid("ms");
		coupon.setCname("ms coupon");
	    mapper.makeCoupon(coupon);

	}
}


