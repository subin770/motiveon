package com.motiveon.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.motiveon.dao.WorkDAO;
import com.motiveon.dao.WorkManagerDAO;
import com.motiveon.dao.WorkReplyDAO;
import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkManagerVO;
import com.motiveon.dto.WorkVO;

@Service("workService")
public class WorkServiceImpl implements WorkService {

    private final WorkDAO workDAO;
    private final WorkManagerDAO workManagerDAO;
    private final WorkReplyDAO workReplyDAO;

    public WorkServiceImpl(WorkDAO workDAO,
                           WorkManagerDAO workManagerDAO,
                           WorkReplyDAO workReplyDAO) {
        this.workDAO = workDAO;
        this.workManagerDAO = workManagerDAO;
        this.workReplyDAO = workReplyDAO;
    }

    /** 등록 : WORK + WORKMANAGER */
    @Transactional
    @Override
    public String regist(WorkVO work, int requesterEno, int ownerEno) {
        // WCODE 채번
        String wcode = workDAO.getNextWcode();
        work.setWcode(wcode);

        // WORK 저장
        workDAO.insertWork(work);

        // 요청자 (wmstep=0)
        WorkManagerVO requester = new WorkManagerVO();
        requester.setWcode(wcode);
        requester.setEno(requesterEno);
        requester.setWmstep(0);
        requester.setIsafter(0);
        requester.setAnswer("REQUESTER");
        workManagerDAO.insertWorkManager(requester);

        // 담당자 (요청자와 다를 때, wmstep=1)
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

    /** 상세 조회 */
    @Override
    public WorkVO getWorkDetail(String wcode) {
        return workDAO.selectWorkDetail(wcode);
    }

    /** 승인 */
    @Transactional
    @Override
    public void approve(String wcode, int eno) {
        workDAO.updateApproval(wcode, eno);
    }

    /** 이의제기 */
    @Transactional
    @Override
    public void objection(ObjectionDTO dto) {
        workDAO.insertObjection(dto);
    }

    /** 내 업무 리스트 */
    @Override
    public List<WorkListDTO> myList(int eno, String status) {
        return workDAO.selectMyList(eno, status);
    }

    /** 내가 요청한 업무 리스트 */
    @Override
    public List<WorkListDTO> requestedList(int eno, String status) {
        return workDAO.selectRequestedList(eno, status);
    }

    /** 업무 수정 */
    @Transactional
    @Override
    public void modify(WorkVO work, int eno) {
        work.setEno(eno);
        workDAO.updateWork(work);
    }

    /** 주간 마감 업무 */
    @Override
    public List<WorkListDTO> getWeeklyClosingList(int eno) {
        return workDAO.selectWeeklyClosingList(eno);
    }

    /** 주간 요청 업무 */
    @Override
    public List<WorkListDTO> getWeeklyRequestedList(int eno) {
        return workDAO.selectWeeklyRequestedList(eno);
    }

    /** 결재 대기 업무 */
    @Override
    public List<WorkListDTO> getPendingApprovalList(int eno) {
        return workDAO.selectPendingApprovalList(eno);
    }

    /** 승인 대기 요청 업무 */
    @Override
    public List<WorkListDTO> getWaitingRequestedList(int eno) {
        return workDAO.selectWaitingRequestedList(eno);
    }

    /** 전체 업무 목록 */
    @Override
    public List<WorkListDTO> getWorkList() {
        return workDAO.selectWorkList();
    }

    /** WCODE 기준 담당자 목록 */
    @Override
    public List<WorkManagerVO> getWorkManagersByWcode(String wcode) {
        return workManagerDAO.getByWcode(wcode);
    }

	@Override
	public WorkVO getDetail(String wcode) {
		// TODO Auto-generated method stub
		return null;
	}
}
