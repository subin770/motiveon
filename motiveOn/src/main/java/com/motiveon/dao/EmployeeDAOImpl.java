package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.motiveon.dto.EmployeeVO;

public class EmployeeDAOImpl implements EmployeeDAO{
	private SqlSession session;	
	public EmployeeDAOImpl(SqlSession session) {
		this.session = session;
	}
	@Override
	public List<EmployeeVO> selectEmployeeList() throws SQLException {
		return session.selectList("Employee-Mapper.selectEmployeeList");
	}
	@Override
	public EmployeeVO selectEmployeeByEno(int eno) throws SQLException {
		return session.selectOne("Employee-Mapper.selectEmployeeByEno",eno);
	}
	@Override
	public void insertEmployee(EmployeeVO employee) throws SQLException {
		session.insert("Employee-Mapper.insertEmployee",employee);
		
	}
	@Override
	public void updateEmployee(EmployeeVO employee) throws SQLException {
		session.update("Employee-Mapper.updateEmployee",employee);
		
	}
	@Override
	public void deleteEmployee(int eno) throws SQLException {
		session.delete("Employee-Mapper.deleteEmployee",eno);
		
	}
}
