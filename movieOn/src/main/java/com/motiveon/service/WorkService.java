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
    WorkVO getWorkByWcode(String wcode) throws Exception; // 둘 중 하나만 써도 무방

    // ================== 승인 / 반려 / 이의신청 ==================
    int approveWork(String wcode) throws Exception;               // 승인
    int rejectWork(String wcode, String reason) throws Exception; // 반려
    void objection(ObjectionDTO dto) throws Exception;            // 이의신청 등록

    List<WorkReplyVO> selectObjectionList(String wcode) throws Exception; // 이의신청 목록
    WorkReplyVO selectObjectionByWrno(int wrno) throws Exception;         // 이의신청 상세

    // ================== 목록 ==================
    
    List<WorkListDTO> selectMyList(Map<String, Object> params);



    // ================== 수정 ==================
    void modify(WorkVO work, int eno);

    // ================== 대시보드 ==================
    List<WorkListDTO> getWeeklyClosingList(int eno);
    List<WorkListDTO> getWeeklyRequestedList(int eno);
    List<WorkListDTO> getPendingApprovalList(int eno);
    List<WorkListDTO> getWaitingRequestedList(int eno);

    // ================== 기타 ==================
    List<WorkListDTO> getWorkList();
    List<WorkManagerVO> getWorkManagersByWcode(String wcode);

    // ================== 상태 업데이트 ==================
    int updateWorkStatus(String wcode, String status, String state);
    
    
    List<WorkListDTO> myList(int eno, String status);
    List<WorkListDTO> requestedList(int eno, String status);

    void insertObjection(WorkReplyVO reply);
    List<WorkListDTO> depWorkList(int dno);

    void updateWorkStatus(String wcode, String status);
}
