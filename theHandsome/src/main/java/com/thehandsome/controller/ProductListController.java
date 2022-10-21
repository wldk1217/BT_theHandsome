package com.thehandsome.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thehandsome.domain.ColorVO;
import com.thehandsome.domain.Criteria;
import com.thehandsome.domain.PageDTO;
import com.thehandsome.domain.ProductVO;
import com.thehandsome.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("")
@AllArgsConstructor
@Log4j
public class ProductListController {

	private ProductService service;

	@GetMapping("/list/{clarge}/{cmedium}/{csmall}")
	public String list(Criteria cri, Model model, @PathVariable("clarge") String clarge,
			@PathVariable("cmedium") String cmedium, @PathVariable("csmall") String csmall) {
		log.info("list: " + cri);
		List<ProductVO> list = service.getList(cri, clarge, cmedium, csmall);
		List<ColorVO> colorList = null;
		List<List<ColorVO>> colorMap = new ArrayList<>();
		model.addAttribute("list", list);
		int total = service.getTotal(clarge, cmedium, csmall);
		log.info("total = " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		for (int i = 0; i < list.size(); i++) {
			colorList = service.productGetColor(list.get(i).getPid());
			colorMap.add(colorList);
		}
		log.info(colorMap);
		log.info(clarge + cmedium + csmall);

		model.addAttribute("colorMap", colorMap);
		return "list";
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
