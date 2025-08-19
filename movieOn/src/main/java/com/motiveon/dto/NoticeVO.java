package com.motiveon.dto;

import java.util.Date;

public class NoticeVO {
    private int nno;             // 공지사항 번호
    private String title;        // 제목
    private String content;      // 내용
    private Date regdate;        // 작성일
    private Date updatedate;     // 수정일
    private int viewcnt;         // 조회수
    private int eno;             // 작성자 번호
    private int dno;             // 부서 코드
    
    
    
    

    // 기본 생성자
    public NoticeVO() {
        this.viewcnt = 0;
        this.eno = 0;   // 기본값
        this.dno = 0;   // 기본값
        this.fixed   = "0";
    }



    // getter & setter
    public int getNno() {
        return nno;
    }

    public void setNno(int nno) {
        this.nno = nno;
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

    public Date getRegdate() {
        return regdate;
    }

    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }

    public Date getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Date updatedate) {
        this.updatedate = updatedate;
    }

    public int getViewcnt() {
        return viewcnt;
    }

    public void setViewcnt(int viewcnt) {
        this.viewcnt = viewcnt;
    }

    public int getEno() {
        return eno;
    }

    public void setEno(int eno) {
        this.eno = eno;
    }

    public int getDno() {
        return dno;
    }

    public void setDno(int dno) {
        this.dno = dno;
    }
    
    private String filename;

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }
    private String ename;

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }
    
    private String fixed;

    public String getFixed() {
        return fixed;
    }

    public void setFixed(String fixed) {
        this.fixed = fixed;
    }



}
