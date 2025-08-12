package com.motiveon.dto;

import java.util.Date;

public class WorkVO {
	private String wcode;
	private String wtitle;
	private Date wdate;
	private Date wend;
	private int wopen;
	private int walarm;
	private int eno;
	private String wstatus;
	private int dno;
	public String getWcode() {
		return wcode;
	}
	public void setWcode(String wcode) {
		this.wcode = wcode;
	}
	public String getWtitle() {
		return wtitle;
	}
	public void setWtitle(String wtitle) {
		this.wtitle = wtitle;
	}
	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}
	public Date getWend() {
		return wend;
	}
	public void setWend(Date wend) {
		this.wend = wend;
	}
	public int getWopen() {
		return wopen;
	}
	public void setWopen(int wopen) {
		this.wopen = wopen;
	}
	public int getWalarm() {
		return walarm;
	}
	public void setWalarm(int walarm) {
		this.walarm = walarm;
	}
	public int getEno() {
		return eno;
	}
	public void setEno(int eno) {
		this.eno = eno;
	}
	public String getWstatus() {
		return wstatus;
	}
	public void setWstatus(String wstatus) {
		this.wstatus = wstatus;
	}
	public int getDno() {
		return dno;
	}
	public void setDno(int dno) {
		this.dno = dno;
	}
	
	
}
