package com.thehandsome.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thehandsome.domain.ColorVO;
import com.thehandsome.domain.Criteria;
import com.thehandsome.service.ProductService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/product")
@AllArgsConstructor
public class ProductController {

	private ProductService service;
	
	// 상품 정보를 받아와 모델 객체에 저장
	@GetMapping("/productDetail")
	public void productGetDetail(@RequestParam("pid") String pid, Criteria cri, Model model) {
		
		log.info("productGetDetail ................" + pid);
		
		model.addAttribute("cri", cri);
		model.addAttribute("productInfo", service.productGetDetail(pid));
	}
	
	// 해당 상품에 대한 color list 가져오기
	@ResponseBody
	@GetMapping(value = "/productColor",
	         produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public List<ColorVO> productGetColor(@RequestParam("pid") String pid) {
		
		log.info("productGetColor .................." + pid);
		log.info(service.productGetColor(pid));
		return service.productGetColor(pid);
	}
}
