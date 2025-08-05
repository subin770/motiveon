package com.motiveon.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.motiveon.command.Criteria;
import com.motiveon.dao.CalendarDAO;
import com.motiveon.dto.CalendarVO;
import com.motiveon.dto.EmployeeVO;

@Service
public class CalendarServiceImpl implements CalendarService {

	private CalendarDAO calendarDAO;

	public CalendarServiceImpl(CalendarDAO calendarDAO) {
		this.calendarDAO = calendarDAO;
	}

	@Override
	public List<CalendarVO> getCalendarList(Criteria cri, int eno) throws SQLException {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("eno", eno);
		paramMap.put("catecode1", cri.getCatecode1());
		paramMap.put("catecode2", cri.getCatecode2());
		paramMap.put("catecode3", cri.getCatecode3());
		paramMap.put("keyword", cri.getKeyword());
		System.out.println("catecode : " + cri.getCatecode1());

		return calendarDAO.selectSearchCalendarList(paramMap);
	}

	@Override
	public CalendarVO getCalendarByCcode(String ccode) throws SQLException {
		CalendarVO calendar = calendarDAO.selectCalendarByCcode(ccode);

		String start = calendar.getStart();
		String end = calendar.getEnd();

		start = start.replace('-', '/').replace('T', ' ').substring(0, start.lastIndexOf(":"));
		end = end.replace('-', '/').replace('T', ' ').substring(0, end.lastIndexOf(":"));

		calendar.setStart(start);
		calendar.setEnd(end);

		return calendar;
	}

	@Override
	public void registCalendar(CalendarVO calendar) throws SQLException {
		String ccode = calendarDAO.selectCcode();

		calendar.setCcode(ccode);
		// insert
		calendarDAO.insertCalendar(calendar);
	}

	@Override
	public void modify(CalendarVO calendar) throws SQLException {
		calendarDAO.updateCalendar(calendar);
	}

	@Override
	public void remove(String ccode) throws SQLException {
		calendarDAO.deleteCalendar(ccode);

	}

	@Override
	public List<EmployeeVO> selectEnoByCcode(String ccode) throws SQLException {
		return calendarDAO.selectEnoByCcode(ccode);
	}

	@Override
	public List<Integer> getEnoSameMyDno(int eno) throws SQLException {
		return calendarDAO.selectEnoSameMyDno(eno);
	}

	@Override
	public List<Integer> getAllEmployee() throws SQLException {
		return calendarDAO.selectAllEmployee();
	}

}