package com.motiveon.service;

import java.util.List;
import java.util.Map;

import com.motiveon.dto.ApprovalVO;

public interface ApprovalService {

	// ===== KPI =====
	int countUrgent();

	int countReturned();

	int countWaiting();

	int countOnHold();

	// ===== 대시보드/최근/진행/할일 =====
	List<ApprovalVO> findRecentDrafts(String period, String field, String q);

	List<ApprovalVO> findOngoingDrafts();

	List<ApprovalVO> findMyTodo(Long eno);

	// ===== 문서함(열람) =====
	List<ApprovalVO> viewerList(Long eno, String period, String field, String q, int start, int end);

	int viewerListCount(Long eno, String period, String field, String q);

	// ===== 기안함 =====
	List<ApprovalVO> draftList(Long eno, String period, String field, String q, int start, int end);

	int draftListCount(Long eno, String period, String field, String q);

	// ===== 양식 =====
	List<Map<String, Object>> findFormClasses();

	List<Map<String, Object>> findFormsAll();

	Map<String, Object> getForm(String sformNo);

	String newDocNo();

	// ===== 임시저장 =====
	String saveTemp(ApprovalVO vo);

	// 임시보관함 (컨트롤러에서 Map으로 넘기는 버전 사용)
	int tempListCount(Map<String, Object> p);

	List<ApprovalVO> tempList(Map<String, Object> p);

	Map<String, Object> getEmpBasic(Long eno);

	int deleteTempDocs(List<String> signNos);

	   // ===== 문서 + 결재선 + 참조자 저장 =====
    String saveApproval(ApprovalVO vo);
    
    int approveListCount(Long eno, String tab, String period, String field, String q);
    List<?> approveList(Long eno, String tab, String period, String field, String q, int start, int end);

	Map<String, Object> getDetail(String signNo);
	
	  void actLine(String signNo, long eno, String action, String comment);


}
