package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.motiveon.dto.CalendarVO;
import com.motiveon.dto.EmployeeVO;

@Repository
public class CalendarDAOImpl implements CalendarDAO {

	private SqlSession session;

	public CalendarDAOImpl(SqlSession session) {
		this.session = session;
	}


	@Override
	public List<CalendarVO> selectSearchCalendarList(Map<String, Object> paramMap) throws SQLException {
		return session.selectList("Calendar-Mapper.selectSearchCalendarList", paramMap);
	}

	@Override
	public CalendarVO selectCalendarByCcode(String ccode) throws SQLException {
		return session.selectOne("Calendar-Mapper.selectCalendarByCcode", ccode);
	}

	@Override
	public void insertCalendar(CalendarVO calendar) throws SQLException {
		session.update("Calendar-Mapper.insertCalendar", calendar);
	}

	@Override
	public void updateCalendar(CalendarVO calendar) throws SQLException {
		session.update("Calendar-Mapper.updateCalendar", calendar);
	}

	@Override
	public void deleteCalendar(String ccode) throws SQLException {
		session.delete("Calendar-Mapper.deleteCalendar", ccode);
	}

	@Override
	public int selectCalendarSeqNext() throws SQLException {
		return session.selectOne("Calendar-Mapper.selectCalendarSeqNext");
	}

	@Override
	public List<EmployeeVO> selectEnoByCcode(String ccode) throws SQLException {
		return session.selectList("Calendar-Mapper.selectEnoByCcode", ccode);
	}

	@Override
	public String selectCcode() throws SQLException {
		return session.selectOne("Calendar-Mapper.selectCcode");
	}

	@Override
	public List<Integer> selectEnoSameMyDno(int eno) throws SQLException {
		return session.selectList("Calendar-Mapper.selectEnoSameMyDno", eno);
	}

	@Override
	public List<Integer> selectAllEmployee() throws SQLException {
		return session.selectList("Calendar-Mapper.selectAllEmployee");
	}

}