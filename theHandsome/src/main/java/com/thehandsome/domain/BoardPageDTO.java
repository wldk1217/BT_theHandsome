package com.thehandsome.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class BoardPageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int firstPage;
	private int lastPage;
	
	private int total;
	private BoardCriteria cri;
	
	
	public BoardPageDTO(BoardCriteria cri,int total) {
		
		this.total = total;
		this.cri = cri;
		
		this.endPage = (int) (Math.ceil( cri.getPageNum() /10.0)) * 10;
		
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)  Math.ceil( (total * 1.0) / cri.getAmount() ) ;
		//첫번째 페이지
		this.firstPage = 1;
		//마지막 페이지
		this.lastPage = realEnd;
		System.out.println("realEnd : "+realEnd);
		
		if ( realEnd < this.endPage) {
			this.endPage = realEnd;
		}//end if
		
		
		this.prev = (this.startPage > 1);		
		this.next = (this.endPage < realEnd);		
	}//end PageDTO
}//end class
