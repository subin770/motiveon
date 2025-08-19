package com.motiveon.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.motiveon.command.PageMaker;
import com.motiveon.dao.NoticeDAO;
import com.motiveon.dto.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	private final NoticeDAO noticeDAO;

    @Autowired
    public NoticeServiceImpl(NoticeDAO noticeDAO) { // ← 이름/타입 일치
        this.noticeDAO = noticeDAO;
    }


    @Override
    public void insertNotice(NoticeVO notice) {
        try {
            noticeDAO.insertNotice(notice);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public NoticeVO getNotice(int nno) {
        try {
            noticeDAO.increaseViewCount(nno);
            return noticeDAO.selectNoticeByNno(nno);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void updateNotice(NoticeVO notice) {
        try {
            noticeDAO.updateNotice(notice);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteNotice(int nno) {
        try {
            noticeDAO.deleteNotice(nno);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<NoticeVO> getNoticeList(PageMaker pageMaker) {
        try {
            return noticeDAO.selectSearchNoticeList(pageMaker);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int getNoticeCount(PageMaker pageMaker) {
        try {
            return noticeDAO.selectSearchNoticeListCount(pageMaker);
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }


    @Override
    public List<NoticeVO> getRecentNotices() {
        try {
            return noticeDAO.selectRecentNotices();
        } catch (SQLException e) {
            e.printStackTrace();  // 또는 로그 출력
            return new ArrayList<>();
        }
    }
   

    
 // NoticeServiceImpl.jav
    @Override
    public NoticeVO getFixedNotice() throws Exception {
        return noticeDAO.selectFixedNotice();
    }


	@Override
	public NoticeVO selectNoticeByNno(int nno) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<NoticeVO> getFixedNoticeList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	


}
