package com.thehandsome.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thehandsome.domain.MemberVO;
import com.thehandsome.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/member")
@AllArgsConstructor
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberservice;

	// 로그인 페이지 이동
		@RequestMapping(value = "login", method = RequestMethod.GET)
		public void joinGET() {

			logger.info("로그인 페이지 진입");

		}
		
		
	// 회원가입 페이지 이동
	@GetMapping("/join")
	public void loginGET() {
		logger.info("회원가입 페이지 진입");

	}
	
	// 회원가입
	@PostMapping("/join")
	public String joinPOST(MemberVO member) throws Exception {

		log.info("join 진입 " + member);
		// 회원가입 서비스 실행
		memberservice.memberJoin(member);
		// 로그인 페이지로 이동
		return "redirect:/member/login";

	}

	

}