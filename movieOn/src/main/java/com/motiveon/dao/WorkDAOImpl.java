package com.motiveon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkVO;

@Repository
public class WorkDAOImpl implements WorkDAO {

    private final SqlSession sqlSession;
    private static final String NS = "Work-Mapper";

    public WorkDAOImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public String getNextWcode() {
        return sqlSession.selectOne(NS + ".getNextWcode");
    }

    @Override
    public void insertWork(WorkVO work) {
        sqlSession.insert(NS + ".insertWork", work);
    }

    @Override
    public void updateWork(WorkVO work) {
        sqlSession.update(NS + ".updateWork", work);
    }

    @Override
    public WorkVO selectWorkDetail(String wcode) {
        return sqlSession.selectOne(NS + ".selectWorkDetail", wcode);
    }

    @Override
    public void updateApproval(String wcode, int eno) {
        Map<String,Object> params = new HashMap<>();
        params.put("wcode", wcode);
        params.put("eno", eno);
        sqlSession.update(NS + ".updateApproval", params);
    }

    @Override
    public void insertObjection(ObjectionDTO dto) {
        sqlSession.insert(NS + ".insertObjection", dto);
    }

    // ===== 여기서 Map 만들어서 전달 =====

    @Override
    public List<WorkListDTO> selectMyList(Map<String, Object> params) {
        return sqlSession.selectList(NS + ".selectMyList", params);
    }

    @Override
    public List<WorkListDTO> selectRequestedList(Map<String, Object> params) {
        return sqlSession.selectList(NS + ".selectRequestedList", params);
    }

    @Override
    public List<WorkListDTO> selectWeeklyClosingList(int eno) {
        return sqlSession.selectList(NS + ".selectWeeklyClosingList", eno);
    }

    @Override
    public List<WorkListDTO> selectWeeklyRequestedList(int eno) {
        return sqlSession.selectList(NS + ".selectWeeklyRequestedList", eno);
    }

    @Override
    public List<WorkListDTO> selectPendingApprovalList(int eno) {
        return sqlSession.selectList(NS + ".selectPendingApprovalList", eno);
    }

    @Override
    public List<WorkListDTO> selectWaitingRequestedList(int eno) {
        return sqlSession.selectList(NS + ".selectWaitingRequestedList", eno);
    }

    @Override
    public List<WorkListDTO> selectWorkList() {
        return sqlSession.selectList(NS + ".selectWorkList");
    }

	@Override
	public List<WorkListDTO> selectMyList(int eno, String status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<WorkListDTO> selectRequestedList(int eno, String status) {
		// TODO Auto-generated method stub
		return null;
	}
}
