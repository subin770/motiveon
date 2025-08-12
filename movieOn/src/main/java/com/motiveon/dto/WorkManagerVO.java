package com.motiveon.dto;

public class WorkManagerVO {
	  private int wmstep;
	  private String wcode;
	  private int eno;
	  private int isafter;   // 0/1
	  private String answer; // '대기' 기본
	public int getWmstep() {
		return wmstep;
	}
	public void setWmstep(int wmstep) {
		this.wmstep = wmstep;
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
	public int getIsafter() {
		return isafter;
	}
	public void setIsafter(int isafter) {
		this.isafter = isafter;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	  
	  
	  
	}