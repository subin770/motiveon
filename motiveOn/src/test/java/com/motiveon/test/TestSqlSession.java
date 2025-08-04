package com.motiveon.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.motiveon.dto.EmployeeVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"classpath:com/motiveon/context/dataSource-context.xml",
						"classpath:com/motiveon/context/root-context.xml"})
@Transactional
public class TestSqlSession {

	@Autowired
	private SqlSession session;
	
	@Test
	public void testSelectEmployeeList() {
		List<EmployeeVO> employeeList
		= session.selectList("Employee-Mapper.selectEmployeeList");
		
		Assert.assertEquals(employeeList.size(),8);
	}
	
	@Test
	public void testSelectEmployeeByEno() {
		int targetID = 24330015;
		
		EmployeeVO employee 
		= session.selectOne("Employee-Mapper.selectEmployeeByEno",targetID);
		
		Assert.assertEquals(targetID, employee.getEno());
	}	
	
	
	@Test
	@Rollback
	public void testInsertEmployee() {
		EmployeeVO mockMember = new EmployeeVO();
		mockMember.setEno(24313015);
		mockMember.setDno(330);
		mockMember.setBirth(20011103);
		mockMember.setEmail("kaka@naver.com");
		mockMember.setName("김선범");
		mockMember.setPhoto("motive/resourse/image");
		mockMember.setPpscode("PPS003");
		mockMember.setJob("사원");
		mockMember.setPhone("01045648923");
		mockMember.setEnabled(0);
		mockMember.setPwd("1234");
		mockMember.setSigntype(1);
		mockMember.setSignpath("경로없음");
		mockMember.setCondition("업무중");
		
		
		session.insert("Employee-Mapper.insertEmployee",mockMember);
		
		EmployeeVO getEmployee
		= session.selectOne("Employee-Mapper.selectEmployeeByEno",mockMember.getEno());
		
		Assert.assertEquals(mockMember.getEno(), getEmployee.getEno());
	}	
	
	
	@Test
	@Rollback
	public void testUpdateMember() {
		
		int eno = 14430005;
		String chName = "nana";
		
		EmployeeVO getEmployee 
		= session.selectOne("Employee-Mapper.selectEmployeeByEno",eno);
		getEmployee.setName(chName);
		session.update("Employee-Mapper.updateEmployee",getEmployee);
		
		getEmployee = session.selectOne("Employee-Mapper.selectEmployeeByEno",eno);
		
		Assert.assertEquals(chName, getEmployee.getName());
	}	
	
	
	@Test
	@Rollback
	public void testDeleteEmployee() {
		int eno = 24230015;
		
		EmployeeVO employee 
		= session.selectOne("Employee-Mapper.selectEmployeeByEno",eno);
		
		Assert.assertNotNull(employee);
		
		session.delete("Employee-Mapper.deleteEmployee",eno);
		
		employee = session.selectOne("Employee-Mapper.selectEmployeeByEno",eno);
		
		Assert.assertNull(employee);
		
	}
}
