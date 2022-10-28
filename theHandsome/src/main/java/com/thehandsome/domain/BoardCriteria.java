package com.thehandsome.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


/*****************************************************
 * @function : BoardCriteria
 * @author : 구영모
 * @Date : 2022.10.20
 * 게시물의 페이징 처리를 위해 만든 VO
 * 1페이지에 10개의 게시물을 달 수 있다.
 *****************************************************/
@Getter
@Setter
@ToString
public class BoardCriteria {
	private int pageNum;//몇 페이지 인지 
	private int amount;//페이지 마다 몇개의 게시물을 달 것인지
	
	public BoardCriteria() {
		this(1,10);
	}
	public BoardCriteria(int pageNum, int amount) {
		this.amount = amount;
	}
}
