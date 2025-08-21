package com.motiveon.service;


import java.util.List;
import java.util.Map;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkManagerVO;
import com.motiveon.dto.WorkReplyVO;
import com.motiveon.dto.WorkVO;

public interface WorkService {

    // ================== 등록 ==================
    String regist(WorkVO work, int requesterEno, int ownerEno);

    // ================== 상세 ==================
    WorkVO getWorkDetail(String wcode);
    WorkVO getWorkByWcode(String wcode) throws Exception; // 필요 시 하나만 사용 가능

    // ================== 승인 / 반려 / 이의신청 ==================
    int approveWork(String wcode) throws Exception;                  // 승인
    int rejectWork(String wcode, String reason) throws Exception;    // 반려

    void objection(ObjectionDTO dto) throws Exception;               // 이의신청 등록
    List<WorkReplyVO> selectObjectionList(String wcode) throws Exception; // 이의신청 목록
    WorkReplyVO selectObjectionByWrno(int wrno) throws Exception;         // 이의신청 상세
                        // 이의신청 코멘트 추가
    int insertObjection(WorkReplyVO reply) throws Exception;

    // ================== 목록 ==================
    List<WorkListDTO> selectMyList(Map<String, Object> params);  // 조건부 내 업무
    List<WorkListDTO> myList(int eno, String status);            // 상태별 내 업무
    List<WorkListDTO> requestedList(int eno, String status);     // 상태별 요청한 업무
    List<WorkListDTO> depWorkList(int dno);                      // 부서 업무
    List<WorkListDTO> getWorkList();                             // 전체 업무 목록
    
    

    // ================== 수정 ==================
    void modify(WorkVO work, int eno);

    // ================== 대시보드 ==================
    List<WorkListDTO> getWeeklyClosingList(int eno);     // 주간 마감 예정
    List<WorkListDTO> getWeeklyRequestedList(int eno);   // 주간 요청한 업무
    List<WorkListDTO> getPendingApprovalList(int eno);   // 승인 대기
  
    // ================== 기타 ==================
    List<WorkManagerVO> getWorkManagersByWcode(String wcode);

    // ================== 상태 업데이트 ==================
    int updateWorkStatus(String wcode, String status, String state); // 상세 상태 변경
    void updateWorkStatus(String wcode, String status);              // 단순 상태 변경

    // ================== 요청자 / 담당자 ==================
    
    List<WorkListDTO> getToReqList(int eno);
    List<WorkListDTO> getMyWorkList(int eno);
    
    
    List<WorkListDTO> getWaitingRequestedList(int requesterEno) ;
    
    
    List<WorkListDTO> selectWeeklyClosingList(int eno);
    List<WorkListDTO> selectWeeklyRequestedList(int eno);
    List<WorkListDTO> selectPendingApprovalList(int eno);
    List<WorkListDTO> selectWaitingRequestedList(int eno);
}
