package com.motiveon.dto;

import java.util.Date;

public class WorkListDTO {

	private String wcode;
	private String wtitle;
	private String title;
	private Date wdate;
	private Date wend;
	private String ownerName; // EMPLOYEE.NAME 매핑용
	
	private int eno;
	private int dno;
	private int requesterEno;
	private String requesterName;
	private int managerEno;
	private String wstatus;
	private String managerName;
	private String statusName;
	private String id;
	private Date dueDate;
	private String categoryName;
	private String assigneeName;
	private String answer;
	private String statusLabel;
	
	
	
	public String getWstatus() {
		return wstatus;
	}

	public void setWstatus(String wstatus) {
		this.wstatus = wstatus;
	}

	public int getRequesterEno() {
		return requesterEno;
	}

	public void setRequesterEno(int requesterEno) {
		this.requesterEno = requesterEno;
	}

	public int getManagerEno() {
		return managerEno;
	}

	public void setManagerEno(int managerEno) {
		this.managerEno = managerEno;
	}


	public String getStatusLabel() {
		return statusLabel;
	}

	public void setStatusLabel(String statusLabel) {
		this.statusLabel = statusLabel;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getDno() {
		return dno;
	}

	public void setDno(int dno) {
		this.dno = dno;
	}

	public String getAssigneeName() {
		return assigneeName;
	}

	public void setAssigneeName(String assigneeName) {
		this.assigneeName = assigneeName;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getRequesterName() {
		return requesterName;
	}

	public void setRequesterName(String requesterName) {
		this.requesterName = requesterName;
	}

	public int getEno() {
		return eno;
	}

	public void setEno(int eno) {
		this.eno = eno;
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

	public String getOwnerName() {
		return ownerName;
	}

	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	

}
