package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dao.AccountDAO;
import com.motiveon.dto.EmployeeAccountVO;

public class AccountServiceImpl implements AccountService {

    private final AccountDAO accountDAO;

    // 생성자 주입
    public AccountServiceImpl(AccountDAO accountDAO) {
        this.accountDAO = accountDAO;
    }

    @Override
    public List<EmployeeAccountVO> getAccounts(PageMaker pageMaker) throws SQLException {
        return accountDAO.selectAccountList(pageMaker);
    }

    @Override
    public int getAccountCount(PageMaker pageMaker) throws SQLException {
        // 필요 시 DAO에 count 쿼리 추가
        return 0;
    }

    @Override
    public EmployeeAccountVO getAccountById(Integer empNo) throws SQLException {
        return accountDAO.selectAccountById(empNo);
    }

    @Override
    public void addAccount(EmployeeAccountVO account) throws SQLException {
        // 필수값 체크
        if (account.getEmpNo() == null || account.getName() == null || account.getDeptName() == null) {
            throw new IllegalArgumentException("사번, 이름, 부서는 필수 입력 항목입니다.");
        }

        // null-safe 처리
        if(account.getPhone() == null) account.setPhone("");
        if(account.getDuty() == null) account.setDuty("");
        if(account.getJoinDate() == null) account.setJoinDate(null);
        if(account.getRole() == null) account.setRole("ROLE_USER");
        if(account.getPpsName() == null) account.setPpsName("");
        if(account.getEnabled() == null) account.setEnabled(1);

        accountDAO.insertAccount(account);
    }

    @Override
    public void updateAccount(EmployeeAccountVO account) throws SQLException {
        accountDAO.updateAccount(account);
    }

    @Override
    public void removeAccount(Integer empNo) throws SQLException {
        accountDAO.deleteAccount(empNo);
    }
}