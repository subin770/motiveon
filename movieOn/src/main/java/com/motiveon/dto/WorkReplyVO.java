package com.motiveon.dto;

import java.util.Date;

public class WorkReplyVO {
	private String wrno; // VARCHAR2(30) (시퀀스 값 TO_CHAR로 넣을 예정)
	private String wrcontent;
	private Date wrregdate;
	private Date updatedate;
	private String wcode; // VARCHAR2(30)
	private int eno;
	 private String type; 
	 
	 

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public WorkReplyVO() {
	}

	public String getWrno() {
		return wrno;
	}

	public void setWrno(String wrno) {
		this.wrno = wrno;
	}

	public String getWrcontent() {
		return wrcontent;
	}

	public void setWrcontent(String wrcontent) {
		this.wrcontent = wrcontent;
	}

	public Date getWrregdate() {
		return wrregdate;
	}

	public void setWrregdate(Date wrregdate) {
		this.wrregdate = wrregdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public String getWcode() {
		return wcode;
	}

	public void setWcode(String wcode) {
		this.wcode = wcode;
	}

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}
}