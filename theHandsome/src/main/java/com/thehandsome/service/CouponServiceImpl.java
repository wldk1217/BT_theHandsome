package com.thehandsome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thehandsome.domain.CouponVO;
import com.thehandsome.mapper.CouponMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : CouponServiceImpl
 * @author : 김민선
 * @Date : 2022.10.20
 *****************************************************/

@Log4j
@Service
@AllArgsConstructor
public class CouponServiceImpl implements CouponService{

	@Autowired
	private CouponMapper mapper;

	// 쿠폰 생성
	@Override
	public void makeCoupon(CouponVO coupon) throws Exception {
		log.info("register.." + coupon);
		mapper.makeCoupon(coupon);
	}
	
	// 쿠폰 리스트 조회
	@Override
	public CouponVO getCoupon(String mid) throws Exception{
		log.info("조회.." + mid);
		return mapper.getCoupon(mid);
	}
	
}