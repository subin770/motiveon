package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import com.motiveon.dto.CalendarVO;
import com.motiveon.dto.EmployeeVO;

public interface CalendarDAO {
	
	List<CalendarVO> selectSearchCalendarList(Map<String, Object> paramMap) throws SQLException;

	CalendarVO selectCalendarByCcode(String ccode) throws SQLException;
	
	
	void insertCalendar(CalendarVO calendar) throws SQLException;

	public int updateCalendar(CalendarVO calendar) throws SQLException;

	public int deleteCalendar(String ccode);

	void delete(String ccode) throws Exception;



	List<EmployeeVO> selectEnoByCcode(String ccode) throws SQLException;

	String selectCcode() throws SQLException;

	
	List<Integer> selectEnoSameMyDno(int eno) throws SQLException;
	
	List<Integer> selectAllEmployee() throws SQLException;
	List<CalendarVO> selectSearchCalendarList() throws Exception;
	
	List<CalendarVO> selectAllCalendar() throws SQLException;
	



}