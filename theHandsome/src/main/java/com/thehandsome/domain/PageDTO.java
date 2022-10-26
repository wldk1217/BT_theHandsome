package com.thehandsome.domain;

import lombok.Data;

/*****************************************************
 * @function : PageDTO
 * @author : 심지연
 * @Date : 2022.10.21
 ******************************************************/

@Data
public class PageDTO {
	private int startPage; // 페이지 시작번호
	private int endPage; // 페이지 끝 번호 
	private boolean prev, next; // (이전, 다음) 버튼 유무 확인
	private int realEnd; // 총 페이지 중 마지막 페이지 번호
	private int total; // 전체 행 개수
	private Criteria cri;

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount())); // 총 페이지 중 마지막 페이지 번호 구하기
		
		if (realEnd < this.endPage) // 페이지 끝 번호 확인
			this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

	@Override
	public String toString() {
		return "PageDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", realEnd=" + realEnd + ", total=" + total + ", cri=" + cri + "]";
	}
}
