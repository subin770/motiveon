package com.motiveon.service;

import com.motiveon.dto.WorkVO;

public interface WorkService {
    void register(WorkVO vo) throws Exception;
    java.util.List<WorkVO> getList() throws Exception;
}

