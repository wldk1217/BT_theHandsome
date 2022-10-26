package com.thehandsome.service;

import com.thehandsome.domain.CouponVO;

/*****************************************************
 * @function : CouponService
 * @author : 김민선
 * @Date : 2022.10.20
 *****************************************************/

public interface CouponService {
	// 쿠폰 생성
	public void makeCoupon(CouponVO coupon) throws Exception;
	
	// 쿠폰 리스트 조회
	public CouponVO getCoupon(String mid) throws Exception;		


}