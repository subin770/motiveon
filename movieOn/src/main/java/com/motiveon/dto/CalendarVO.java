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
	private String color = "";
	private String catedetail = "";

	private static final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

	// 날짜 변환 로직을 start, end 세터 안 포함
	public void setStart(String start) {
		this.start = start;
		try {
			this.sdate = formatter.parse(start);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	public void setEnd(String end) {
		this.end = end;
		try {
			this.edate = formatter.parse(end);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	public String getStart() {
		return start;
	}

	public String getEnd() {
		return end;
	}

	public Date getSdate() {
		return sdate;
	}

	public Date getEdate() {
		return edate;
	}

	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}

	public void setEdate(Date edate) {
		this.edate = edate;
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

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = (color == null) ? "" : color;
	}

	public String getCatedetail() {
		return catedetail;
	}

	public void setCatedetail(String catedetail) {
		this.catedetail = (catedetail == null) ? "" : catedetail;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
