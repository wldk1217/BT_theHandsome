package com.thehandsome.domain;

import lombok.Data;
import oracle.sql.DATE;

/*****************************************************
 * @function : OrderListVO
 * @author : 김민선
 * @Date : 2022.10.24
 ******************************************************/

@Data
public class OrderListVO {
	// 주문 번호
	private String oid; 
	// 회원 id
	private String mid; 
	// 배송지 우편번호
	private int ozipcode; 
	// 배송지 주소 1
	private String oaddress1; 
	// 배송지 주소 2
	private String oaddress2; 
	// 주문일자
	private DATE odate;
	// 수령인
	private String oreceiver;
	// 수령인 전화번호
	private String otel;

}
