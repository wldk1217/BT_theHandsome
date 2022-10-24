package com.thehandsome.domain;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ReplyVO {		
	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date replyDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateDate;
}