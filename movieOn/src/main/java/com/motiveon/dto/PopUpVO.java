package com.motiveon.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class PopUpVO {
	private String popNo;       
	private String title="";    
	private String content="";   
	//private String sformNo;	  
	private int enabled;
    @DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date deadLine;
	public String getPopNo() {
		return popNo;
	}
    private List<AttachmentVO> attachList = new ArrayList<>();

	
	
	public List<AttachmentVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<AttachmentVO> attachList) {
		this.attachList = attachList;
	}
	public void setPopNo(String popNo) {
		this.popNo = popNo;
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
//	public String getSformNo() {
//		return sformNo;
//	}
//	public void setSformNo(String sformNo) {
//		this.sformNo = sformNo;
//	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public Date getDeadLine() {
		return deadLine;
	}
	public void setDeadLine(Date deadLine) {
		this.deadLine = deadLine;
	}
	
	

}
