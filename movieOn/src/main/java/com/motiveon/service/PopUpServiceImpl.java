package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dao.PopUpDAO;
import com.motiveon.dto.AttachmentVO;
import com.motiveon.dto.PopUpVO;

public class PopUpServiceImpl implements PopUpService {

    private PopUpDAO popUpDAO;
    public PopUpServiceImpl(PopUpDAO popUpDAO) { this.popUpDAO = popUpDAO; }

    @Override
    public List<PopUpVO> list(PageMaker pageMaker) throws SQLException {
        List<PopUpVO> popUpList = popUpDAO.selectPopupList(pageMaker);
        for(PopUpVO popup : popUpList) {
            List<AttachmentVO> files = popUpDAO.selectAttachmentsByPopNo(Integer.parseInt(popup.getPopNo()));
            popup.setAttachList(files);
        }
        return popUpList;
    }

    @Override
    public void addPopup(PopUpVO popup) throws SQLException { popUpDAO.insertPopup(popup); }
    @Override
    public void updatePopup(PopUpVO popup) throws SQLException { popUpDAO.updatePopup(popup); }
    @Override
    public void removePopup(String popNo) throws SQLException { popUpDAO.deletePopup(popNo); }
    @Override
    public PopUpVO getPopupByPopNo(String popNo) throws SQLException {
    	PopUpVO popup = popUpDAO.selectPopupByPopNo(popNo);
        List<AttachmentVO> files = popUpDAO.selectAttachmentsByPopNo(Integer.parseInt(popNo));
        popup.setAttachList(files);
        return popup;
    }

    @Override
    public void addAttachment(AttachmentVO attach) throws SQLException { popUpDAO.insertAttachment(attach); }
    @Override
    public List<AttachmentVO> getAttachmentsByPopNo(int popNo) throws SQLException {
        return popUpDAO.selectAttachmentsByPopNo(popNo);
    }
}