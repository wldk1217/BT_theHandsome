package com.thehandsome.domain;

import lombok.Data;

/*****************************************************
 * @function : OrderItem ���̺� VO
 * @author : ������
 * @Date : 2022.10.16
 ******************************************************/
@Data
public class OrderItemVO {
	//�ֹ� ��ȣ
	private String oid;
	//���� �ڵ�
	private String ccolorcode;
	//������
	private String ssize;
	//��ǰ id
	private String pid;
	//ȸ�� id
	private String mid;
	//�ֹ� ����
	private int oamount;
}
