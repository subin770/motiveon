package com.motiveon.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.DepartmentVO;

public class DepartmentDAOImpl implements DepartmentDAO {

    private SqlSession session;

    public DepartmentDAOImpl(SqlSession session) {
        this.session = session;
    }

    @Override
    public List<DepartmentVO> selectDepartmentList(PageMaker pageMaker) throws SQLException {
        int startRow = pageMaker.getStartRow();
        int endRow = startRow + pageMaker.getPerPageNum() - 1;

        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("name", pageMaker.getKeyword());  // 검색 키워드
        params.put("enabled", pageMaker.getEnabled()); // 상태 검색 등 필요시

        return session.selectList("Department-Mapper.list", params);
    }

    @Override
    public DepartmentVO selectDepartmentByDno(int dno) throws SQLException {
        return session.selectOne("Department-Mapper.getDepartmentByDno", dno);
    }

    @Override
    public int selectDepartmentSequenceNextValue() throws SQLException {
        return session.selectOne("Department-Mapper.getNextDepartmentSequence");
    }

    @Override
    public void insertDepartment(DepartmentVO department) throws SQLException {
        session.insert("Department-Mapper.addDepartment", department);
    }

    @Override
    public void updateDepartment(DepartmentVO department) throws SQLException {
        session.update("Department-Mapper.updateDepartment", department);
    }

    @Override
    public void deleteDepartment(int dno) throws SQLException {
        session.delete("Department-Mapper.removeDepartment", dno);
    }
}