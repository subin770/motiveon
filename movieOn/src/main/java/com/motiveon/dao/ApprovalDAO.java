package com.motiveon.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.motiveon.dto.ApprovalVO;

public interface ApprovalDAO {

    // ===== 대시보드/카운트 =====
    int countUrgent();
    int countReturned();
    int countWaiting();
    int countOnHold();

    // ===== 대시보드/최근/진행/할일 =====
    List<ApprovalVO> findRecentDrafts(@Param("period") String period,
                                      @Param("field")  String field,
                                      @Param("q")      String q);

    List<ApprovalVO> findOngoingDrafts();

    List<ApprovalVO> findMyTodo(@Param("eno") Long eno);

    // (필요 시 유지하는 셀렉트들)
    List<ApprovalVO> selectRecentDrafts(@Param("period") String period,
                                        @Param("field")  String field,
                                        @Param("q")      String q);

    List<ApprovalVO> selectOngoingDrafts();

    List<ApprovalVO> selectMyTodo(@Param("eno") Long eno);

    // ===== 문서함(열람) =====
    List<ApprovalVO> viewerList(@Param("eno")    Long eno,
                                @Param("period") String period,
                                @Param("field")  String field,
                                @Param("q")      String q,
                                @Param("start")  int start,
                                @Param("end")    int end);

    int viewerListCount(@Param("eno")    Long eno,
                        @Param("period") String period,
                        @Param("field")  String field,
                        @Param("q")      String q);

    // ===== 기안함 =====
    List<ApprovalVO> draftList(@Param("eno")    Long eno,
                               @Param("period") String period,
                               @Param("field")  String field,
                               @Param("q")      String q,
                               @Param("start")  int start,
                               @Param("end")    int end);

    int draftListCount(@Param("eno")    Long eno,
                       @Param("period") String period,
                       @Param("field")  String field,
                       @Param("q")      String q);

    // ===== 양식 =====
    List<Map<String, Object>> findFormClasses();
    List<Map<String, Object>> findFormsAll();
    Map<String, Object> getForm(@Param("sformNo") String sformNo);

    // ===== 임시보관(임시저장) =====
    /** 임시저장 INSERT (SIGNDOC.TEMPSAVE=1, STATE=0) */
    int insertTempSave(@Param("vo") ApprovalVO vo);

    /** 임시보관함 카운트 (Map 기반으로 통일) */
    int tempListCount(Map<String, Object> params);

    /** 임시보관함 목록 (Map 기반으로 통일) */
    List<ApprovalVO> tempList(Map<String, Object> params);

    /** 임시보관함 단순 목록(비페이징 등 필요시) */
    List<ApprovalVO> selectTempList(Map<String, Object> params);

    // 새 문서번호
    String newDocNo();
    
    Map<String, Object> getEmpBasic(@Param("eno") Long eno);
    

    
    int deleteHistoryBySignNos(@Param("ids") List<String> signNos);
    int deleteTempBySignNos(@Param("ids") List<String> signNos);
    

    // ===== 문서/결재선/참조자 저장 =====
    int insertSignDoc(ApprovalVO vo);

    /** approvers 리스트 기반 일괄 INSERT */
    int insertSignLines(ApprovalVO vo);

    /** refs 리스트 기반 일괄 INSERT */
    int insertSignRefs(ApprovalVO vo);

    List<ApprovalVO> getSignLines(@Param("signNo") String signNo);
    List<ApprovalVO> getSignRefs(@Param("signNo") String signNo);
    
    /** 내가 결재자인 문서함 총 건수 */
    int approveListCount(Map<String, Object> p);

    /** 내가 결재자인 문서함 목록 (start/end: 1-base, Oracle ROWNUM) */
    List<Map<String, Object>> approveList(Map<String, Object> p);

    List<ApprovalVO> selectSignLines(@Param("signNo") String signNo);
    List<ApprovalVO> selectSignRefs (@Param("signNo") String signNo);
    
    ApprovalVO getSignDoc(@Param("signNo") String signNo);
    
    int actSignLine(Map<String, Object> param);
    int completeDocIfAllApproved(String signNo);
    int rejectDoc(String signNo);

 
    int insertHistory(@Param("signno") String signNo,
            @Param("content") String content);
    
}
