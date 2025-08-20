package com.motiveon.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkReplyVO;

@Repository
public class WorkReplyDAOImpl implements WorkReplyDAO {

    @Autowired
    private SqlSession session;

    private static final String NS = "WorkReply-Mapper"; 
    
    @Override
    public void insertObjection(ObjectionDTO dto) throws Exception {
        session.insert(NS + ".insertObjection", dto);
    }

    @Override
    public List<WorkReplyVO> selectObjectionList(String wcode) throws Exception {
        return session.selectList(NS + ".selectObjectionList", wcode);
    }

    @Override
    public WorkReplyVO selectObjectionByWrno(int wrno) throws Exception {
        return session.selectOne(NS + ".selectObjectionByWrno", wrno);
    }

    @Override
    public int insertObjection(WorkReplyVO reply) throws Exception {
        return session.insert(NS + ".insertObjection", reply);
    }
}
