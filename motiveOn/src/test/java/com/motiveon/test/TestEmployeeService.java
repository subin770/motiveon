package com.motiveon.test;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.service.EmployeeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:com/motiveon/context/root-context.xml")
@Transactional
public class TestEmployeeService {
	

	@Autowired
	private EmployeeService service;
	
	@Test
	public void testList()throws Exception{
		List<EmployeeVO> employeeList = service.list();
		Assert.assertEquals(employeeList.size(), 8);
	}

}
