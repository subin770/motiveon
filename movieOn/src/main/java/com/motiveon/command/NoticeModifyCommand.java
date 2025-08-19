package com.motiveon.command;

import com.motiveon.dto.NoticeVO;

public class NoticeModifyCommand {

    private int nno;           // 공지사항 번호 (PK)
    private String title;      // 제목
    private String content;    // 내용

    // getter & setter
    public int getNno() {
        return nno;
    }

    public void setNno(int nno) {
        this.nno = nno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    // 수정 커맨드를 VO 객체로 변환
    public NoticeVO toNoticeVO() {
        NoticeVO notice = new NoticeVO();
        notice.setNno(this.nno);
        notice.setTitle(this.title);
        notice.setContent(this.content);
        // updatedate는 SQL에서 sysdate로 처리 가능
        return notice;
    }
}
