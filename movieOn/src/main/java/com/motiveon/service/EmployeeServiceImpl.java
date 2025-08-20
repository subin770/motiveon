package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.motiveon.dao.EmployeeDAO;
import com.motiveon.dto.EmployeeVO;


@Service
public class EmployeeServiceImpl implements EmployeeService{

	private EmployeeDAO employeeDAO;

	public EmployeeServiceImpl(EmployeeDAO employeeDAO) {
		this.employeeDAO = employeeDAO;
	}

	@Override
	public List<EmployeeVO> list() throws SQLException {
		List<EmployeeVO> employeeList = employeeDAO.selectEmployeeList();
		
		return employeeList;
	}

	@Override
	public EmployeeVO getEmployee(int eno) throws SQLException {
		EmployeeVO employee = employeeDAO.selectEmployeeByEno(eno);
		return employee;
	}

	@Override
	public void regist(EmployeeVO employee) throws SQLException {
		employeeDAO.insertEmployee(employee);		
	}

	@Override
	public void modify(EmployeeVO employee) throws SQLException {
		employeeDAO.updateEmployee(employee);
	}

	@Override
	public void remove(int eno) throws SQLException {
		employeeDAO.deleteEmployee(eno);
		
	}
	
}