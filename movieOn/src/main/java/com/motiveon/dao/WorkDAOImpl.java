package com.motiveon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkReplyVO;
import com.motiveon.dto.WorkVO;

@Repository
public class WorkDAOImpl implements WorkDAO {

    private final SqlSessionTemplate sqlSession;
    private static final String NAMESPACE = "Work-Mapper.";

    public WorkDAOImpl(SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public String getNextWcode() {
        return sqlSession.selectOne(NAMESPACE + "getNextWcode");
    }

    @Override
    public void insertWork(WorkVO work) {
        sqlSession.insert(NAMESPACE + "insertWork", work);
    }

    @Override
    public WorkVO selectWorkDetail(String wcode) {
        return sqlSession.selectOne(NAMESPACE + "selectWorkDetail", wcode);
    }

    @Override
    public int updateApproval(String wcode, int eno) {
        // eno까지 활용하려면 Map 전달
        return sqlSession.update(NAMESPACE + "updateApproval", Map.of("wcode", wcode, "eno", eno));
    }

    @Override
    public void insertObjection(ObjectionDTO dto) {
        sqlSession.insert(NAMESPACE + "insertObjection", dto);
    }

    @Override
    public List<WorkListDTO> selectMyList(Map<String, Object> params) {
        return sqlSession.selectList(NAMESPACE + "selectMyList", params);
    }

    @Override
    public List<WorkListDTO> selectRequestedList(Map<String, Object> params) {
        return sqlSession.selectList(NAMESPACE + "selectRequestedList", params);
    }

    @Override
    public int updateWork(WorkVO work) {
        return sqlSession.update(NAMESPACE + "updateWork", work);
    }

    @Override
    public List<WorkListDTO> selectWeeklyClosingList(int eno) {
        return sqlSession.selectList(NAMESPACE + "selectWeeklyClosingList", eno);
    }

    @Override
    public List<WorkListDTO> selectWeeklyRequestedList(int eno) {
        return sqlSession.selectList(NAMESPACE + "selectWeeklyRequestedList", eno);
    }

    @Override
    public List<WorkListDTO> selectPendingApprovalList(int eno) {
        return sqlSession.selectList(NAMESPACE + "selectPendingApprovalList", eno);
    }

    @Override
    public List<WorkListDTO> selectWaitingRequestedList(int eno) {
        return sqlSession.selectList(NAMESPACE + "selectWaitingRequestedList", eno);
    }

    @Override
    public List<WorkListDTO> selectWorkList() {
        return sqlSession.selectList(NAMESPACE + "selectWorkList");
    }



	@Override
	public void updateWorkStatusApproved(String wcode) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void updateStatus(String wcode, String status) {
	    sqlSession.update("Work-Mapper.updateStatus", Map.of("wcode", wcode, "status", status));
	}



	@Override
	public void updateManagerAnswer(Map<String, Object> param) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertObjection(WorkReplyVO reply) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int updateWorkStatus(String wcode, String status, String state) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("wcode", wcode);
	    param.put("status", status); // 예: "이의신청"
	    param.put("state", state);   // 예: "OBJECTION"
	    return sqlSession.update("Work-Mapper.updateWorkStatus", param);
	}


	
	@Override
	public List<WorkListDTO> selectDepWorkList(int dno) {
	    return sqlSession.selectList("Work-Mapper.selectDepWorkList", dno);
	}

	@Override
	public void updateWorkStatus(String wcode, String status) {
		// TODO Auto-generated method stub
		
	}



}
