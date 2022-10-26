package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.thehandsome.domain.CouponVO;
import com.thehandsome.mapper.CouponMapper;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : GetCouponTest
 * @author : 김민선
 * @Date : 2022.10.21
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class GetCouponTest {
	@Autowired
	private CouponMapper mapper;
	// 쿠폰 조회 테스트
	@Test
	public void getCoupon() throws Exception{
		CouponVO coupon = mapper.getCoupon("ms");
		log.info(coupon);

	}
}
