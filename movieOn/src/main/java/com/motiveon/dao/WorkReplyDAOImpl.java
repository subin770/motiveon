package com.motiveon.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier; // Spring의 Qualifier
import org.springframework.stereotype.Repository;

import com.motiveon.dto.ObjectionDTO;

/**
 * 업무 댓글/이의신청 DAO 구현체
 * 매퍼 네임스페이스: WorkReply-Mapper
 */
@Repository("workReplyDAO")
public class WorkReplyDAOImpl implements WorkReplyDAO {

    private final SqlSessionTemplate sqlSession;

    @Autowired
    public WorkReplyDAOImpl(@Qualifier("sqlSession") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    // ✅ 매퍼 네임스페이스 (대소문자 일관성 유지)
    private static final String NS = "WorkReply-Mapper.";

    /**
     * 이의신청 등록
     */
    @Override
    public void insertObjection(ObjectionDTO dto) {
        sqlSession.insert(NS + "insertObjection", dto);
    }
}
