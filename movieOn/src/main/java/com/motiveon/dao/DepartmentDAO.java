package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.DepartmentVO;

public interface DepartmentDAO {

    // 부서 목록 조회 (페이징 가능)
    List<DepartmentVO> selectDepartmentList(PageMaker pageMaker) throws SQLException;

    // dno로 부서 조회
    DepartmentVO selectDepartmentByDno(int dno) throws SQLException;

    // 시퀀스에서 다음 dno 가져오기
    int selectDepartmentSequenceNextValue() throws SQLException;

    // 부서 등록
    void insertDepartment(DepartmentVO department) throws SQLException;

    // 부서 수정
    void updateDepartment(DepartmentVO department) throws SQLException;

    // 부서 삭제
    void deleteDepartment(int dno) throws SQLException;
}