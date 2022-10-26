package com.thehandsome.mapper;

import com.thehandsome.domain.CouponVO;

/*****************************************************
 * @function : CouponMapper
 * @author : 김민선
 * @Date : 2022.10.20
 *****************************************************/

/* 
 *  쿠폰 관련한 SQL을 호출하기 위한 인터페이스
 */


public interface CouponMapper {

	// 쿠폰 발급
	public void makeCoupon(CouponVO coupon);
	
	// 회원이 가지고 있는 쿠폰 불러오기
	public CouponVO getCoupon(String mid);
	
}