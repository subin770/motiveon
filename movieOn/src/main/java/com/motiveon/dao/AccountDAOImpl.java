package com.motiveon.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.EmployeeAccountVO;

public class AccountDAOImpl implements AccountDAO {

    private final SqlSession session;

    public AccountDAOImpl(SqlSession session) {
        this.session = session;
    }

    @Override
    public List<EmployeeAccountVO> selectAccountList(PageMaker pageMaker) throws SQLException {
        int startRow = pageMaker.getStartRow();
        int endRow = startRow + pageMaker.getPerPageNum() - 1;

        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("name", pageMaker.getKeyword());
        params.put("dept", pageMaker.getSearchType());

        return session.selectList("com.motiveon.mybatis.mappers.AccountMapper.selectAccounts", params);
    }

    @Override
    public EmployeeAccountVO selectAccountById(Integer empNo) throws SQLException {
        return session.selectOne("com.motiveon.mybatis.mappers.AccountMapper.selectAccountById", empNo);
    }

    @Override
    public void insertAccount(EmployeeAccountVO account) throws SQLException {
        session.insert("com.motiveon.mybatis.mappers.AccountMapper.insertAccount", account);
    }

    @Override
    public void updateAccount(EmployeeAccountVO account) throws SQLException {
        session.update("com.motiveon.mybatis.mappers.AccountMapper.updateAccount", account);
    }

    @Override
    public void deleteAccount(Integer empNo) throws SQLException {
        session.delete("com.motiveon.mybatis.mappers.AccountMapper.deleteAccount", empNo);
    }

    @Override
    public int selectEmployeeSequenceNextValue() throws SQLException {
        return session.selectOne("com.motiveon.mybatis.mappers.AccountMapper.selectEmployeeSequenceNextValue");
    }
}