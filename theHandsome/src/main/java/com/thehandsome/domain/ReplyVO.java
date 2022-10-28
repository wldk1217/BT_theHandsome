package com.thehandsome.domain;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
/*****************************************************
 * @function : ReplyVO
 * @author : 구영모
 * @Date : 2022.10.23
 * 게시물의 댓글과 관련된VO
 *****************************************************/

@Data
public class ReplyVO {		
	private Long rno; //댓글 번호
	private Long bno; //댓글이 달린 게시판 번호
	private String reply; //댓글 내용
	private String replyer; //댓글을 단 사람의 이름
	@DateTimeFormat(pattern="yyyy-MM-dd")//날짜형식 데이터 포맷팅
	private Date replyDate; //답변날짜
	@DateTimeFormat(pattern="yyyy-MM-dd")//날짜형식 데이터 포맷팅
	private Date updateDate;//답변 수정 날짜
}
