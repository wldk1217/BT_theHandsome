package com.thehandsome.domain;

import java.util.*;
import lombok.Data;

@Data
public class EventVO {
	private int eid;
	private String ename;
	private String edetail;
	private Date estartDate;
	private Date eendDate;
	private String eimage;
	private int eamount;
	private int elimit;
}
