package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.EmployeeAccountVO;

public interface AccountService {

    // 계정 리스트 조회 (페이징)
    List<EmployeeAccountVO> getAccounts(PageMaker pageMaker) throws SQLException;

    // 계정 총 개수 조회
    int getAccountCount(PageMaker pageMaker) throws SQLException;

    // 계정 상세 조회
    EmployeeAccountVO getAccountById(Integer empNo) throws SQLException;

    // 새 계정 등록
    void addAccount(EmployeeAccountVO account) throws SQLException;

    // 계정 수정
    void updateAccount(EmployeeAccountVO account) throws SQLException;

    // 계정 삭제
    void removeAccount(Integer empNo) throws SQLException;

}