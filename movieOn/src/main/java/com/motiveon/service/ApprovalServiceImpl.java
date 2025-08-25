package com.motiveon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.motiveon.dao.ApprovalDAO;
import com.motiveon.dto.ApprovalVO;

@Service
public class ApprovalServiceImpl implements ApprovalService {

    private final ApprovalDAO approvalDAO;

    public ApprovalServiceImpl(ApprovalDAO approvalDAO) {
        this.approvalDAO = approvalDAO;
    }

    // ===== KPI =====
    @Override public int countUrgent()   { return approvalDAO.countUrgent(); }
    @Override public int countReturned() { return approvalDAO.countReturned(); }
    @Override public int countWaiting()  { return approvalDAO.countWaiting(); }
    @Override public int countOnHold()   { return approvalDAO.countOnHold(); }

    // ===== 대시보드/최근/진행/할일 =====
    @Override
    public List<ApprovalVO> findRecentDrafts(String period, String field, String q) {
        return approvalDAO.findRecentDrafts(period, field, q);
    }

    @Override
    public List<ApprovalVO> findOngoingDrafts() {
        return approvalDAO.findOngoingDrafts();
    }

    @Override
    public List<ApprovalVO> findMyTodo(Long eno) {
        return approvalDAO.findMyTodo(eno);
    }

    // ===== 문서함(열람) =====
    @Override
    public List<ApprovalVO> viewerList(Long eno, String period, String field, String q, int start, int end) {
        return approvalDAO.viewerList(eno, period, field, q, start, end);
    }

    @Override
    public int viewerListCount(Long eno, String period, String field, String q) {
        return approvalDAO.viewerListCount(eno, period, field, q);
    }

    // ===== 기안함 =====
    @Override
    public List<ApprovalVO> draftList(Long eno, String period, String field, String q, int start, int end) {
        return approvalDAO.draftList(eno, period, field, q, start, end);
    }

    @Override
    public int draftListCount(Long eno, String period, String field, String q) {
        return approvalDAO.draftListCount(eno, period, field, q);
    }

    // ===== 양식 =====
    @Override
    public List<Map<String, Object>> findFormClasses() {
        return approvalDAO.findFormClasses();
    }

    @Override
    public List<Map<String, Object>> findFormsAll() {
        return approvalDAO.findFormsAll();
    }

    @Override
    public Map<String, Object> getForm(String sformNo) {
        return approvalDAO.getForm(sformNo);
    }

    @Override
    public String newDocNo() {
        return approvalDAO.newDocNo();
    }

    // ===== 임시저장 =====
    @Override
    @Transactional
    public String saveTemp(ApprovalVO vo) {
        // selectKey(keyProperty="signNo")가 vo.setSignNo(...)를 채워줌
        approvalDAO.insertTempSave(vo);

        String signNo = vo.getSignNo();         // ★ getSignNo()만 사용
        approvalDAO.insertHistory(signNo, "TEMP_SAVE"); // ★ 파라미터명도 signNo로 통일

        return signNo;
    }

    // ===== 임시보관함 =====
    @Override
    public int tempListCount(Map<String, Object> p) {
        return approvalDAO.tempListCount(p);
    }

    @Override
    public List<ApprovalVO> tempList(Map<String, Object> p) {
        return approvalDAO.tempList(p);
    }

    @Override
    public Map<String, Object> getEmpBasic(Long eno) {
        return approvalDAO.getEmpBasic(eno);
    }
    
    // ===== 문서/결재선/참조자 저장 =====
    @Override
    @Transactional
    public String saveApproval(ApprovalVO vo) {
        // 1) 문서 저장
        approvalDAO.insertSignDoc(vo);

        // 2) 결재선 저장 (approvers 리스트)
        if (vo.getApprovers() != null && !vo.getApprovers().isEmpty()) {
            approvalDAO.insertSignLines(vo);
        }

        // 3) 참조자 저장 (refs 리스트)
        if (vo.getRefs() != null && !vo.getRefs().isEmpty()) {
            approvalDAO.insertSignRefs(vo);
        }

        // 4) 이력 저장
        approvalDAO.insertHistory(vo.getSignNo(), "DOC_SAVE");

        return vo.getSignNo();
    }
    
    @Override
    public int approveListCount(Long eno, String tab, String period, String field, String q) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno", eno);
        p.put("tab", tab);
        p.put("period", period);
        p.put("field", field);
        p.put("q", q);
        return approvalDAO.approveListCount(p);
    }

    @Override
    public List<Map<String, Object>> approveList(Long eno, String tab, String period, String field, String q, int start, int end) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno", eno);
        p.put("tab", tab);
        p.put("period", period);
        p.put("field", field);
        p.put("q", q);
        p.put("start", start);
        p.put("end", end);
        return approvalDAO.approveList(p);
    }
    

	@Override
	public int deleteTempDocs(List<String> signNos) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public Map<String,Object> getDetail(String signNo) {
	    ApprovalVO doc = approvalDAO.getSignDoc(signNo);
	    if (doc == null) return null;
	    List<ApprovalVO> lines = approvalDAO.selectSignLines(signNo);
	    List<ApprovalVO> refs  = approvalDAO.selectSignRefs(signNo);
	    Map<String,Object> res = new HashMap<>();
	    res.put("doc", doc);
	    res.put("lines", lines);
	    res.put("refs", refs);
	    return res;
	}

	@Transactional
	@Override
	public void actLine(String signNo, long eno, String action, String comment) {
	    int state; // 1=approve, 2=reject
	    if ("approve".equalsIgnoreCase(action)) state = 1;
	    else if ("reject".equalsIgnoreCase(action)) state = 2;
	    else throw new IllegalArgumentException("action must be approve/reject");

	    Map<String,Object> p = new HashMap<>();
	    p.put("signNo", signNo);
	    p.put("eno", eno);
	    p.put("state", state);

	    // ✅ 여기서 approvalDAO 사용
	    int updated = approvalDAO.actSignLine(p);
	    if (updated == 0) {
	        // 내 차례가 아니거나 이미 처리됨
	        throw new IllegalStateException("내 차례가 아니거나 이미 처리된 문서입니다.");
	    }

	    // 히스토리 남기기: 기존 방식과 동일하게
	    String msg = (state==1 ? "[승인]" : "[반려]") 
	               + (comment != null && !comment.isBlank() ? " " + comment : "");
	    approvalDAO.insertHistory(signNo, msg);

	    if (state == 1) {
	        // 모두 승인됐는지 체크 후 완료 처리
	        approvalDAO.completeDocIfAllApproved(signNo);
	    } else {
	        // 반려면 즉시 문서 반려 처리
	        approvalDAO.rejectDoc(signNo);
	    }
	}

	
	
    
}
