package com.motiveon.dao;

import com.motiveon.dto.ObjectionDTO;

/**
 * 업무 댓글/이의신청 DAO 인터페이스
 * 매퍼 네임스페이스: WorkReply-Mapper
 */
public interface WorkReplyDAO {

    /**
     * 이의신청 등록
     * @param dto 이의신청 DTO (wcode, eno, 사유 등 포함)
     */
    void insertObjection(ObjectionDTO dto);
}
