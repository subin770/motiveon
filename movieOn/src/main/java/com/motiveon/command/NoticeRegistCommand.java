package com.motiveon.command;

import com.motiveon.dto.NoticeVO;

public class NoticeRegistCommand {

    private String title;
    private String content;

    // 테스트용: 로그인 없이 고정 값 사용
    private int eno = 0; // 작성자 번호 (비회원)
    private int dno = 0; // 부서 코드 (GUEST)

    // getter & setter
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

    public int getEno() {
        return eno;
    }

    public void setEno(int eno) {
        this.eno = eno;
    }

    public int getDno() {
        return dno;
    }

    public void setDno(int dno) {
        this.dno = dno;
    }

    // 폼 데이터를 VO 객체로 변환
    public NoticeVO toNoticeVO() {
        NoticeVO notice = new NoticeVO();
        notice.setTitle(this.title);
        notice.setContent(this.content);
        notice.setEno(this.eno);
        notice.setDno(this.dno);
        // viewcnt, regdate, updatedate는 DB에서 자동 처리됨
        return notice;
    }
}
