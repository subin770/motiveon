package com.motiveon.service;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.NoticeVO;
import java.util.List;

//NoticeService.java
public interface NoticeService {
	void insertNotice(NoticeVO notice);

	NoticeVO getNotice(int nno);

	void updateNotice(NoticeVO notice);

	void deleteNotice(int nno);

	List<NoticeVO> getNoticeList(PageMaker pageMaker);

	int getNoticeCount(PageMaker pageMaker);

	NoticeVO selectNoticeByNno(int nno);
	

    List<NoticeVO> getRecentNotices();
    
 // NoticeService.java
    List<NoticeVO> getFixedNoticeList() throws Exception;

	NoticeVO getFixedNotice() throws Exception;

 
}
