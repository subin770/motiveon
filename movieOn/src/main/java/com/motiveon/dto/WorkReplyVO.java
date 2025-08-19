package com.motiveon.dto;

import java.util.Date;

public class WorkReplyVO {
    private int wrno;
    private String wrcontent;
    private String wcode;
    private int eno;
    private Date wrregdate;
    private String type;
	public int getWrno() {
		return wrno;
	}
	public void setWrno(int wrno) {
		this.wrno = wrno;
	}
	public String getWrcontent() {
		return wrcontent;
	}
	public void setWrcontent(String wrcontent) {
		this.wrcontent = wrcontent;
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
	public Date getWrregdate() {
		return wrregdate;
	}
	public void setWrregdate(Date wrregdate) {
		this.wrregdate = wrregdate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}   
    
    
    
}

