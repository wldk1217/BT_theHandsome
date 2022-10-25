//김민선 생성
package com.thehandsome.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thehandsome.domain.OrderItemVO;
import com.thehandsome.domain.OrderListVO;
import com.thehandsome.domain.MemberVO;
import com.thehandsome.domain.ProductVO;
import com.thehandsome.domain.ColorVO;

import com.thehandsome.service.OrderService;
import com.thehandsome.service.MemberService;
import com.thehandsome.service.ProductService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
	
	@Autowired
	private OrderService orderservice;
	private MemberService memberservice;
	private ProductService productservice;

	// order page 진입
	@GetMapping("/order")
	public String orderGet(HttpServletRequest request, MemberVO member) throws Exception {
		log.info("order page 1차 진입");
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("member");
		log.info(loginUser);
		 if (loginUser == null) {
			 return "redirect:/member/login";
	      } else {
	    	  log.info("order page 2차 진입");
	    	 return "/order/order";
	      }
	}
	
	// 상품 정보 가져오기
	@PostMapping("/order")
	public void orderGet(HttpServletRequest request,ProductVO product) throws Exception {
		HttpSession session = request.getSession();
//		ProductVO productVO = productservice.productGetDetail(pid);
//		List<ColorVO> colorInfo = productservice.productGetColor(ccolorcode);
	
		log.info("order 상품리스트 떠라 제발");
	}
	
	// orderlist 삽입
	@PostMapping("/orderlistinsert")
	public void orderlistinsert(HttpServletRequest request,OrderListVO orderlist) throws Exception {
		log.info("orderlistinsert 진입 ");
		// orderlist 삽입 실행
		orderservice.orderlistinsert(orderlist);
	}


	

}