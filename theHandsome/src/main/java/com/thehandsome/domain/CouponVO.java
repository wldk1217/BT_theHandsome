package com.thehandsome.domain;

import java.util.*;
import lombok.Data;


/*****************************************************
 * @function : CouponVO
 * @author : 김민선
 * @Date : 2022.10.20
 *****************************************************/

@Data
public class CouponVO {
	// 쿠폰  코드
	private String ccode; 
	// 회원id
	private String mid; 
	// 쿠폰 이름
	private String cname; 
	// 쿠폰 발급일자
	private Date cstartDate; 
	// 쿠폰 유효일자
	private Date cendDate; 
	// 할인율
	private int cupto; 
	// 쿠폰 상태 (사용전, 만료)
	private int cstate; 
}
