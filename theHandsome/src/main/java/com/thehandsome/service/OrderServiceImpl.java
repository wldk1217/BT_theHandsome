package com.thehandsome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thehandsome.mapper.OrderMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	//@Autowired
	// private OrderMapper mapper;
	
	//@Override 
	// public void order(OrderListVO order) throws Exception{
	// mapper.order(order);
	//}

}
