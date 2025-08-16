package com.motiveon.dao;

import java.util.List;
import java.util.Map;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkVO;

public interface WorkDAO {

    String getNextWcode();

    void insertWork(WorkVO work);
    void updateWork(WorkVO work);

    WorkVO selectWorkDetail(String wcode);
    void updateApproval(String wcode, int eno);
    void insertObjection(ObjectionDTO dto);

    // ===== 여기 부분을 int, String 파라미터로 통일 =====
    List<WorkListDTO> selectMyList(Map<String, Object> params);

    // 요청받은 업무 목록
    List<WorkListDTO> selectRequestedList(Map<String, Object> params);
    List<WorkListDTO> selectWeeklyClosingList(int eno);
    List<WorkListDTO> selectWeeklyRequestedList(int eno);
    List<WorkListDTO> selectPendingApprovalList(int eno);
    List<WorkListDTO> selectWaitingRequestedList(int eno);
    List<WorkListDTO> selectWorkList();
    List<WorkListDTO> selectMyList(int eno, String status);
    List<WorkListDTO> selectRequestedList(int eno, String status);
}
