package com.thehandsome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.thehandsome.domain.OrderListVO;
import com.thehandsome.domain.OrderItemVO;
import com.thehandsome.mapper.OrderMapper;
import com.thehandsome.mapper.ProductMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	
	@Autowired
	 private OrderMapper mapper;
	
	@Override 
	 public void orderlistinsert(OrderListVO order) throws Exception{
	 mapper.orderlistinsert(order);
	}

}
