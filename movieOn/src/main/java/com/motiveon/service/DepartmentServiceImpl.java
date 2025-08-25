package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dao.DepartmentDAO;
import com.motiveon.dto.DepartmentVO;

public class DepartmentServiceImpl implements DepartmentService {

    private DepartmentDAO departmentDAO;

    // 생성자 또는 setter 주입 가능
    public DepartmentServiceImpl(DepartmentDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }

    @Override
    public List<DepartmentVO> list(PageMaker pageMaker) throws SQLException {
        return departmentDAO.selectDepartmentList(pageMaker);
    }

    @Override
    public int getDepartmentCount(PageMaker pageMaker) throws SQLException {
        // 필요하면 DAO에 페이징용 count 메서드 구현
        return 0; // 구현 필요
    }

    @Override
    public DepartmentVO getDepartmentByDno(int dno) throws SQLException {
        return departmentDAO.selectDepartmentByDno(dno);
    }

    @Override
    public int getNextDepartmentSequence() throws SQLException {
        return departmentDAO.selectDepartmentSequenceNextValue();
    }

    @Override
    public void addDepartment(DepartmentVO department) throws SQLException {
        departmentDAO.insertDepartment(department);
    }

    @Override
    public void updateDepartment(DepartmentVO department) throws SQLException {
        departmentDAO.updateDepartment(department);
    }

    @Override
    public void removeDepartment(int dno) throws SQLException {
        departmentDAO.deleteDepartment(dno);
    }
}