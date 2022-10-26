package com.thehandsome.domain;

import lombok.Data;

/*****************************************************
 * @function : StockVO
 * @author : 심지연
 * @Date : 2022.10.19
 ******************************************************/

@Data
public class StockVO {
	private String pid; // 상품품번
	private String ccolorcode; // 색상코드
	private String ssize; // 재고사이즈
	private int samount; // 재고수량
}
