package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.PopUpVO;

public interface PopUpService {
    List<PopUpVO> getPopups(PageMaker pageMaker) throws SQLException;

    int getPopupCount(PageMaker pageMaker) throws SQLException;

    PopUpVO getPopupByPopNo(String popNo) throws SQLException;

    String getNextPopupSequence() throws SQLException;

    void addPopup(PopUpVO popup) throws SQLException;

	public static PopUpVO getPopUp(String popNo) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

    
    void updatePopup(PopUpVO popup) throws SQLException;

    void removePopup(String popNo) throws SQLException;

	public List<PopUpVO> list(PageMaker pageMaker) throws SQLException;

	static PopUpVO detail(String popNo) {
		// TODO Auto-generated method stub
		return null;
	}


	}
