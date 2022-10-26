package com.thehandsome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thehandsome.domain.OrderListVO;
import com.thehandsome.domain.OrderItemVO;
import com.thehandsome.mapper.OrderMapper;
import lombok.AllArgsConstructor;

/*****************************************************
 * @function : OrderServiceImpl
 * @author : 김민선
 * @Date : 2022.10.24
 *****************************************************/

@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	 private OrderMapper mapper;
	
	
	// 결제시 orderlist 삽입
	@Override 
	 public void orderlistinsert(OrderListVO order) throws Exception{
	 mapper.orderlistinsert(order);
	}

}
