package com.thehandsome.domain;

import lombok.Data;

/*****************************************************
 * @function : Criteria
 * @author : 심지연
 * @Date : 2022.10.20
 ******************************************************/

@Data
public class Criteria {

	private int pageNum;

	private int amount;

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public Criteria() {
		this(1, 12);
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + "]";
	}
}