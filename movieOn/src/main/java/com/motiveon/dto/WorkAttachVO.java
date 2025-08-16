package com.motiveon.dto;

public class WorkAttachVO {
	private int wano; // 시퀀스 사용 예정
	private String uploadpath;
	private String filename;
	private String filetype;
	private String wcode; // VARCHAR2(30)

	public WorkAttachVO() {
	}

	public int getWano() {
		return wano;
	}

	public void setWano(int wano) {
		this.wano = wano;
	}

	public String getUploadpath() {
		return uploadpath;
	}

	public void setUploadpath(String uploadpath) {
		this.uploadpath = uploadpath;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getWcode() {
		return wcode;
	}

	public void setWcode(String wcode) {
		this.wcode = wcode;
	}
}
