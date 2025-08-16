package com.motiveon.dto;

public class WorkManagerVO {
	private int wmstep; // 0:요청자, 1:담당자, 2:협업, 3:대리
	private String wcode; // 업무코드
	private int eno; // 사번
	private int isafter; // 0/1
	private String answer; // REQUESTER / OWNER / ...

	public WorkManagerVO() {
	}

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
