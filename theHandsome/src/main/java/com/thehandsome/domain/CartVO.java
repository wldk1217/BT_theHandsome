package com.thehandsome.domain;

import lombok.Data;

@Data
public class CartVO {
	private String mid;
	private String pid;
	private String psize;
	private String pcolor;
	private int pamount ;
}
