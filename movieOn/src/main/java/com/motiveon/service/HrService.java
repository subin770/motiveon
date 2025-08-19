package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.HrVO;

public interface HrService {	
	
	//직원 근태 리스트
	List<HrVO> getHrList(int eno) throws SQLException;
	
	//월별 직원 근태 리스트
	List<HrVO> getHrMonthList(int eno, String monthStart) throws SQLException;
	
	//등록
	void regist(HrVO hrVo) throws SQLException;
	
	//수정
	void modify(HrVO hrVo) throws SQLException;
	
	//삭제
	void remove(String hrcode) throws SQLException;
	
	//직원 정보
	EmployeeVO getEmp(int eno) throws SQLException;

	List<Map<String, Object>> getTeamList(Map<String, Object> param);
    int countTeamList(Map<String, Object> param);
    int getWorkDays(Map<String, Object> param);
    String getteamName(int dno);
    String getTeamName(int dno);
	
}
