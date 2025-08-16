package com.motiveon.dao;

import java.util.List;

import com.motiveon.dto.WorkManagerVO;

public interface WorkManagerDAO {
    void insertWorkManager(WorkManagerVO vo);

    // 추가
    List<WorkManagerVO> getByWcode(String wcode);
}