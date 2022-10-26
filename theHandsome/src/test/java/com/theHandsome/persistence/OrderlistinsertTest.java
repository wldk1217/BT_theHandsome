package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.OrderListVO;
import com.thehandsome.mapper.OrderMapper;
import com.thehandsome.service.OrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.sql.DATE;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderlistinsertTest {
	
	@Autowired
	private OrderService service;
	
	
	@Test
	public void orderlistinsert() throws Exception{
		OrderListVO orderlist = new OrderListVO();
		
		orderlist.setOid("1");
		orderlist.setMid("ms");
		
		orderlist.setOzipcode(123);
		orderlist.setOaddress1("123");
		orderlist.setOaddress2("123");
		orderlist.setOreceiver("ㄱㅁㅅ");
		orderlist.setOtel("123");
		service.orderlistinsert(orderlist);
	}

}//end class 
