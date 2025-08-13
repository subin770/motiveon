package com.motiveon.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.MenuVO;
import com.motiveon.service.MenuService;

@Controller
public class AdminMainController {
	
	@Autowired
	private MenuService menuService;
	
	
	@GetMapping("/admin")
	public String main(String mcode,Model model, HttpSession session) throws Exception{
		String url="/main";
		
		EmployeeVO loginUser = (EmployeeVO)session.getAttribute("loginUser");
		
		if(loginUser == null){
			return "redirect:/";
		}
		
		List<MenuVO> menuList = menuService.getMainMenuList();
		
		model.addAttribute("menuList",menuList);
		
		MenuVO menu = null;
		if (mcode != null) {
			menu = menuService.getMenuByMcode(mcode);
		}else {
			menu = menuService.getMenuByMcode("M060000");
		}
		model.addAttribute("menu", menu);
		
		return url;
	}
}
