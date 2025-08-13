package com.motiveon.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.motiveon.dto.WorkVO;

@Repository
public class WorkDAOImpl implements WorkDAO {
	@Resource(name = "sqlSession")
	private SqlSession session;
	private static final String NS = "Work-Mapper.";

	@Override
	public void insertWork(WorkVO vo) {
		session.insert(NS + "insertWork", vo);
	}

	@Override
	public void insertWorkManager(WorkVO vo) {
		session.insert(NS + "insertWorkManager", vo);
	}

	@Override
	public void insertInitReply(String wcode, Integer writerEno, String content) {
		java.util.Map<String, Object> p = new java.util.HashMap<>();
		p.put("wcode", wcode);
		p.put("writerEno", writerEno);
		p.put("content", content);
		session.insert(NS + "insertInitReply", p);
	}

	@Override
	public java.util.List<WorkVO> selectWorkList() {
		return session.selectList(NS + "selectWorkList");
	}
}