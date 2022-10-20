package com.thehandsome.domain;

import lombok.Data;
import oracle.sql.DATE;

@Data
public class ProductVO {
	private String pid; // ��ǰ ǰ��
	private String bname; // 브랜드 이름
	private String clarge; // ī�װ� ��з�
	private String cmedium; // ī�װ� �ߺз�
	private String csmall; // ī�װ� �Һз�
	private String pname; // ��ǰ �̸�
	private int pprice; // ��ǰ ����
	private String pdetail; // ��ǰ ������
	private String pinfo;
	private String pitem;
	private String pmaterial;
	private String pcolor;
	private String psize;
	private String pcountry;
	private String pmanufacturer;
	private DATE pmadedate;
	private DATE pdate;
}
