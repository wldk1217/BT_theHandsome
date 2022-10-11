package com.thehandsome.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;

	// 회원가입 뷰로 이동
	@GetMapping("/joininfoform")
	public void joinGet() {
		log.info("회원가입 페이지 진입");
	}

	// 뷰에서 전달받은 VO 객체로 service에 넘겨줌으로써 회원가입 기능이 동작하도록 함
	@PostMapping("/joininfoform")
	public String joinPost(MemberVO member) throws Exception {

		log.info("join 진입");
		service.memberJoin(member);

		log.info("join Service 성공");

		return "redirect:/member/login"; // 회원가입 완료 후 로그인 페이지로 이동
	}

	// mid를 전달받아 DB에 해당 아이디가 존재하는지 조회하는 기능
	@PostMapping("/idCheck")
	@ResponseBody
	public String idCheck(@RequestParam("mid") String mid) {
		log.info("userIdCheck 진입");
		log.info("전달받은 email:" + mid);
		int cnt = service.idCheck(mid);

		if (cnt != 0) // 해당 아이디가 이미 존재 (이미 사용중)
			return "fail";
		else // 해당 아이디 사용 가능
			return "success";
	}

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
		MemberVO memberVO = service.memberLogin(member); // 아이디와 비밀번호 매핑 확인

		if (memberVO == null) { // 일치하지 않는 아이디 또는 비밀번호를 입력한 경우

			int result = 0;
			rttr.addFlashAttribute("result", result);
			return "redirect:/member/login";

		}

		// 로그인 성공 시 세션에 VO 객체를 저장
		session.setAttribute("member", memberVO); // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
		log.info("member : " + session.getAttribute("member"));

		return "redirect:/main"; // 로그인 성공 시 메인페이지로 이동
	}

	// 로그아웃 기능
	@GetMapping("/logout")
	public String logoutGet(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate(); // 세션에 저장된 값을 무효화

		return "redirect:/main"; // 로그아웃 후 메인페이지로 이동
	}
}
