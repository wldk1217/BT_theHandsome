package com.thehandsome.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.thehandsome.domain.MemberVO;
import com.thehandsome.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : MemberController
 * @author : 구영모, 김민선, 심지연 공동작업
 * 1차 작업: 심지연 로그인/로그아웃 구현
 * 2차 작업: 김민선 회원가입 구현
 * 3차 작업: 구영모 시큐리티 적용
 * @Date :  2022.10.18(1차 작업 완료)
 * 		    2022.10.19(2차 작업 완료)
 * 			2022.10.26(3차 작업 완료)
 *****************************************************/

@Log4j
@Controller
@RequestMapping(value = "/member")
@AllArgsConstructor
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	//author:구영모 비밀번호를 암호화 하기 위한 모듈 불러오기
	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@Autowired
	private MemberService memberservice;
	
	// author:심지연 로그인 뷰로 이동
	@GetMapping("/login")
	public void loginGet(String error, String logout, Model model) {
		log.info("error"+error);
		log.info("logout"+logout);
		if(error != null) {
			model.addAttribute("error", "Login error");
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout");
		}
	}

	// author:심지연 로그아웃 기능
	@GetMapping("/logout")
	public String logoutGet(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate(); // 세션에 저장된 값을 무효화

		return "redirect:/"; // 로그아웃 후 메인페이지로 이동
	}
	
	// author:김민선 회원가입 페이지 이동
	@GetMapping("/join")
	public void loginGET() {
		logger.info("회원가입 페이지 진입");

	}

	// author:김민선 회원가입
	@PostMapping("/join")
	public String joinPOST(MemberVO member) throws Exception {
		log.info("----------회원가입 페이지 진입 ---------- member : " + member);
		//비밀번호 보안을 위해 인코딩 사용
		String encoderPassword = passwordEncoder.encode(member.getMpassword());
		//인코딩 된 비밀번호로 변경
		member.setMpassword(encoderPassword);
		String mid = member.getMid();
		//회원 정보를 DB에 insert
		memberservice.memberJoin(member);
		//회원 정보를 member_auth테이블에 insert
		memberservice.memberAuthJoin(mid);
		//로그인 페이지로 이동
		return "redirect:/member/login";
	}

	// author:김민선 회원가입아이디 중복체크
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam("id") String id) {
		int cnt = memberservice.idCheck(id);
		logger.info("controller " + cnt);
		if (cnt == 0 ) {
			//cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
			String result = "possible";
			return result;
			
		} else { 
			String result = "impossible";
			return result;
		} 	
	}
}