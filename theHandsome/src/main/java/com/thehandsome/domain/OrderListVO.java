package com.thehandsome.domain;

import lombok.Data;
import oracle.sql.DATE;

@Data
public class OrderListVO {
	private String oid;
	private String mid;
	private int ozipcode;
	private String oaddress1;
	private String oaddress2;
	private DATE odate;
	private String oreceiver;
	private String otel;
	private int ousedcoupon;
	private int opayment;
	private int ostatus;
	private DATE oaccountdeadline;
	private int odisocunted;
}
