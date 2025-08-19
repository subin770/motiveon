package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.HrVO;
import com.motiveon.dto.PostPositionVO;

public class HrDAOImpl implements HrDAO {
	
	private SqlSession session;
	
	public HrDAOImpl(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<HrVO> selectHrList(int eno) throws SQLException {
		return session.selectList("Hr-Mapper.selectHrList", eno);
	}

	@Override
	public List<HrVO> selectHrByMonth(Map<String, Object> paramMap) throws SQLException {
		return session.selectList("Hr-Mapper.selectHrByMonth", paramMap);
	}
	
	@Override
	public void insertHr(HrVO hrVo) throws SQLException {
		session.insert("Hr-Mapper.insertHr", hrVo);
	}
	
	@Override
	public void updateHr(HrVO hrVo) throws SQLException {
		session.update("Hr-Mapper.updateHr", hrVo);
	}
	
	@Override
	public void deleteHr(String hrcode) throws SQLException {
		session.delete("Hr-Mapper.deleteHr", hrcode);
	}
	
	@Override
	public HrVO selectHrByDate(Map<String, Object> paramMap) throws SQLException {
		return session.selectOne("Hr-Mapper.selectHrByDate", paramMap);
	}

	@Override
	public HrVO selectHrByEno(Map<String, Object> paramMap) throws SQLException {
		return session.selectOne("Hr-Mapper.selectHrByEno", paramMap);
	}

	@Override
	public EmployeeVO selectEmp(int eno) throws SQLException {
		return session.selectOne("Employee-Mapper.selectEmployeeByEno", eno);
	}

	@Override
	public PostPositionVO selectPpsByPpscode(String ppsCode) throws SQLException {
		return session.selectOne("Hr-Mapper.selectPpsByPpscode", ppsCode);
	}

	@Override
	public List<String> selectHrcodeByWorkDate(String workDate) throws SQLException {
		return session.selectList("Hr-Mapper.selectHrcodeByWorkDate", workDate);
	}

	@Override
	public List<PostPositionVO> selectPostPosition() throws SQLException {
		return session.selectList("Hr-Mapper.selectPostPosition");
	}
	
    /** 팀 근태 목록 조회 */
    @Override
    public List<Map<String, Object>> getTeamList(Map<String, Object> param) {
        return session.selectList("Hr-Mapper.getTeamList", param);
    }

    /** 팀 근태 인원 수 조회 */
    @Override
    public int countTeamList(Map<String, Object> param) {
        return session.selectOne("Hr-Mapper.countTeamList", param);
    }

    /** 해당 월의 근무일 수 조회 */
    @Override
    public int getWorkDays(Map<String, Object> param) {
        return session.selectOne("Hr-Mapper.getWorkDays", param);
    }

    /** 부서명 조회 */
    @Override
    public String getteamName(int dno) {
        return session.selectOne("Hr-Mapper.getteamName", dno);
    }

    /** 팀명 조회 */
    @Override
    public String getTeamName(int dno) {
        return session.selectOne("Hr-Mapper.getTeamName", dno);
    }



}
