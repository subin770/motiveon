package com.motiveon.dto;


import java.util.Date;

public class ObjectionDTO {
    private int ono;          // 이의신청 PK
    private String wcode;     // 관련 업무코드 (FK)
    private int eno;          // 이의신청자 사번
    private String content;   // 이의신청 사유
    private Date regdate;     // 등록일자

    // getter/setter
    public int getOno() {
        return ono;
    }
    public void setOno(int ono) {
        this.ono = ono;
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
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public Date getRegdate() {
        return regdate;
    }
    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }
}