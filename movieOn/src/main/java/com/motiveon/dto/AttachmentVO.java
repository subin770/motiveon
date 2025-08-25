package com.motiveon.dto;

import java.util.Date;

public class AttachmentVO {

    private int ano;           // ANO
    private String uploadPath; // UPLOADPATH
    private String fileName;   // FILENAME
    private String fileType;   // FILETYPE
    private Integer pno;       // PNO (nullable)
    private String attacher;   // ATTACHER
    private Date regDate;      // REGDATE

    // 기본 생성자
    public AttachmentVO() {}

    // Getter / Setter
    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public String getAttacher() {
        return attacher;
    }

    public void setAttacher(String attacher) {
        this.attacher = attacher;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

}