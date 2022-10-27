package com.thehandsome.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thehandsome.domain.BoardVO;
import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardPageDTO;
import com.thehandsome.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


/*****************************************************
 * @function : BoardController
 * @author : 구영모
 * @Date : 2022.10.22
 *****************************************************/

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	//BoardService
	@Autowired
	private BoardService service;
	 
	@GetMapping("/list")
	public void list(BoardCriteria cri, Model model) throws Exception{
		log.info("list"+cri);
		//페이징 처리한 목록 리스트 
		model.addAttribute("list", service.getListWithPaging(cri));
		
		int total = service.getTotal(cri);
		//총 개수
		model.addAttribute("count", total);
		log.info("total : " + total);
		model.addAttribute("pageMaker",new BoardPageDTO(cri, total));
	}
	
	@GetMapping("/insert")
	public void register() {
		log.info("게시판 등록 페이지 ");
	}

	//insert 후에 리스트 페이지 첫 화면으로 이동
	@PostMapping("/insert")
	public String insert(BoardVO board, RedirectAttributes rttr) throws Exception{
		log.info("게시판 insert 시작");
		service.insert(board);
		rttr.addFlashAttribute("inserted", board.getQid());
		return "redirect:/board/list?pageNum=1&amount=10";
	}
	@GetMapping({"/read","/update"})
	public void read(@RequestParam("qid")long qid, Model model, @ModelAttribute("cri")BoardCriteria cri) throws Exception {
		log.info("read or update...");
		model.addAttribute("board", service.read(qid));
	}
	@PostMapping("/update")
	public String update(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri")BoardCriteria cri) throws Exception {
		log.info("update:"+board);
		if(service.update(board)) {
			rttr.addFlashAttribute("result","success");
		}
		else {
			log.info("실패");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		return "redirect:/board/list";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("qid")long qid, RedirectAttributes rttr)throws Exception{
		log.info("remove..."+qid);
		if(service.delte(qid)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list?pageNum=1&amount=10";
	}
	
	
}
