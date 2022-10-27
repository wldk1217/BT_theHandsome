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
		
		// 대-중-소 분류 product로 담아 view로 넘겨주기
		ProductVO productCategory = new ProductVO(clarge, cmedium, csmall);
		model.addAttribute("product", productCategory);

		// 상품 페이징된 리스트 
		List<ProductVO> list = service.getList(cri, clarge, cmedium, csmall);
		log.info("리스트: " + list);
		model.addAttribute("list", list);
		
		List<ColorVO> colorList = null;
		List<String> sizeList = null;
		List<List<ColorVO>> colorMap = new ArrayList<>();
		List<List<String>> sizeMap = new ArrayList<>();
	
		int total = service.getTotal(clarge, cmedium, csmall);
		log.info("total = " + total);
		
		// 페이징 처리를 위해 view로 넘김
		model.addAttribute("pager", new ProductPageDTO(cri, total));
		// 총 상품 개수 처리를 위해 view로 넘김
		model.addAttribute("totalProducts", total);

		// 컬러와 사이즈 받아 저장
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
