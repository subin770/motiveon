package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkReplyVO;
import com.motiveon.dto.WorkVO;

public interface WorkDAO {
	String getNextWcode();

	void insertWork(WorkVO work);

	WorkVO selectWorkDetail(String wcode);

	int updateApproval(String wcode, int eno);

	void insertObjection(ObjectionDTO dto);

	List<WorkListDTO> selectMyList(Map<String, Object> params);

	List<WorkListDTO> selectRequestedList(Map<String, Object> params);

	int updateWork(WorkVO work);

	List<WorkListDTO> selectWorkList();

	void insertObjection(WorkReplyVO reply);

	List<WorkListDTO> selectDepWorkList(int dno);

	void updateWorkStatus(@Param("wcode") String wcode, @Param("status") String status);

	void updateWorkStatusApproved(String wcode);

	void updateStatus(@Param("wcode") String wcode, @Param("status") String status);

	void updateManagerAnswer(Map<String, Object> param);

	List<WorkListDTO> selectRequestedWorkList(int requesterEno);

	public int updateWorkStatus(String wcode, String status, String state);

	List<WorkVO> selectPendingApprovalList() throws SQLException;

	List<WorkListDTO> selectWeeklyClosingList(int eno);

	List<WorkListDTO> selectWeeklyRequestedList(int eno);

	List<WorkListDTO> selectPendingApprovalList(int eno);

	List<WorkListDTO> selectWaitingRequestedList(int eno);

	List<WorkListDTO> selectMyWorkList(int eno);

	List<WorkListDTO> selectToReqList(int eno);

}
