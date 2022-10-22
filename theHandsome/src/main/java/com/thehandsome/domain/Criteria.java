package com.thehandsome.domain;

import lombok.Data;

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