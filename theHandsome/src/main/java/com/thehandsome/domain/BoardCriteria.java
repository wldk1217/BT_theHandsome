package com.thehandsome.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardCriteria {
	private int pageNum;
	private int amount;
	
	public BoardCriteria() {
		this(1,10);
	}
	public BoardCriteria(int pageNum, int amount) {
		this.amount = amount;
	}
}
