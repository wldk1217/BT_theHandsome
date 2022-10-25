// 김민선 생성

//  회원과 관련한 SQL을 호출하기 위한 인터페이스
 
package com.thehandsome.mapper;

import com.thehandsome.domain.OrderListVO;
import com.thehandsome.domain.OrderItemVO;

public interface OrderMapper {
//	// 주문 클릭하면 주문 리스트 insert
//	public void insertOrderItem(OrderItemVO orderItem); 
//	
//	//결제 창에서 주문 list 보여주기
//	public void showOrderItem(OrderItemVO orderItem);
//	
	//결제 누르면 주문자 정보 및 배송지 insert
	public void orderlistinsert (OrderListVO order); 


}
