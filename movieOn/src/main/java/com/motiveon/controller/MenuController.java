package com.motiveon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.motiveon.dto.MenuVO;
import com.motiveon.service.MenuService;

@RestController
@RequestMapping("/menu")
public class MenuController {
	
	@Autowired
	private MenuService menuService;

	@GetMapping("/subMenu")
	public List<MenuVO> subMenuToJSON(String mcode) throws Exception {
		List<MenuVO> menuList = menuService.getSubMenuList(mcode);
		return menuList;
	}
}
