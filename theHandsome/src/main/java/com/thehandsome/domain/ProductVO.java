package com.thehandsome.domain;

import lombok.Data;

@Data
public class ProductVO {
	private String pid; // 상품 품번
	private int bno; // 브랜드 번호
	private String clarge; // 카테고리 대분류
	private String cmedium; // 카테고리 중분류
	private String csmall; // 카테고리 소분류
	private int pno; // 상품 번호
	private String pname; // 상품 이름
	private int pprice; // 상품 가격
	private String pdetail; // 상품 상세정보
	private int ptotalamount; // 상품 수량
}
