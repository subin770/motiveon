package com.motiveon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.motiveon.dao.WorkDAO;
import com.motiveon.dao.WorkManagerDAO;
import com.motiveon.dao.WorkReplyDAO;
import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkManagerVO;
import com.motiveon.dto.WorkReplyVO;
import com.motiveon.dto.WorkVO;

@Service
public class WorkServiceImpl implements WorkService {

    private final WorkDAO workDAO;
    private final WorkManagerDAO workManagerDAO;
    private final WorkReplyDAO workReplyDAO;

    @Autowired
    public WorkServiceImpl(WorkDAO workDAO, WorkManagerDAO workManagerDAO, WorkReplyDAO workReplyDAO) {
        this.workDAO = workDAO;
        this.workManagerDAO = workManagerDAO;
        this.workReplyDAO = workReplyDAO;
    }

    /** ================== 등록 ================== */
    @Transactional
    @Override
    public String regist(WorkVO work, int requesterEno, int ownerEno) {
        String wcode = workDAO.getNextWcode();
        work.setWcode(wcode);
        work.setEno(requesterEno); 

        workDAO.insertWork(work);

        // 요청자
        WorkManagerVO requester = new WorkManagerVO();
        requester.setWcode(wcode);
        requester.setEno(requesterEno);
        requester.setWmstep(0);
        requester.setIsafter(0);
        requester.setAnswer("REQUESTER");
        workManagerDAO.insertWorkManager(requester);

        // 담당자
        if (ownerEno != requesterEno) {
            WorkManagerVO owner = new WorkManagerVO();
            owner.setWcode(wcode);
            owner.setEno(ownerEno);
            owner.setWmstep(1);
            owner.setIsafter(0);
            owner.setAnswer("OWNER");
            workManagerDAO.insertWorkManager(owner);
        }

        return wcode;
    }

    /** ================== 상세 ================== */
    @Override
    public WorkVO getWorkDetail(String wcode) {
        return workDAO.selectWorkDetail(wcode);
    }

    @Override
    public WorkVO getWorkByWcode(String wcode) throws Exception {
        return workDAO.selectWorkDetail(wcode);
    }

    /** ================== 승인 ================== */
    @Transactional
    @Override
    public int approveWork(String wcode) throws Exception {
        return workDAO.updateWorkStatus(wcode, "승인", "APPROVED");
    }

    /** ================== 반려 ================== */
    @Transactional
    @Override
    public int rejectWork(String wcode, String reason) throws Exception {
        return workDAO.updateWorkStatus(wcode, "반려", "REJECT");
    }

    /** ================== 이의신청 ================== */
    @Override
    public void objection(ObjectionDTO dto) throws Exception {
        workReplyDAO.insertObjection(dto);
        workDAO.updateWorkStatus(dto.getWcode(), "OBJECTION", "대기");
    }

    @Override
    public List<WorkReplyVO> selectObjectionList(String wcode) throws Exception {
        return workReplyDAO.selectObjectionList(wcode);
    }

    @Override
    public WorkReplyVO selectObjectionByWrno(int wrno) throws Exception {
        return workReplyDAO.selectObjectionByWrno(wrno);
    }

    /** ================== 목록 ================== */
    @Override
    public List<WorkListDTO> myList(int eno, String status) {
        Map<String, Object> param = new HashMap<>();
        param.put("eno", eno);
        param.put("status", status);
        return workDAO.selectMyList(param);
    }

    @Override
    public List<WorkListDTO> requestedList(int eno, String status) {
        Map<String, Object> param = new HashMap<>();
        param.put("eno", eno);
        param.put("status", status);
        return workDAO.selectRequestedList(param);
    }

    @Override
    public List<WorkListDTO> selectMyList(Map<String, Object> params) {
        return workDAO.selectMyList(params);
    }

    /** ================== 수정 ================== */
    @Transactional
    @Override
    public void modify(WorkVO work, int eno) {
        work.setEno(eno);
        workDAO.updateWork(work);
    }

    /** ================== 대시보드 ================== */
    @Override
    public List<WorkListDTO> getWeeklyClosingList(int eno) {
        return workDAO.selectWeeklyClosingList(eno);
    }

    @Override
    public List<WorkListDTO> getWeeklyRequestedList(int eno) {
        return workDAO.selectWeeklyRequestedList(eno);
    }

    @Override
    public List<WorkListDTO> getPendingApprovalList(int eno) {
        return workDAO.selectPendingApprovalList(eno);
    }

    @Override
    public List<WorkListDTO> getWaitingRequestedList(int eno) {
        return workDAO.selectWaitingRequestedList(eno);
    }

    /** ================== 기타 ================== */
    @Override
    public List<WorkListDTO> getWorkList() {
        return workDAO.selectWorkList();
    }

    @Override
    public List<WorkManagerVO> getWorkManagersByWcode(String wcode) {
        return workManagerDAO.getByWcode(wcode);
    }

    /** ================== 상태 업데이트 ================== */
    @Override
    public int updateWorkStatus(String wcode, String status, String state) {
        return workDAO.updateWorkStatus(wcode, status, state);
    }


    @Override
    public List<WorkListDTO> depWorkList(int dno) {
        return workDAO.selectDepWorkList(dno);
    }
    @Override
    public void insertObjection(WorkReplyVO reply) {
        workDAO.insertObjection(reply);
    }

    @Override
    public void updateWorkStatus(String wcode, String status) {
        workDAO.updateWorkStatus(wcode, status);
    }

}
