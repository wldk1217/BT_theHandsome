package com.thehandsome.domain;

import lombok.Data;

/*****************************************************
 * @function : Criteria
 * @author : 심지연
 * @Date : 2022.10.20
 ******************************************************/

@Data
public class Criteria {

	private int pageNum; // 페이지번호

	private int amount; // 한 페이지에 띄울 상품 개수

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public Criteria() {
		this(1, 12); // 1페이지 당 상품 12개
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + "]";
	}
}