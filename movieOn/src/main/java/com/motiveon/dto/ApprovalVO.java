package com.motiveon.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class ApprovalVO implements Serializable {
    private static final long serialVersionUID = 1L;

    // ===== VIEW/별칭 =====
    private String title;
    private Long   drafterNo;
    private Integer deptNo;
    private String  formNo;      // ← 화면에서 쓰는 결재양식 (실제는 sformno와 동일 문자열)
    private Date   draftAt;
    private Date   updateAt;
    private Date   completeAt;
    private Integer tempSave;
    private Integer docStatus;
    private Integer emergency;

    // ===== SIGNLINE =====
    private Long   routeNo;
    private Long   approverNo;
    private Integer orderSeq;
    private Integer routeStatus;
    private Date   actionAt;

    // ===== EMPLOYEE =====
    private String  approverName;
    private Integer approverDept;

    // ===== DB 원본 =====
    private String  signNo;      // PK (예: SG2508130001)
    private Long    eno;
    private Long    dno;
    private String  sformno;     // DB의 SFORMNO (VARCHAR2)
    private Date    ddate;
    private Date    edate;
    private String  signcontent;
    private Integer tempsave;
    private Integer state;

    // ===== 보조 표시 필드 =====
    private String  formName;
    private String  drafterName;
    private String  deptName;
    private Integer attachCnt;
    
    
    private String content;     // 내용
    private Date regDate;       // 등록일
    private Date updateDate;    // 수정일
    
 // 결재선 (결재자 목록)
    private List<Long> approvers;

    // 참조자 (참조자 목록)
    private List<Long> refs;


    public ApprovalVO() {}

    public ApprovalVO(String signno, Long eno, Long dno, String sformno, Date ddate,
                      Integer emergency, String title, Date edate, String signcontent,
                      Integer tempsave, Integer state) {
        this.signNo = signno;
        this.eno = eno;
        this.dno = dno;
        this.sformno = sformno;
        this.ddate = ddate;
        this.emergency = emergency;
        this.title = title;
        this.edate = edate;
        this.signcontent = signcontent;
        this.tempsave = tempsave;
        this.state = state;

        this.drafterNo = eno;
        this.deptNo = dno == null ? null : dno.intValue();
        this.draftAt = ddate;
        this.completeAt = edate;
        this.tempSave = tempsave;
        this.docStatus = state;

        // 화면용 formNo 동기화
        this.formNo = sformno;
    }

    /* -------- 편의 -------- */
    public boolean isTemp() {
        return (tempsave != null && tempsave == 1) || (tempSave != null && tempSave == 1);
    }


    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Long getDrafterNo() { return drafterNo; }
    public void setDrafterNo(Long drafterNo) { this.drafterNo = drafterNo; this.eno = drafterNo; }

    public Integer getDeptNo() { return deptNo; }
    public void setDeptNo(Integer deptNo) { this.deptNo = deptNo; this.dno = deptNo == null ? null : deptNo.longValue(); }

    public String getFormNo() {                 // ★ 핵심: null 반환 금지
        return (formNo != null) ? formNo : sformno;
    }
    public void setFormNo(String formNo) {
        this.formNo = formNo;
        this.sformno = formNo;
    }

    public Date getDraftAt() { return draftAt; }
    public void setDraftAt(Date draftAt) { this.draftAt = draftAt; this.ddate = draftAt; }

    public Date getUpdateAt() { return updateAt; }
    public void setUpdateAt(Date updateAt) { this.updateAt = updateAt; }

    public Date getCompleteAt() { return completeAt; }
    public void setCompleteAt(Date completeAt) { this.completeAt = completeAt; this.edate = completeAt; }

    public Integer getTempSave() { return tempSave; }
    public void setTempSave(Integer tempSave) { this.tempSave = tempSave; this.tempsave = tempSave; }

    public Integer getDocStatus() { return docStatus; }
    public void setDocStatus(Integer docStatus) { this.docStatus = docStatus; this.state = docStatus; }

    public Integer getEmergency() { return emergency; }
    public void setEmergency(Integer emergency) { this.emergency = emergency; }

    /* -------- SIGNLINE -------- */
    public Long getRouteNo() { return routeNo; }
    public void setRouteNo(Long routeNo) { this.routeNo = routeNo; }

    public Long getApproverNo() { return approverNo; }
    public void setApproverNo(Long approverNo) { this.approverNo = approverNo; }

    public Integer getOrderSeq() { return orderSeq; }
    public void setOrderSeq(Integer orderSeq) { this.orderSeq = orderSeq; }

    public Integer getRouteStatus() { return routeStatus; }
    public void setRouteStatus(Integer routeStatus) { this.routeStatus = routeStatus; }

    public Date getActionAt() { return actionAt; }
    public void setActionAt(Date actionAt) { this.actionAt = actionAt; }

    /* -------- EMP -------- */
    public String getApproverName() { return approverName; }
    public void setApproverName(String approverName) { this.approverName = approverName; }

    public Integer getApproverDept() { return approverDept; }
    public void setApproverDept(Integer approverDept) { this.approverDept = approverDept; }

    /* -------- DB 원본 -------- */
    public String getSignNo() {                 // ★ 표준 게터만 유지
        return signNo;
    }
    public void setSignNo(String signNo) {      // ★ 표준 세터만 유지
        this.signNo = signNo;
    }

    public Long getEno() { return eno; }
    public void setEno(Long eno) { this.eno = eno; if (this.drafterNo == null) this.drafterNo = eno; }

    public Long getDno() { return dno; }
    public void setDno(Long dno) { this.dno = dno; if (this.deptNo == null && dno != null) this.deptNo = dno.intValue(); }

    public String getSformno() {                // ★ 파라미터 바인딩에 필요
        return sformno;
    }
    public void setSformno(String sformno) {
        this.sformno = sformno;
        if (this.formNo == null) this.formNo = sformno;
    }

    public Date getDdate() { return ddate; }
    public void setDdate(Date ddate) { this.ddate = ddate; if (this.draftAt == null) this.draftAt = ddate; }

    public Date getEdate() { return edate; }
    public void setEdate(Date edate) { this.edate = edate; if (this.completeAt == null) this.completeAt = edate; }

    public String getSigncontent() { return signcontent; }
    public void setSigncontent(String signcontent) { this.signcontent = signcontent; }

    public Integer getTempsave() { return tempsave; }
    public void setTempsave(Integer tempsave) { this.tempsave = tempsave; if (this.tempSave == null) this.tempSave = tempsave; }

    /* -------- 보조 -------- */
    public String getFormName() { return formName; }
    public void setFormName(String formName) { this.formName = formName; }

    public String getDrafterName() { return drafterName; }
    public void setDrafterName(String drafterName) { this.drafterName = drafterName; }

    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }

    public Integer getAttachCnt() { return attachCnt; }
    public void setAttachCnt(Integer attachCnt) { this.attachCnt = attachCnt; }
    

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getRegDate() { return regDate; }
    public void setRegDate(Date regDate) { this.regDate = regDate; }

    public Date getUpdateDate() { return updateDate; }
    public void setUpdateDate(Date updateDate) { this.updateDate = updateDate; }


    public List<Long> getApprovers() { return approvers; }
    public void setApprovers(List<Long> approvers) { this.approvers = approvers; }

    public List<Long> getRefs() { return refs; }
    public void setRefs(List<Long> refs) { this.refs = refs; }

    @Override
    public String toString() {
        return "ApprovalVO{signNo=" + signNo + ", title=" + title + ", eno=" + eno +
               ", dno=" + dno + ", sformno=" + sformno + ", ddate=" + ddate +
               ", state=" + state + ", tempsave=" + tempsave + "}";
    }
}
