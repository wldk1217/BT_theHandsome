package com.thehandsome.domain;

import lombok.Data;

@Data
public class ProductVO {
	private String pid; // ��ǰ ǰ��
	private int bno; // �귣�� ��ȣ
	private String clarge; // ī�װ� ��з�
	private String cmedium; // ī�װ� �ߺз�
	private String csmall; // ī�װ� �Һз�
	private int pno; // ��ǰ ��ȣ
	private String pname; // ��ǰ �̸�
	private int pprice; // ��ǰ ����
	private String pdetail; // ��ǰ ������
	private int ptotalamount; // ��ǰ ����
}
