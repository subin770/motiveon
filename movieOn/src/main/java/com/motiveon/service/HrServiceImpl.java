package com.motiveon.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.motiveon.dao.HrDAO;
import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.HrVO;

public class HrServiceImpl implements HrService {

	private HrDAO hrDAO;

	public HrServiceImpl(HrDAO hrDAO) {
		this.hrDAO = hrDAO;
	}

	@Override
	public List<HrVO> getHrList(int eno) throws SQLException {
		List<HrVO> hrList = null;
		hrList = hrDAO.selectHrList(eno);
		return hrList;
	}

	// 월별 근태리스트
	@Override
	public List<HrVO> getHrMonthList(int eno, String monthStart) throws SQLException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("eno", eno);
		paramMap.put("monthStart", monthStart);

		List<HrVO> hrMonthList = hrDAO.selectHrByMonth(paramMap);

		return hrMonthList;
	}

	// 사원 정보
	@Override
	public EmployeeVO getEmp(int eno) throws SQLException {
		EmployeeVO employee = null;
		employee = hrDAO.selectEmp(eno);
		return employee;
	}

	@Override
	public void regist(HrVO hrVo) throws SQLException {

	}

	@Override
	public void modify(HrVO hrVo) throws SQLException {

	}

	@Override
	public void remove(String hrcode) throws SQLException {

	}

	 @Override
	    public List<Map<String, Object>> getTeamList(Map<String, Object> param) {
	        return hrDAO.getTeamList(param);
	    }

	    @Override
	    public int countTeamList(Map<String, Object> param) {
	        return hrDAO.countTeamList(param);
	    }

	    @Override
	    public int getWorkDays(Map<String, Object> param) {
	        return hrDAO.getWorkDays(param);
	    }

	    @Override
	    public String getteamName(int dno) {
	        return hrDAO.getteamName(dno);
	    }

	    @Override
	    public String getTeamName(int dno) {
	        return hrDAO.getTeamName(dno);
	    }


}
