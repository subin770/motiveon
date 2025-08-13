package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dao.PopUpDAO;
import com.motiveon.dto.PopUpVO;

public class PopUpServiceImpl implements PopUpService {

    private PopUpDAO popUpDAO;

    // 생성자 또는 setter 주입 가능
    public PopUpServiceImpl(PopUpDAO popUpDAO) {
        this.popUpDAO = popUpDAO;
    }
  
    @Override
    public List<PopUpVO> list(PageMaker pageMaker) throws SQLException {
        return popUpDAO.selectPopupList(pageMaker);
    }
   

    @Override
    public void addPopup(PopUpVO popup) throws SQLException {
        popUpDAO.insertPopup(popup);
    }

    @Override
    public void updatePopup(PopUpVO popup) throws SQLException {
        popUpDAO.updatePopup(popup);
    }

    @Override
    public void removePopup(String popNo) throws SQLException {
        popUpDAO.deletePopup(popNo);
    }

	@Override
	public List<PopUpVO> getPopups(PageMaker pageMaker) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPopupCount(PageMaker pageMaker) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	  @Override
	    public PopUpVO getPopupByPopNo(String popNo) throws SQLException {
	        return popUpDAO.selectPopupByPopNo(popNo);
	    }


	@Override
	public String getNextPopupSequence() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}