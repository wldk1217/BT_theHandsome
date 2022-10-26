package com.thehandsome.domain;

import lombok.Data;

/*****************************************************
 * @function : OrderItem 테이블 VO
 * @author : 구영모
 * @Date : 2022.10.17
 ******************************************************/
@Data
public class OrderItemVO {
	//주문 번호
	private String oid;
	//색깔 코드
	private String ccolorcode;
	//사이즈
	private String ssize;
	//상품 id
	private String pid;
	//회원 id
	private String mid;
	//주문수량
	private int oamount;
}
