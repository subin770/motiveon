package com.motiveon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.motiveon.dto.ApprovalVO;

public class ApprovalDAOImpl implements ApprovalDAO {

    private static final String NS = "Approval-Mapper.";
    private final SqlSession session;

    public ApprovalDAOImpl(SqlSession session) {
        this.session = session;
    }

    // ---------- KPI ----------
    @Override
    public int countUrgent()   { return session.selectOne(NS + "countUrgent"); }
    @Override
    public int countReturned() { return session.selectOne(NS + "countReturned"); }
    @Override
    public int countWaiting()  { return session.selectOne(NS + "countWaiting"); }
    @Override
    public int countOnHold()   { return session.selectOne(NS + "countOnHold"); }

    // ---------- 메인 카드/목록 ----------
    @Override
    public List<ApprovalVO> findRecentDrafts(String period, String field, String q) {
        Map<String, Object> p = new HashMap<>();
        p.put("period", period);
        p.put("field",  field);
        p.put("q",      q);
        return session.selectList(NS + "selectRecentDrafts", p);
    }

    @Override
    public List<ApprovalVO> findOngoingDrafts() {
        return session.selectList(NS + "selectOngoingDrafts");
    }

    @Override
    public List<ApprovalVO> findMyTodo(Long eno) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno", eno); // ✅ #{eno}에 매칭
        return session.selectList(NS + "selectMyTodo", p);
    }

    // (필요 시 유지)
    @Override
    public List<ApprovalVO> selectRecentDrafts(String period, String field, String q) {
        Map<String, Object> p = new HashMap<>();
        p.put("period", period);
        p.put("field",  field);
        p.put("q",      q);
        return session.selectList(NS + "selectRecentDrafts", p);
    }

    @Override
    public List<ApprovalVO> selectOngoingDrafts() {
        return session.selectList(NS + "selectOngoingDrafts");
    }

    @Override
    public List<ApprovalVO> selectMyTodo(Long eno) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno", eno); // ✅
        return session.selectList(NS + "selectMyTodo", p);
    }

    // ---------- 참조 문서함 ----------
    @Override
    public List<ApprovalVO> viewerList(Long eno, String period, String field, String q, int start, int end) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno",    eno);    // ✅
        p.put("period", period);
        p.put("field",  field);
        p.put("q",      q);
        p.put("start",  start);
        p.put("end",    end);
        return session.selectList(NS + "viewerList", p);
    }

    @Override
    public int viewerListCount(Long eno, String period, String field, String q) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno",    eno);    // ✅
        p.put("period", period);
        p.put("field",  field);
        p.put("q",      q);
        return session.selectOne(NS + "viewerListCount", p);
    }

    // ---------- 내가 기안한 문서함 ----------
    @Override
    public List<ApprovalVO> draftList(Long eno, String period, String field, String q, int start, int end) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno",    eno);    // ✅
        p.put("period", period);
        p.put("field",  field);
        p.put("q",      q);
        p.put("start",  start);
        p.put("end",    end);
        return session.selectList(NS + "draftList", p);
    }

    @Override
    public int draftListCount(Long eno, String period, String field, String q) {
        Map<String, Object> p = new HashMap<>();
        p.put("eno",    eno);    // ✅
        p.put("period", period);
        p.put("field",  field);
        p.put("q",      q);
        return session.selectOne(NS + "draftListCount", p);
    }

    // ---------- 결재양식 ----------
    @Override
    public List<Map<String, Object>> findFormClasses() {
        return session.selectList(NS + "findFormClasses");
    }

    @Override
    public List<Map<String, Object>> findFormsAll() {
        return session.selectList(NS + "findFormsAll");
    }

    @Override
    public Map<String, Object> getForm(String sformNo) {
        return session.selectOne(NS + "getForm", sformNo);
    }

    // ---------- 임시보관(임시저장) ----------
    @Override
    public int insertTempSave(ApprovalVO vo) {
        return session.insert(NS + "insertTempSave", vo);
    }

    // Map 기반으로 통일 (컨트롤러가 Map으로 넘김)
    @Override
    public int tempListCount(Map<String, Object> p) {
        // p에는 반드시 p.put("eno", …) 가 있어야 함
        return session.selectOne(NS + "tempListCount", p);
    }

    @Override
    public List<ApprovalVO> tempList(Map<String, Object> p) {
        // p에는 반드시 p.put("eno", …) 가 있어야 함
        return session.selectList(NS + "tempList", p);
    }

    @Override
    public List<ApprovalVO> selectTempList(Map<String, Object> p) {
        return session.selectList(NS + "selectTempList", p);
    }

    // 필요할 때 사용 (매퍼에 존재)
    @Override
    public String newDocNo() {
        return session.selectOne(NS + "newDocNo");
    }
    

    @Override
    public Map<String, Object> getEmpBasic(Long eno) {
        return session.selectOne(NS + "getEmpBasic", eno);
    }
    

    @Override
    public int insertHistory(String signNo, String content) {
        Map<String, Object> p = new HashMap<>();
        p.put("signNo", signNo);   // ✅ 카멜케이스로 통일
        p.put("content", content);
        return session.insert(NS + "insertHistory", p);
    }



    /* ===== 정리 메모 =====
       - 모든 쿼리 파라미터에서 사번 키는 'eno'로 통일.
       - 단일 Long 파라미터를 넘기면 #{eno}와 이름이 달라 바인딩 실패하므로
         selectList/selectOne 호출 시 Map에 'eno' 키로 담아서 전달.
       - 컨트롤러/서비스도 params.put("eno", …) 로 맞춰주면 끝.
     */
}
