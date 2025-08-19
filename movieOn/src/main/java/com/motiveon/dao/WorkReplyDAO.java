package com.motiveon.dao;

import java.util.List;

import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkReplyVO;


public interface WorkReplyDAO {
	
    

    void insertObjection(ObjectionDTO dto) throws Exception;
    
 // 이의신청 목록 조회
    List<WorkReplyVO> selectObjectionList(String wcode) throws Exception;

    // wrno 기준 단건 조회
    WorkReplyVO selectObjectionByWrno(int wrno) throws Exception;

	int insertObjection(WorkReplyVO reply); 


}
