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

        // 요청자 등록
        WorkManagerVO requester = new WorkManagerVO();
        requester.setWcode(wcode);
        requester.setEno(requesterEno);
        requester.setWmstep(0);
        requester.setIsafter(0);
        requester.setAnswer("REQUESTER");
        workManagerDAO.insertWorkManager(requester);

        // 담당자 등록
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
    public List<WorkListDTO> getMyWorkList(int eno) {
        return workDAO.selectMyWorkList(eno);
    }

    @Override
    public List<WorkListDTO> getRequestedWorkList(int eno) {
        return workDAO.selectRequestedWorkList(eno);
    }

    @Override
    public WorkVO getWorkByWcode(String wcode) throws Exception {
        return workDAO.selectWorkDetail(wcode);
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

    @Override
    @Transactional
    public int insertObjection(WorkReplyVO reply) throws Exception {
        return workReplyDAO.insertObjection(reply);
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
    public List<WorkListDTO> getWaitingRequestedList(int requesterEno) {
        return workDAO.selectWaitingRequestedList(requesterEno);
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
    public void updateWorkStatus(String wcode, String status) {
        workDAO.updateWorkStatus(wcode, status);
    }

    /** ================== 요청자 / 담당자 ================== */

    @Override
    public List<WorkListDTO> getToReqList(int eno) {
        return workDAO.selectToReqList(eno);
    }

    
    /** ================== 부서 ================== */
    @Override
    public List<WorkListDTO> depWorkList(int dno) {
        return workDAO.selectDepWorkList(dno);
    }
    @Override
    public List<WorkListDTO> selectWeeklyClosingList(int eno) {
        return workDAO.selectWeeklyClosingList(eno);
    }

    @Override
    public List<WorkListDTO> selectWeeklyRequestedList(int eno) {
        return workDAO.selectWeeklyRequestedList(eno);
    }

    @Override
    public List<WorkListDTO> selectPendingApprovalList(int eno) {
        return workDAO.selectPendingApprovalList(eno);
    }

    @Override
    public List<WorkListDTO> selectWaitingRequestedList(int eno) {
        return workDAO.selectWaitingRequestedList(eno);
    }



    @Override
    public void updateStatus(String wcode, String status) {
        workDAO.updateStatus(wcode, status);
    }


    @Override
    public WorkVO getWorkDetail(String wcode) {
        return workDAO.selectWorkDetail(wcode);
    }

    @Override
    @Transactional
    public void approveWork(String wcode) {
        workDAO.updateStatus(wcode, "ING"); // 승인 시 상태: 진행
    }

    @Override
    @Transactional
    public void rejectWork(String wcode, String reason) {
        workDAO.updateStatus(wcode, "REJECT");
        workDAO.insertRejectReason(wcode, reason);
    }

    @Override
    @Transactional
    public void insertObjection(String wcode, String reason) {
        workDAO.insertObjection(wcode, reason);
    }

    @Override
    @Transactional
    public void deleteWork(String wcode) {
        workDAO.deleteWork(wcode);
    }
    




    @Override
    @Transactional
    public void insertObjection(ObjectionDTO dto) {
        workDAO.insertObjection(dto);
        // 상태도 "OBJECTION" 으로
        workDAO.updateStatus(dto.getWcode(), "OBJECTION");
    }
    
    @Override
    public void approveWork(String wcode, int eno) {
        Map<String, Object> param = new HashMap<>();
        param.put("wcode", wcode);
        param.put("eno", eno);
        workDAO.approveWork(param);  // Mapper의 approveWork 실행
    }

    @Override
    public void rejectWork(String wcode, int eno, String reason) {
        Map<String, Object> param = new HashMap<>();
        param.put("wcode", wcode);
        param.put("eno", eno);
        param.put("reason", reason);

        workDAO.rejectWork(param);           // WORK 테이블 상태 REJECT
        workDAO.insertRejectReason(param);   // 반려사유 로그 남기기
    }


    
}
