package com.motiveon.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.DepartmentVO;
import com.motiveon.service.DepartmentService;

@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @GetMapping("/main")
    public void main() {}

    // 부서 목록 페이지
    @GetMapping("/list")
    public void list(@ModelAttribute PageMaker pageMaker, Model model) throws Exception {
        List<DepartmentVO> departmentList = departmentService.list(pageMaker);      
        model.addAttribute("departmentList", departmentList);
    }   
    
    // 부서 등록 폼 페이지 이동
    @GetMapping("/regist")
    public String regist() {
        return "department/regist";
    }

    // 부서 등록 처리
    @PostMapping("/regist")
    public String registSubmit(DepartmentVO dept) throws SQLException {
        departmentService.addDepartment(dept);
        return "department/regist_success";
    }

    // 부서 상세보기
    @GetMapping("/detail")
    public void detail(int dno, Model model) throws Exception {
        DepartmentVO department = departmentService.getDepartmentByDno(dno);
        if (department == null) {
            throw new RuntimeException("해당 부서가 존재하지 않습니다.");
        }
        model.addAttribute("department", department);
    }

    // 부서 수정 폼 페이지
    @GetMapping("/modify")
    public String modify(int dno, Model model) throws SQLException {
        DepartmentVO department = departmentService.getDepartmentByDno(dno);
        if (department == null) {
            throw new RuntimeException("해당 부서가 존재하지 않습니다.");
        }
        model.addAttribute("department", department);
        return "department/modify";
    }

    @PostMapping("/modify")
    public String modifySubmit(DepartmentVO department, Model model) throws SQLException {
        departmentService.updateDepartment(department); 
        model.addAttribute("department", department);
        return "department/modify_success";
    }

    // 부서 삭제 처리
    @GetMapping("/remove")
    public String remove(int dno) throws SQLException {
        departmentService.removeDepartment(dno); 
        return "department/remove_success";    // 삭제 후 목록 페이지로 리다이렉트
    }

    @RequestMapping(value = "/removeSelected", method = {RequestMethod.GET, RequestMethod.POST})
    public String removeSelected(@RequestParam("deptNos") List<Integer> dnos) throws SQLException {
    	 for (int dno : dnos) {
             departmentService.removeDepartment(dno);
         }
    	    return "redirect:/department/list";
    }

}