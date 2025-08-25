package com.motiveon.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class DepartmentVO {

    private int dno;           // 부서코드
    private String name;       // 부서명
    private int manager;       // 부서장
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createDate;   // 생성일
    private int enabled;       // 상태
    private int memberCount; // 추가
    private double joinRate;
    private double leaveRate;
    private String managerName;      // 부서장 이름
    private String managerPosition;  // 부서장 직책 (employee.job)
    
    public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getManagerPosition() {
		return managerPosition;
	}

	public void setManagerPosition(String managerPosition) {
		this.managerPosition = managerPosition;
	}

	public int getMemberCount() {
		return memberCount;
	}

	public double getJoinRate() {
		return joinRate;
	}

	public void setJoinRate(double joinRate) {
		this.joinRate = joinRate;
	}

	public double getLeaveRate() {
		return leaveRate;
	}

	public void setLeaveRate(double leaveRate) {
		this.leaveRate = leaveRate;
	}

	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}

	// 기본 생성자
    public DepartmentVO() {}

    // 전체 생성자
    public DepartmentVO(int dno, String name, int manager, Date createDate, int enabled) {
        this.dno = dno;
        this.name = name;
        this.manager = manager;
        this.createDate = createDate;
        this.enabled = enabled;
    }

    // getter / setter
    public int getDno() {
        return dno;
    }

    public void setDno(int dno) {
        this.dno = dno;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getManager() {
        return manager;
    }

    public void setManager(int manager) {
        this.manager = manager;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) 
    { this.createDate = createDate; 
    }


    public int getEnabled() {
        return enabled;
    }

    public void setEnabled(int enabled) {
        this.enabled = enabled;
    }

    @Override
    public String toString() {
        return "DepartmentVO [dno=" + dno + ", name=" + name + ", manager=" + manager + ", createDate=" + createDate
                + ", enabled=" + enabled + "]";
    }
}