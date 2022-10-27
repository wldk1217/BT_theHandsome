package com.thehandsome.domain;

import lombok.Getter;
import lombok.ToString;

/*****************************************************
 * @function : BoardPageDTO
 * @author : 구영모
 * @Date : 2022.10.20
 * 게시물의 페이징 처리를 위해 만든 DTO
 * 시작 페이지 끝  페이지 현재 페이지 등을 가져올 수 있다.
 *****************************************************/

@Getter
@ToString
public class BoardPageDTO {
	private int startPage; //현제 페이지 단위의 처음 페이지(단위:10)
	private int endPage; //현재 페이지 단위의 마지막 페이지 (단위:10)
	private boolean prev, next; //이전 페이지와 다음 페이지
	private int firstPage;//첫 페이지
	private int lastPage;//마지막 페이지
	
	private int total;//전체 게시글 수
	private BoardCriteria cri;//게시글vo
	
	
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
}
