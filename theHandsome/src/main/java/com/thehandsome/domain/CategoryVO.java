package com.thehandsome.domain;

import lombok.Data;

@Data
public class CategoryVO {
	private String clarge; // 카테고리 대분류
	private String cmedium; // 카테고리 중분류
	private String csmall; // 카테고리 소분류
}
