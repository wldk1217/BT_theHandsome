package com.thehandsome.domain;

import lombok.Data;
import oracle.sql.DATE;

/*****************************************************
 * @function : ProductVO
 * @author : 심지연
 * @Date : 2022.10.19
 ******************************************************/

@Data
public class ProductVO {
	private String pid; // 상품품번
	private String ccolorcode; // 색상코드
	private String bname; // 브랜드 이름
	private String clarge; // 대분류
	private String cmedium; // 중분류
	private String csmall; // 소분류
	private String pname; // 상품이름
	private int pprice; // 상품가격
	private String pdetail; // 상품상세
	private String pinfo; // 상품정보
	private String pitem;
	private String pmaterial;
	private String pcolor;
	private String psize;
	private String pcountry;
	private String pmanufacturer;
	private DATE pmadedate;
	private DATE pdate;
	
	public ProductVO() {
		super();
	}

	public ProductVO(String clarge, String cmedium, String csmall) {
		super();
		this.clarge = clarge;
		this.cmedium = cmedium;
		this.csmall = csmall;
	}
}
