package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.EmployeeAccountVO;

public interface AccountDAO {

    // 계정 목록 조회 (페이징)
    List<EmployeeAccountVO> selectAccountList(PageMaker pageMaker) throws SQLException;

    // 계정 상세 조회
    EmployeeAccountVO selectAccountById(Integer empNo) throws SQLException;

    // 계정 등록
    void insertAccount(EmployeeAccountVO account) throws SQLException;

    // 계정 수정
    void updateAccount(EmployeeAccountVO account) throws SQLException;

    // 계정 삭제
    void deleteAccount(Integer empNo) throws SQLException;

    // (선택) 시퀀스 조회, 필요 시 사용
    int selectEmployeeSequenceNextValue() throws SQLException;
}