package com.thehandsome.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thehandsome.domain.BoardVO;
import com.thehandsome.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	 
	@GetMapping("/list")
	public void list(Model model) throws Exception{
		log.info("list");
		model.addAttribute("list", service.getList());
	}
	
	@GetMapping("/insert")
	public String insert(BoardVO board, RedirectAttributes rttr) throws Exception{
		log.info("게시판 insert 시작");
		service.insert(board);
		rttr.addFlashAttribute("insert", board.getQid());
		return "redirect:/board/list";
	}
}
