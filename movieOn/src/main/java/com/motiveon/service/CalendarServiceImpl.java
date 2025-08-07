package com.motiveon.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.motiveon.command.Criteria;
import com.motiveon.dao.CalendarDAO;
import com.motiveon.dto.CalendarVO;
import com.motiveon.dto.EmployeeVO;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDAO calendarDAO;

	public CalendarServiceImpl(CalendarDAO calendarDAO) {
		this.calendarDAO = calendarDAO;
	}

	@Override
	public void regist(CalendarVO calendar) throws Exception {
		
		registCalendar(calendar); 
	}

	@Override
	public void registCalendar(CalendarVO calendar) throws SQLException {
		// 일정 코드 수동 생성
		String ccode = calendarDAO.selectCcode();
		calendar.setCcode(ccode);
		
		calendar.setSdate(parseDate(calendar.getStart()));
	    calendar.setEdate(parseDate(calendar.getEnd()));

		// insert
		calendarDAO.insertCalendar(calendar);
	}
	
	private Date parseDate(String datetime) {
	    try {
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	    	    return sdf.parse(datetime);
	    } catch (ParseException e) {
	        e.printStackTrace();
	        return null;
	    }
	}


	@Override
	public List<CalendarVO> getCalendarList(Criteria cri, int eno) throws SQLException {
		Map<String, Object> paramMap = new HashMap<>();
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

	@Override
	public List<CalendarVO> getAllCalendar() throws Exception {
		return calendarDAO.selectSearchCalendarList();
	}

	@Override
	public List<CalendarVO> getCalendarList() throws SQLException {
	    return calendarDAO.selectAllCalendar();
	}


	// CalendarServiceImpl.java
	@Override
	public int modifyCalendar(CalendarVO calendar) throws SQLException {
	    return calendarDAO.updateCalendar(calendar);  
	}


	@Override
	public int removeCalendar(String ccode) {
	    return calendarDAO.deleteCalendar(ccode);
	}

	@Override
	public void delete(String ccode) throws Exception {
	    calendarDAO.delete(ccode);
	}


	    @Resource
	    private SqlSession session;

	    private static final String NAMESPACE = "Calendar-Mapper";

	    @Override
	    public int updateCalendar(CalendarVO calendar) {
	        return session.update(NAMESPACE + ".updateCalendar", calendar);
	    }

	    @Override
	    public List<CalendarVO> searchCalendar(String keyword) throws SQLException {
	        return session.selectList("Calendar-Mapper.searchCalendar", keyword);
	    }

		@Override
		public int modify(CalendarVO vo) {
			// TODO Auto-generated method stub
			return 0;
		}




}
