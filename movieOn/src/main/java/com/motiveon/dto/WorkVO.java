// com.motiveon.dto.WorkVO
package com.motiveon.dto;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class WorkVO {
    private String wcode;          
    private String wtitle;        
    private Date wdate;            
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date wend;            
    private Integer wopen;        
    private Integer walarm;       
    private Integer eno;        
    private String wstatus;       
    private Integer dno;          

    // 화면/등록용 확장 필드
    private Integer managerEno;    
    private String  wcontent;      
    private String  managerName;
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
	public Integer getWopen() {
		return wopen;
	}
	public void setWopen(Integer wopen) {
		this.wopen = wopen;
	}
	public Integer getWalarm() {
		return walarm;
	}
	public void setWalarm(Integer walarm) {
		this.walarm = walarm;
	}
	public Integer getEno() {
		return eno;
	}
	public void setEno(Integer eno) {
		this.eno = eno;
	}
	public String getWstatus() {
		return wstatus;
	}
	public void setWstatus(String wstatus) {
		this.wstatus = wstatus;
	}
	public Integer getDno() {
		return dno;
	}
	public void setDno(Integer dno) {
		this.dno = dno;
	}
	public Integer getManagerEno() {
		return managerEno;
	}
	public void setManagerEno(Integer managerEno) {
		this.managerEno = managerEno;
	}
	public String getWcontent() {
		return wcontent;
	}
	public void setWcontent(String wcontent) {
		this.wcontent = wcontent;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}   


}
