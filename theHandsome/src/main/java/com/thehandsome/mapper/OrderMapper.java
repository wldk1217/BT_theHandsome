package com.thehandsome.mapper;

import com.thehandsome.domain.OrderListVO;
import com.thehandsome.domain.OrderItemVO;


/*****************************************************
 * @function : OrderMapper
 * @author : 김민선
 * @Date : 2022.10.24
 *****************************************************/

/* 
 *  주문 관련한 SQL을 호출하기 위한 인터페이스
 */

public interface OrderMapper {

	//결제 누르면 주문자 정보 및 배송지 insert
	public void orderlistinsert (OrderListVO order); 


}
