//김민선 생성
package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.CouponVO;
import com.thehandsome.mapper.CouponMapper;

import jdk.internal.jline.internal.Log;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class GetCouponTest {
	@Autowired
	private CouponMapper mapper;
	
	@Test
	public void getCoupon() throws Exception{
		CouponVO coupon = mapper.getCoupon("ms");
		log.info(coupon);

	}
}
