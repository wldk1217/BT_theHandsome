package com.theHandsome.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.OrderListVO;
import com.thehandsome.service.OrderService;

/*****************************************************
 * @function : OrderlistInsert
 * @author : 김민선
 * @Date : 2022.10.24
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")

public class OrderlistinsertTest {
	
	@Autowired
	private OrderService service;
	
	// orderlist insert 테스트
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
