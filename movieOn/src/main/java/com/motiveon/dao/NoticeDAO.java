package com.motiveon.dao;

import java.sql.SQLException;
import java.util.List;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.NoticeVO; // ✅ 반드시 추가

public interface NoticeDAO {

    // 공지사항 목록 조회 (페이징 포함)
    List<NoticeVO> selectSearchNoticeList(PageMaker pageMaker) throws SQLException;

    // 전체 개수 조회 (페이징용)
    int selectSearchNoticeListCount(PageMaker pageMaker) throws SQLException;

    // 공지사항 상세 조회
    NoticeVO selectNoticeByNno(int nno) throws SQLException;

    // 조회수 증가
    void increaseViewCount(int nno) throws SQLException;

    // 시퀀스 값 가져오기
    int selectNoticeSequenceNextValue() throws SQLException;

    // 공지사항 등록
    void insertNotice(NoticeVO notice) throws SQLException;

    // 공지사항 수정
    void updateNotice(NoticeVO notice) throws SQLException;

 // 공지사항 삭제
	void deleteNotice(int nno) throws SQLException;

	List<NoticeVO> selectRecentNotices() throws SQLException;
	
	
	NoticeVO selectFixedNotice() throws SQLException;


    // 공지사항 목록 (DTO 형태로 반환하고 싶다면, DTO 클래스도 정의되어 있어야 함)
    // 없으면 삭제하거나 필요 시 정의
    // List<NoticeDTO> selectSearchNoticeDTOList(PageMaker pageMaker) throws SQLException;
}


