package com.motiveon.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.MenuVO;
import com.motiveon.service.MenuService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MenuService menuService;
	
    /**
     * 시스템 관리 (M060000)
     */
	@GetMapping("/main")
	public String mainRedirect(HttpSession session, Model model) {
	    EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
	    List<MenuVO> menuList = null;
	    try {
	        menuList = menuService.getMenuList();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    model.addAttribute("menuList", menuList);
	    model.addAttribute("loginUser", loginUser);
	    
	    if (loginUser != null && "ADMIN".equals(loginUser.getAuthority())) {
	        return "/popup/list";
	    }
	    return "/main"; 
	}

    /**
     * 인사정보 관리 (M070000)
     */
    @GetMapping("/account/list")
    public String accountList(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/commons/accessDenied";
        }
        return "/account/list"; // 인사정보 관리 JSP
    }

    /**
     * 조직도 관리 (M080000)
     */
    @GetMapping("/department/list")
    public String departmentList(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/commons/accessDenied";
        }
        return "/department/list"; // 조직도 관리 JSP
    }
    
    /**
     * 로그인 유저가 admin인지 체크
     */
    private boolean isAdmin(HttpSession session) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        return loginUser != null && "ADMIN".equals(loginUser.getAuthority());
    }
}