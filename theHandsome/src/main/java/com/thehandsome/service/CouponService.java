// 김민선 생성
package com.thehandsome.service;

import com.thehandsome.domain.CouponVO;

public interface CouponService {
	
	

	// 쿠폰 생성
	public void makeCoupon(CouponVO coupon) throws Exception;
	
	// 쿠폰 리스트 조회
	public CouponVO getCoupon(String mid) throws Exception;		


}