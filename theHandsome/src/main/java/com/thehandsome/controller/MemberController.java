package com.thehandsome.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	// 로그인 뷰로 이동
	@GetMapping("/login")
	public void loginGet() {
		log.info("로그인 페이지 진입");
	}

	// 뷰에서 전달받은 데이터로 로그인 기능이 동작하도록 함
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {
		log.info("전달된 데이터 : " + member);

		HttpSession session = request.getSession();
		MemberVO memberVO = memberservice.memberLogin(member); // 아이디와 비밀번호 매핑 확인

		if (memberVO == null) { // 일치하지 않는 아이디 또는 비밀번호를 입력한 경우

			int result = 0;
			rttr.addFlashAttribute("result", result);
			return "redirect:/member/login";

		}

		// 로그인 성공 시 세션에 VO 객체를 저장
		session.setAttribute("member", memberVO); // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
		log.info("member : " + session.getAttribute("member"));

		return "redirect:/"; // 로그인 성공 시 메인페이지로 이동
	}

	// 로그아웃 기능
	@GetMapping("/logout")
	public String logoutGet(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate(); // 세션에 저장된 값을 무효화

		return "redirect:/"; // 로그아웃 후 메인페이지로 이동
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

	// 회원가입아이디 중복체크
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