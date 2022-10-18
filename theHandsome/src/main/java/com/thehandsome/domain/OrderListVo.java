package com.thehandsome.domain;

import lombok.Data;

@Data
public class OrderListVo {
	private String oid;
	private String mid;
	private int ozipcode;
	private String oaddress1;
	private String oaddress2;
	private String oreceiver;
	private String otel;
	private int ousedcoupon;
	private int opayment;
	private int ostatus;
	private int odisocunted;
}
