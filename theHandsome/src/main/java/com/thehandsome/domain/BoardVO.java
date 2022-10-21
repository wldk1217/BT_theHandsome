package com.thehandsome.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
//작성자 구영모
@Data
public class BoardVO {
	private long qid;
	private String mid;
	private String qtitle;
	private String qcontent;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date qdate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date qreplydate;
	private String qreplytitle;
	private String qreplycontent;
	private String qmanager;
}
