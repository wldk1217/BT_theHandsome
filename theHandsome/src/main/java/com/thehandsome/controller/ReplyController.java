package com.thehandsome.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;
import com.thehandsome.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor


/*
 * @작성자 : 구영모 
 */

public class ReplyController {
	
	@Autowired
	private ReplyService service;
	
	
	//게시글 댓글 삭제
	@DeleteMapping(value="/{rno}", 
					produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno")Long rno)throws Exception{
		log.info("remove reply rno : "+rno);
		return (service.remove(rno)==1) ?new ResponseEntity<>("success", HttpStatus.OK)
										:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//게시글의 댓글 목록 확인
	@GetMapping(value="/pages/{bno}/{page}",
					produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE}	)
	public ResponseEntity<List<ReplyVO>> getList(
						@PathVariable("page")int page,
						@PathVariable("bno")Long bno) throws Exception{
		log.info("get replylist.....");
		
		BoardCriteria cri = new BoardCriteria(page, 10);
		log.info(cri);
		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
	}
	
	//게시글 댓글 달기
	@PostMapping(value = "/new",
			consumes = "application/json" //요청 줄이기
			,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) throws Exception{
		
		log.info("ReplyVO" + vo);	
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		//삼항식 conditional operator
		return ( insertCount == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR)
		);		
	}//end create
	
	//게시글 댓글 조회
	@GetMapping(value = "/{rno}",
					produces = {MediaType.APPLICATION_XML_VALUE,
									MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno)throws Exception{
		log.info("get" + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK );
	}
	
	//게시글 댓글 수정
	@RequestMapping(value="/{rno}",
					method = {RequestMethod.PUT, RequestMethod.PATCH},
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
					@RequestBody ReplyVO vo,
					@PathVariable("rno")Long rno)throws Exception{
		vo.setRno(rno);
		log.info("reply rno : " + rno);
		log.info("modify : " + vo);
		return (service.modify(vo)==1 ?new ResponseEntity<>("success", HttpStatus.OK)
									  :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR));
	}
			
	
}//end class