package com.motiveon.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.motiveon.dto.WorkManagerVO;

@Repository
public class WorkManagerDAOImpl implements WorkManagerDAO {
    private final SqlSession session;

    @Autowired  // 생성자 1개일 땐 생략 가능
    public WorkManagerDAOImpl(SqlSession session) {
        this.session = session;
    }

    private static final String NAMESPACE = "WorkManager-Mapper";

    @Override
    public void insertWorkManager(WorkManagerVO vo) {
        session.insert(NAMESPACE + ".insertWorkManager", vo);
    }

    @Override
    public List<WorkManagerVO> getByWcode(String wcode) {
        return session.selectList(NAMESPACE + ".getByWcode", wcode);
    }
}
