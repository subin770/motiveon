package com.motiveon.service;

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
}
