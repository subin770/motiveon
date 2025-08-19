package com.motiveon.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class WorkVO {
    private String wcode;       // 업무코드
    private String wtitle;      // 업무제목
    private String wcontent;    // 업무내용
    private Date wdate;         // 등록일
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date wend;          // 마감일
    private int wopen;          // 공개여부 0/1
    private int walarm;         // 알림여부 0/1
    private int eno;            // 업무신청자
    private String wstate;      // 상태 코드 (WAIT / ING / DONE / REJECT / DELEGATE)
    private String wstatus;     // 상태 한글명 (대기 / 진행 / 완료 / 반려 / 대리)
    private int dno;            // 부서코드
    
    private int requesterEno;     // 요청자
    private int managerEno;       // 담당자

    
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

	private MultipartFile[] files;

    public MultipartFile[] getFiles() {
		return files;
	}
	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}
	// === Getter / Setter ===
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

    public String getWcontent() {
        return wcontent;
    }
    public void setWcontent(String wcontent) {
        this.wcontent = wcontent;
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

    public int getWopen() {
        return wopen;
    }
    public void setWopen(int wopen) {
        this.wopen = wopen;
    }

    public int getWalarm() {
        return walarm;
    }
    public void setWalarm(int walarm) {
        this.walarm = walarm;
    }

    public int getEno() {
        return eno;
    }
    public void setEno(int eno) {
        this.eno = eno;
    }

    public String getWstate() {
        return wstate;
    }
    public void setWstate(String wstate) {
        this.wstate = wstate;
    }

    public String getWstatus() {
        return wstatus;
    }
    public void setWstatus(String wstatus) {
        this.wstatus = wstatus;
    }

    public int getDno() {
        return dno;
    }
    public void setDno(int dno) {
        this.dno = dno;
    }

    // === 헬퍼 메서드: 상태 코드 → 한글 라벨 변환 ===
    public String getStatusLabel() {
        if (wstate == null) return "-";
        switch (wstate) {
            case "WAIT": return "대기";
            case "ING": return "진행";
            case "DONE": return "완료";
            case "REJECT": return "반려";
            case "DELEGATE": return "대리";
            default: return "-";
        }
    }
}
