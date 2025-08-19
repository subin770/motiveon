package com.motiveon.dto;

import java.util.Date;

public class HrVO {

	private int eno;
	private String workDate;
	private int state;
	private int hrTime;
	private int overTime;
	private Date onTime;
	private Date offTime;
	private String hrcode;
	private int reqChange;
	private int stdTime;
	private String day;

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
	}

	public String getWorkDate() {
		return workDate;
	}

	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getHrTime() {
		return hrTime;
	}

	public void setHrTime(int hrTime) {
		this.hrTime = hrTime;
	}

	public int getOverTime() {
		return overTime;
	}

	public void setOverTime(int overTime) {
		this.overTime = overTime;
	}

	public Date getOnTime() {
		return onTime;
	}

	public void setOnTime(Date onTime) {
		this.onTime = onTime;
	}

	public Date getOffTime() {
		return offTime;
	}

	public void setOffTime(Date offTime) {
		this.offTime = offTime;
	}

	public String getHrcode() {
		return hrcode;
	}

	public void setHrcode(String hrcode) {
		this.hrcode = hrcode;
	}

	public int getReqChange() {
		return reqChange;
	}

	public void setReqChange(int reqChange) {
		this.reqChange = reqChange;
	}

	public int getStdTime() {
		return stdTime;
	}

	public void setStdTime(int stdTime) {
		this.stdTime = stdTime;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}
	
}
