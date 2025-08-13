package com.motiveon.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.motiveon.dao.WorkDAO;
import com.motiveon.dto.WorkVO;

@Service
public class WorkServiceImpl implements WorkService {
    @Resource private WorkDAO workDAO;

    @org.springframework.transaction.annotation.Transactional
    @Override
    public void register(WorkVO vo) throws Exception {
        // 1) WORK
        workDAO.insertWork(vo); // vo.wcode 세팅됨

        // 2) WORKMANAGER (필수)
        workDAO.insertWorkManager(vo);

        // 3) 초기 본문이 있으면 댓글로 저장
        if (vo.getWcontent()!=null && !vo.getWcontent().trim().isEmpty()) {
            // 작성자는 요청자(eno)
            workDAO.insertInitReply(vo.getWcode(), vo.getEno(), vo.getWcontent());
        }
    }

    @Override
    public java.util.List<WorkVO> getList() throws Exception {
        return workDAO.selectWorkList();
    }
}
