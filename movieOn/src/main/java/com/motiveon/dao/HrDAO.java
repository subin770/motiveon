package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.HrVO;
import com.motiveon.dto.PostPositionVO;


public interface HrDAO {

	//직원 근태리스트
	List<HrVO> selectHrList(int eno) throws SQLException;
	
	//월의 1일~ 말일 기준 근태 내역 조회
	List<HrVO> selectHrByMonth(Map<String, Object> paramMap) throws SQLException;
	
	//근태 추가
	void insertHr(HrVO hrVo) throws SQLException;
	
	//근태 수정
	void updateHr(HrVO hrVo) throws SQLException;
	
	//근태 삭제
	void deleteHr(String hrcode) throws SQLException;
	
	//날짜로 근태 조회
	HrVO selectHrByDate(Map<String, Object> paramMap) throws SQLException;
	
	//근태
	HrVO selectHrByEno(Map<String, Object> paramMap) throws SQLException;
	
	//직원정보 가져오기
	EmployeeVO selectEmp(int eno) throws SQLException;
	
	//직원 직위 불러오기
	PostPositionVO selectPpsByPpscode(String ppsCode) throws SQLException;
	
	
	List<String> selectHrcodeByWorkDate(String workDate) throws SQLException;
	
	List<PostPositionVO> selectPostPosition() throws SQLException;

	 List<Map<String, Object>> getTeamList(Map<String, Object> param);
	    int countTeamList(Map<String, Object> param);
	    int getWorkDays(Map<String, Object> param);
	    String getteamName(int dno);
	    String getTeamName(int dno);
	
}
