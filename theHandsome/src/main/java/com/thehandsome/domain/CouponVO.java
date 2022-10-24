package com.thehandsome.domain;

import java.util.*;
import lombok.Data;

@Data
public class CouponVO {
	private String ccode;
	private String mid;
	private String cname;
	private Date cstartDate;
	private Date cendDate;
	private int cstate;
}
