package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.Criteria;
import com.motiveon.dto.CalendarVO;
import com.motiveon.dto.EmployeeVO;


public interface CalendarService {

	List<CalendarVO> getCalendarList(Criteria cri, int eno) throws SQLException;

	CalendarVO getCalendarByCcode(String ccode) throws SQLException;

	void regist(CalendarVO calendar) throws Exception;
	
	void registCalendar(CalendarVO calendar) throws SQLException;

	void delete(String ccode) throws Exception;

	void remove(String ccode) throws SQLException;

	List<EmployeeVO> selectEnoByCcode(String ccode) throws SQLException;
	
	List<Integer> getEnoSameMyDno(int eno) throws SQLException;
	
	List<Integer> getAllEmployee() throws SQLException;


	List<CalendarVO> getAllCalendar() throws Exception;
	 List<CalendarVO> getCalendarList() throws SQLException;
	 int modify(CalendarVO vo);
	 public int modifyCalendar(CalendarVO calendar) throws SQLException;
	 public int removeCalendar(String ccode) throws SQLException;

	 public int updateCalendar(CalendarVO calendar) throws SQLException;
	 List<CalendarVO> searchCalendar(String keyword) throws SQLException;


}