package com.thehandsome.service;

import com.thehandsome.domain.OrderItemVO;
import com.thehandsome.domain.OrderListVO;

/*****************************************************
 * @function : OrderService
 * @author : 김민선
 * @Date : 2022.10.24
 *****************************************************/

public interface OrderService {
	
	// 결제시 orderlist 삽입
	public void orderlistinsert(OrderListVO orderlist) throws Exception;

}

