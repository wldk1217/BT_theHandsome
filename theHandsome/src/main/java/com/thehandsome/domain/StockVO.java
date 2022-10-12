package com.thehandsome.domain;

import lombok.Data;

@Data
public class StockVO {
	private String pid; // 상품 품번
	private String ccolorcode; // 색상 코드
	private String ssize; // 재고 사이즈
	private int samount; // 재고 수량
}
