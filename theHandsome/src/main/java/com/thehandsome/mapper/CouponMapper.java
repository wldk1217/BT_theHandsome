// 김민선 생성
package com.thehandsome.mapper;

import com.thehandsome.domain.CouponVO;

// 쿠폰과 관련한 SQL을 호출하기 위한 인터페이스


public interface CouponMapper {

	public void makeCoupon(CouponVO coupon);
	
	public CouponVO getCoupon(String mid);
	
}