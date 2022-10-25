//김민선 생성
package com.thehandsome.controller;

import java.util.Locale;

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

import com.thehandsome.domain.MemberVO;
import com.thehandsome.service.CouponService;
import com.thehandsome.domain.CouponVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

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
		MemberVO loginUser = (MemberVO) session.getAttribute("member");
		 if (loginUser == null) {
			 log.info("로그인하고 오십쇼");
	       	 return "redirect:/member/login";
	      } else {
	    	  couponservice.makeCoupon(coupon);
	    	  log.info("쿠폰 발급");
		      return "redirect:/";
	      }

	}

}