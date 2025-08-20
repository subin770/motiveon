package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.dto.EmployeeVO;

public interface EmployeeDAO {

	List<EmployeeVO> selectEmployeeList()throws SQLException;
	
	
	EmployeeVO selectEmployeeByEno(int eno)throws SQLException;
	void insertEmployee(EmployeeVO employee)throws SQLException;
	void updateEmployee(EmployeeVO employee)throws SQLException;
	void deleteEmployee(int eno)throws SQLException;	
	

	
}