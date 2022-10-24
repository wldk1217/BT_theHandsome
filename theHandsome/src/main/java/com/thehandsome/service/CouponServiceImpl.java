// 김민선 생성

package com.thehandsome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thehandsome.domain.CouponVO;
import com.thehandsome.mapper.CouponMapper;
import com.thehandsome.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class CouponServiceImpl implements CouponService{

	@Autowired
	private CouponMapper mapper;

	@Override
	public void makeCoupon(CouponVO coupon) throws Exception {
		log.info("register.." + coupon);
		mapper.makeCoupon(coupon);
		
	}
	
}