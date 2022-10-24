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

import com.thehandsome.domain.ProductVO;
import com.thehandsome.service.ProductService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/product")
@AllArgsConstructor
public class ProductController {

	private ProductService service;

	// 상품 상세 정보 보기
	@GetMapping("/productDetail")
	public String product_detail(@RequestParam("pid") String pid, @RequestParam("ccolorcode") String ccolorcode,
			Model model) {

		ProductVO product = service.productGetDetail(pid);
		log.info("디테일 컨트롤러 들어옴");
		System.out.println(product.getPsize());
		String[] sizelist = product.getPsize().split(",");
		model.addAttribute("sizelist", sizelist);
		model.addAttribute("productVO", service.productGetDetail(pid));
		model.addAttribute("colorVOList", service.productGetColor(pid));
		model.addAttribute("ColorCode",ccolorcode);
		return "/product/productDetail";
	}

	// 해당 상품에 대한 color list 가져오기
	@ResponseBody
	@GetMapping(value = "/productColor", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public List<ColorVO> productGetColor(@RequestParam("pid") String pid) {

		log.info("productGetColor .................." + pid);
		log.info(service.productGetColor(pid));
		return service.productGetColor(pid);
	}
}
