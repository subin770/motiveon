package com.motiveon.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.AttachmentVO;
import com.motiveon.dto.PopUpVO;

public class PopUpDAOImpl implements PopUpDAO {

    private SqlSession session;
    public PopUpDAOImpl(SqlSession session) { this.session = session; }

    @Override
    public List<PopUpVO> selectPopupList(PageMaker pageMaker) throws SQLException {
        int startRow = pageMaker.getStartRow();
        int endRow = startRow + pageMaker.getPerPageNum() - 1;

        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("searchType", pageMaker.getSearchType());
        params.put("keyword", pageMaker.getKeyword());

        return session.selectList("Popup-Mapper.selectSearchPopupList", params);
    }

    @Override
    public void insertPopup(PopUpVO popup) throws SQLException {
        session.insert("Popup-Mapper.insertPopup", popup);
    }

    @Override
    public void updatePopup(PopUpVO popup) throws SQLException {
        session.update("Popup-Mapper.updatePopup", popup);
    }

    @Override
    public void deletePopup(String popNo) throws SQLException {
        session.delete("Popup-Mapper.deletePopup", popNo);
    }

    @Override
    public int selectPopUpSequenceNextValue() throws SQLException { return 0; }

    @Override
    public PopUpVO selectPopupByPopNo(String popNo) throws SQLException {
        return session.selectOne("Popup-Mapper.selectPopupByPopNo", popNo);
    }

    @Override
    public void insertAttachment(AttachmentVO attach) throws SQLException {
        session.insert("Popup-Mapper.insertAttachment", attach);
    }

    @Override
    public List<AttachmentVO> selectAttachmentsByPopNo(int popNo) throws SQLException {
        return session.selectList("Popup-Mapper.selectAttachmentsByPopNo", popNo);
    }
}