package com.thehandsome.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.thehandsome.domain.ColorVO;
import com.thehandsome.domain.ProductCriteria;
import com.thehandsome.domain.ProductPageDTO;
import com.thehandsome.domain.ProductVO;
import com.thehandsome.service.ProductService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : ProductListController
 * @author : 심지연
 * @Date : 2022.10.19
 *****************************************************/

@Controller
@RequestMapping("")
@AllArgsConstructor
@Log4j
public class ProductListController {

	@Autowired
	private ProductService service;

	// 카테고리 별 상품리스트
	@GetMapping("/list")
	public String list(ProductCriteria cri, Model model, @RequestParam("clarge") String clarge,
			@RequestParam("cmedium") String cmedium, @RequestParam("csmall") String csmall) {
		log.info("리스트: " + cri);

		System.out.println("카테고리 분류: " + clarge + " " + cmedium + " " + csmall);
		ProductVO product = new ProductVO(clarge, cmedium, csmall);
		model.addAttribute("product", product);

		List<ProductVO> list = service.getList(cri, clarge, cmedium, csmall);
		log.info("list: " + list);
		
		List<ColorVO> colorList = null;
		List<String> sizeList = null;
		List<List<ColorVO>> colorMap = new ArrayList<>();
		List<List<String>> sizeMap = new ArrayList<>();
		
		model.addAttribute("list", list);
		int total = service.getTotal(clarge, cmedium, csmall);
		log.info("total = " + total);
		
		model.addAttribute("pager", new ProductPageDTO(cri, total));
		model.addAttribute("totalProducts", total);

		for (int i = 0; i < list.size(); i++) {
			colorList = service.productGetColor(list.get(i).getPid());
			sizeList = service.getSize(list.get(i).getPid());
			colorMap.add(colorList);
			sizeMap.add(sizeList);
		}
		
		log.info(colorMap);
		log.info(clarge + cmedium + csmall);

		model.addAttribute("colorMap", colorMap);
		model.addAttribute("sizeMap", sizeMap);
		return "product/productlist";
	}

	@GetMapping("/get")
	public void get(String bname, Model model) {
		log.info("/get");
		model.addAttribute("product", service.get(bname));
	}

	@GetMapping("/productlist")
	public void productlist() {
	}
}
