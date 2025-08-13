package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.dto.EmployeeVO;

public interface EmployeeService {
	// 회원목록
		List<EmployeeVO> list() throws SQLException;

		// 회원조회
		EmployeeVO getEmployee(int eno) throws SQLException;

		// 회원등록
		void regist(EmployeeVO employee) throws SQLException;

		// 회원수정
		void modify(EmployeeVO employee) throws SQLException;

		// 회원삭제
		void remove(int eno) throws SQLException;

		

		
}
