package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.DepartmentVO;

public interface DepartmentService {

    // 부서 목록 조회 (페이징 가능)
    List<DepartmentVO> list(PageMaker pageMaker) throws SQLException;

    // 전체 부서 수 조회 (페이징용)
    int getDepartmentCount(PageMaker pageMaker) throws SQLException;

    // dno로 부서 조회
    DepartmentVO getDepartmentByDno(int dno) throws SQLException;

    // 신규 부서 코드 생성 (시퀀스 사용)
    int getNextDepartmentSequence() throws SQLException;

    // 부서 등록
    void addDepartment(DepartmentVO department) throws SQLException;

    // 부서 수정
    void updateDepartment(DepartmentVO department) throws SQLException;

    // 부서 삭제
    void removeDepartment(int dno) throws SQLException;
}