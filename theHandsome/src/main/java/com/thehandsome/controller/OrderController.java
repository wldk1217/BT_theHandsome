//김민선 생성
package com.thehandsome.controller;


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

import com.thehandsome.service.OrderService;
import com.thehandsome.service.MemberService;


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

	// order page 진입
	@GetMapping("/order")
	public String orderGet(HttpServletRequest request, MemberVO member) throws Exception {
		log.info("order page 1차 진입");
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("member");
		log.info(loginUser);
		 if (loginUser == null) {
//	         String url = "/member/login";
//	         response.sendRedirect(url);
			 return "redirect:/member/login";
	      } else {
	    	  log.info("order page 2차 진입");
	    	 return "/order/order";
	      }
	}

	
//	// event detail & coupon 발급 page 진입
//	@GetMapping("/coupon")
//	public void eventDetailGet() {
//		log.info("이벤트 상세 & 쿠폰발급 페이지 진입");
//	}
//	
//	//쿠폰 발급
//	@RequestMapping(value = "/makecoupon", 
//			consumes = "application/json",
//			produces ="application/json",
//			method = RequestMethod.POST)
//	public String makeCoupon(CouponVO coupon) throws Exception {
//		couponservice.makeCoupon(coupon);
//
//		log.info("make coupon 성공");
//
//		return "redirect:/event";
//
//	}

}