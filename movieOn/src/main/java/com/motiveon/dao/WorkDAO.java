package com.motiveon.dao;

import com.motiveon.dto.WorkVO;

public interface WorkDAO {
    void insertWork(WorkVO vo) throws Exception;
    void insertWorkManager(WorkVO vo) throws Exception;
    void insertInitReply(String wcode, Integer writerEno, String content) throws Exception;
    java.util.List<WorkVO> selectWorkList() throws Exception;
}
