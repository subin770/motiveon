package com.motiveon.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class WorkVO {
	private String wcode; // VARCHAR2(30)
	private String wtitle;
	private String wcontent;
	private Date wdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date wend;
	private int wopen; // 0/1
	private int walarm; // 0/1
	private int eno; // NUMBER(8,0)
	private String wstatus; // WAIT / PROG / ...
	private int dno; // NUMBER(3,0)

	public WorkVO() {
	}

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

	public String getWcontent() {
		return wcontent;
	}

	public void setWcontent(String wcontent) {
		this.wcontent = wcontent;
	}

}