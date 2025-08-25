package com.motiveon.service;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.AttachmentVO;
import com.motiveon.dto.PopUpVO;

public interface PopUpService {
    List<PopUpVO> list(PageMaker pageMaker) throws SQLException;
    void addPopup(PopUpVO popup) throws SQLException;
    void updatePopup(PopUpVO popup) throws SQLException;
    void removePopup(String popNo) throws SQLException;
    PopUpVO getPopupByPopNo(String popNo) throws SQLException;

    // 첨부파일 관련
    void addAttachment(AttachmentVO attach) throws SQLException;
    List<AttachmentVO> getAttachmentsByPopNo(int popNo) throws SQLException;
}