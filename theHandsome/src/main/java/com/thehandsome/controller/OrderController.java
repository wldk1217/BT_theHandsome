package com.thehandsome.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.thehandsome.domain.OrderListVO;
import com.thehandsome.domain.MemberVO;
import com.thehandsome.domain.ProductVO;
import com.thehandsome.domain.CouponVO;
import com.thehandsome.service.OrderService;
import com.thehandsome.service.CouponService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : OrderController
 * @author : 김민선
 * @Date : 2022.10.24
 *****************************************************/


@Log4j
@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
	@Autowired
	private OrderService orderservice;
	private CouponService couponservice;
	
	// order page 진입  및 상품 정보, 쿠폰정보 가져오기
	@PostMapping("/order")
	public String orderGet(HttpServletRequest request, ProductVO product, MemberVO member, CouponVO coupon) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("member");
		log.info(loginUser);

		if (loginUser == null) {
			return "redirect:/member/login";
		} else {
			log.info("order page 2차 진입");
			
			// 로그인한 회원의 쿠폰 가져오기
			CouponVO couponVO = couponservice.getCoupon(loginUser.getMid());
			log.info(couponVO);
			
			String cname = ""; // 쿠폰 이름
			int cupto = 0; // 쿠폰 할인율
			cname = couponVO.getCname();
			cupto = couponVO.getCupto();
			
			session.setAttribute("cc", cname);
			session.setAttribute("cupto", cupto);
			return "/order/order";
		}

	}
	// 결제버튼 클릭시 orderlist 삽입
	@PostMapping("/orderlistinsert")
	public String orderlistisnsert(HttpServletRequest request, OrderListVO orderlist) throws Exception {
		orderservice.orderlistinsert(orderlist);
		log.info("orderlistinsert 완료");
		return "redirect:/";
	}
}