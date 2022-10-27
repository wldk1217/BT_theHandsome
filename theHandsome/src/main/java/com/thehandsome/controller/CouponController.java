package com.thehandsome.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.thehandsome.domain.MemberVO;
import com.thehandsome.service.CouponService;
import com.thehandsome.domain.CouponVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : CouponController
 * @author : 김민선
 * @Date : 2022.10.20
 *****************************************************/

@Log4j
@Controller
@RequestMapping("/event/*")
@AllArgsConstructor
public class CouponController {
	
	@Autowired
	private CouponService couponservice;

	// event page 진입
	@GetMapping("/event")
	public void eventGet() {
		log.info("이벤트 페이지 진입");
	}

	
	// event detail & coupon 발급 page 진입
	@GetMapping("/coupon")
	public void eventDetailGet() {
		log.info("이벤트 상세 & 쿠폰발급 페이지 진입");
	}
	
	
	//쿠폰 발급
	@PostMapping("/makecoupon")
	public String makeCoupon(HttpServletRequest request, MemberVO member, CouponVO coupon) throws Exception {
		HttpSession session = request.getSession();
		String loginUser = (String)session.getAttribute("memid");
		log.info("쿠폰 발급시 mid값 확인 : "+loginUser);
		 if (loginUser == null) {
			 log.info("로그인하고 쿠폰을 발급하세요");
	       	 return "redirect:/member/login";
	      } else {
	    	  couponservice.makeCoupon(coupon);
	    	  log.info("쿠폰 발급완료");
		      return "redirect:/";
	      }

	}
	
	
}