package com.motiveon.dto;

public class ObjectionDTO {
	private String wcode; // VARCHAR2(30)
	private int eno; // 신청자
	private String type; // 업무관련/일정관련/기타
	private String content;

	public ObjectionDTO() {
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}