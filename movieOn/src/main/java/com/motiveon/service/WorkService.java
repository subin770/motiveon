package com.motiveon.service;

import java.util.List;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkManagerVO;
import com.motiveon.dto.WorkVO;

public interface WorkService {
	String regist(WorkVO work, int requesterEno, int ownerEno);

	WorkVO getDetail(String wcode);

	void approve(String wcode, int eno);

	void objection(ObjectionDTO dto);

	List<WorkListDTO> myList(int eno, String status);

	List<WorkListDTO> requestedList(int eno, String status);

	void modify(WorkVO work, int eno);

	// 메인 박스들
	List<WorkListDTO> getWeeklyClosingList(int eno);

	List<WorkListDTO> getWeeklyRequestedList(int eno);

	List<WorkListDTO> getPendingApprovalList(int eno);

	List<WorkListDTO> getWaitingRequestedList(int eno);

	// 전체 업무 목록 조회
	List<WorkListDTO> getWorkList();

	List<WorkManagerVO> getWorkManagersByWcode(String wcode);

	WorkVO getWorkDetail(String wcode);
}
