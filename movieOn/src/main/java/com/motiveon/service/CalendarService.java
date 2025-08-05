package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.Criteria;
import com.motiveon.dto.CalendarVO;
import com.motiveon.dto.EmployeeVO;


public interface CalendarService {

	List<CalendarVO> getCalendarList(Criteria cri, int eno) throws SQLException;

	CalendarVO getCalendarByCcode(String ccode) throws SQLException;

	void registCalendar(CalendarVO calendar) throws SQLException;

	void modify(CalendarVO calendar) throws SQLException;

	void remove(String ccode) throws SQLException;

	List<EmployeeVO> selectEnoByCcode(String ccode) throws SQLException;
	
	List<Integer> getEnoSameMyDno(int eno) throws SQLException;
	
	List<Integer> getAllEmployee() throws SQLException;

}