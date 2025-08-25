package com.motiveon.dao;

import java.sql.SQLException;
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
    public void approveWork(Map<String,Object> param) {
        sqlSession.update(NAMESPACE + "approveWork", param);
    }

    @Override
    public void rejectWork(Map<String,Object> param) {
        sqlSession.update(NAMESPACE + "rejectWork", param);
    }

    @Override
    public void insertRejectReason(Map<String,Object> param) {
        sqlSession.insert(NAMESPACE + "insertRejectReason", param);
    }
 
    

    @Override
    public List<WorkListDTO> selectWorkList() {
        return sqlSession.selectList(NAMESPACE + "selectWorkList");
    }
    @Override
    public int updateApproval(String wcode, int eno) {
        Map<String, Object> param = new HashMap<>();
        param.put("wcode", wcode);
        param.put("eno", eno);
        return sqlSession.update(NAMESPACE + "updateApproval", param);
    }



	@Override
	public void updateWorkStatusApproved(String wcode) {
		// TODO Auto-generated method stub
		
	}
	@Override
    public List<WorkListDTO> selectMyWorkList(int eno) {
        return sqlSession.selectList(NAMESPACE + "selectMyWorkList", eno);
    }

    @Override
    public List<WorkListDTO> selectRequestedWorkList(int eno) {
        return sqlSession.selectList(NAMESPACE + "selectRequestedWorkList", eno);
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
		public List<WorkVO> selectPendingApprovalList() throws SQLException {
			// TODO Auto-generated method stub
			return null;
		}
		

		@Override
	    public List<WorkListDTO> selectToReqList(int eno) {
	        return sqlSession.selectList(NAMESPACE + "selectToReqList", eno);
	    }
		
		
		@Override
		public void updateWorkStatus(String wcode, String status) {
		    Map<String, Object> param = new HashMap<>();
		    param.put("wcode", wcode);
		    param.put("status", status);
		    sqlSession.update(NAMESPACE + "updateWorkStatusSimple", param);
		}

	

		    @Override
		    public void insertObjection(ObjectionDTO dto) {
		        sqlSession.insert(NAMESPACE + "insertObjection", dto);
		    }

		    
		    @Override
		    public WorkVO selectWorkDetail(String wcode) {
		        return sqlSession.selectOne(NAMESPACE + "selectWorkDetail", wcode);
		    }

		    @Override
		    public void updateStatus(String wcode, String status) {
		        sqlSession.update(NAMESPACE + "updateStatus", 
		            new java.util.HashMap<String, Object>() {{
		                put("wcode", wcode);
		                put("status", status);
		            }}
		        );
		    }

		    @Override
		    public void insertRejectReason(String wcode, String reason) {
		        sqlSession.insert(NAMESPACE + "insertRejectReason", 
		            new java.util.HashMap<String, Object>() {{
		                put("wcode", wcode);
		                put("reason", reason);
		            }}
		        );
		    }

		    @Override
		    public void insertObjection(String wcode, String reason) {
		        sqlSession.insert(NAMESPACE + "insertObjection", 
		            new java.util.HashMap<String, Object>() {{
		                put("wcode", wcode);
		                put("reason", reason);
		            }}
		        );
		    }

		    @Override
		    public void deleteWork(String wcode) {
		        sqlSession.delete(NAMESPACE + "deleteWork", wcode);
		    }
		    
		    
		    
}
