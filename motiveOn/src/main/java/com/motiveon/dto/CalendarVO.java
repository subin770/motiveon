package com.motiveon.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class CalendarVO {

	private String ccode;
	private int catecode;
	private String title;
	private String content;
	private String start;
	private String end;
	private Date sdate;
	private Date edate;
	private int eno;
	private String catedetail;
	private String color = "";
	
	
	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getCatedetail() {
		return catedetail;
	}

	public void setCatedetail(String catedetail) {
		this.catedetail = catedetail;
	}

	public String getCcode() {
		return ccode;
	}

	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	public int getCatecode() {
		return catecode;
	}

	public void setCatecode(int catecode) {
		this.catecode = catecode;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}


	public Date getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		System.out.println(sdate);
		try {
			this.sdate = sdf.parse(sdate);
			System.out.println(this.sdate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	public Date getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		System.out.println(edate);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		try {
			this.edate = sdf.parse(edate);
			System.out.println(this.edate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}

}
