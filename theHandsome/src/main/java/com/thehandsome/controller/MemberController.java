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
	//비밀번호를 암호화 하기 위한 모듈 불러오기
	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	@Autowired
	private MemberService memberservice;
	// 로그인 뷰로 이동
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

	// 뷰에서 전달받은 데이터로 로그인 기능이 동작하도록 함
//	@PostMapping("/login")
//	public String loginPost(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {
//		String password="";//
//		String encodedPassword="";
//		
//		HttpSession session = request.getSession();
//		MemberVO memberVO = memberservice.memberLogin(member); // 아이디와 비밀번호 매핑 확인		
//		
//		if(memberVO != null) {
//			password = member.getMpassword();
//			log.info("----------------------password : "+password);
//			encodedPassword = memberVO.getMpassword();
//			log.info("----------------------memvopassword : "+encodedPassword);
//			if(passwordEncoder.matches(password, encodedPassword)) {//비밀번호가 같을 시에
//				//비밀번호를 숨기기 위해 set메소드를 통해 지움
//				memberVO.setMpassword("");
//				String mid="";
//				mid = member.getMid();
//				session.setAttribute("memid", mid); // member 변수에 id값 저장
//				// 로그인 성공 시 세션에 VO 객체를 저장
//				session.setAttribute("member", memberVO); // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
//				log.info("member : " + session.getAttribute("member"));
//				return "redirect:/"; // 로그인 성공 시 메인페이지로 이동
//			}
//			else {//비밀번호가 같지 않을 시에
//				rttr.addFlashAttribute("result", 0);
//				return "redirect:/member/login";
//			}
//		}
//		else {
//			rttr.addFlashAttribute("result", 0);
//			return "redirect:/member/login";
//		}
//	}

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