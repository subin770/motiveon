package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.NoticeVO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	private SqlSession sqlSession;

	@Autowired
    public NoticeDAOImpl(SqlSession session) { 
        this.sqlSession = session;
    }

    private static final String NAMESPACE = "Notice-Mapper.";

    @Override
    public List<NoticeVO> selectSearchNoticeList(PageMaker pageMaker) throws SQLException {
    	
        return sqlSession.selectList(NAMESPACE + "selectSearchNoticeList", pageMaker);
    }

    @Override
    public int selectSearchNoticeListCount(PageMaker pageMaker) throws SQLException {
        return sqlSession.selectOne(NAMESPACE + "selectSearchNoticeListCount", pageMaker);
    }

    @Override
    public NoticeVO selectNoticeByNno(int nno) throws SQLException {
        return sqlSession.selectOne(NAMESPACE + "selectNoticeByNno", nno);
    }

    @Override
    public void increaseViewCount(int nno) throws SQLException {
        sqlSession.update(NAMESPACE + "increaseViewCount", nno);
    }

    @Override
    public int selectNoticeSequenceNextValue() throws SQLException {
        return sqlSession.selectOne(NAMESPACE + "selectNoticeSequenceNextValue");
    }

    @Override
    public void insertNotice(NoticeVO notice) throws SQLException {
        sqlSession.insert(NAMESPACE + "insertNotice", notice);
    }

    @Override
    public void updateNotice(NoticeVO notice) throws SQLException {
        sqlSession.update(NAMESPACE + "updateNotice", notice);
    }

    @Override
    public void deleteNotice(int nno) throws SQLException {
        sqlSession.delete(NAMESPACE + "deleteNotice", nno);
    }
    
    @Override
    public List<NoticeVO> selectRecentNotices() throws SQLException {
        return sqlSession.selectList(NAMESPACE + "selectRecentNotices");}
    
    @Override
    public NoticeVO selectFixedNotice() throws SQLException {
        return sqlSession.selectOne("Notice-Mapper.selectFixedNotice");
    }

}
