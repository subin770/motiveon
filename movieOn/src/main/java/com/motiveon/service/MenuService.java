package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.dto.MenuVO;

public interface MenuService {
	
	List<MenuVO> getMainMenuList() throws SQLException;
	
	List<MenuVO> getSubMenuList(String mCdoe) throws SQLException;
	
	MenuVO getMenuByMcode(String mCode) throws SQLException;
	
	MenuVO getMenuByMname(String mName) throws SQLException;
}
