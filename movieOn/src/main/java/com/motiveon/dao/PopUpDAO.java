package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;  // PageMaker는 별도 정의 필요
import com.motiveon.dto.AttachmentVO;
import com.motiveon.dto.PopUpVO;

public interface PopUpDAO {
    List<PopUpVO> selectPopupList(PageMaker pageMaker) throws SQLException;

    PopUpVO selectPopupByPopNo(String popNo) throws SQLException;
    
 // Notice_seq.nextval 가져오기
 	int selectPopUpSequenceNextValue() throws SQLException;


    void insertPopup(PopUpVO popup) throws SQLException;

    void updatePopup(PopUpVO popup) throws SQLException;

    void deletePopup(String popNo) throws SQLException;
    
    // 첨부파일 관련
    void insertAttachment(AttachmentVO attach) throws SQLException;
    List<AttachmentVO> selectAttachmentsByPopNo(int popNo) throws SQLException;
}