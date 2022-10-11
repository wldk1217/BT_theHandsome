package com.thehandsome.domain;

import java.util.*;
import lombok.Data;

@Data
public class ReviewVO {
	private int rno;
	private String pid;
	private String mid;
	private String mname;
	private String pcolor;
	private String psize;
	private Date rdate;
	private int rrate;
	private int rprice;
	private String rtitle;
	private String rcontent;

}
