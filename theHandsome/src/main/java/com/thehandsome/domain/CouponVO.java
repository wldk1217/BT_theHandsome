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
	private String ccode; // 쿠폰  코드
	private String mid; // 멤버 id
	private String cname; // 쿠폰 이름
	private Date cstartDate; // 쿠폰 발급일자
	private Date cendDate; // 쿠폰 유효일자
	private int cupto; // 할인율
	private int cstate; // 쿠폰 상태 (사용전, 만료)
}
