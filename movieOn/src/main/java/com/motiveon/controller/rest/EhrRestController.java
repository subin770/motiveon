package com.motiveon.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.motiveon.command.HrParamCommand;
import com.motiveon.dto.HrVO;
import com.motiveon.service.HrService;

@RestController
@RequestMapping("/ehr")
public class EhrRestController {
	
	@Autowired
	private HrService hrService;
	
	//월별 근태리스트
	@PostMapping("/monthHrList")
	public ResponseEntity<List<HrVO>> hrMonthList(@RequestBody HrParamCommand param) throws Exception{
		ResponseEntity<List<HrVO>> entity = null;
		List<HrVO> hrMonthList = null;
		
		try {
			hrMonthList = hrService.getHrMonthList(param.getEno(), param.getMonthStart());
			entity = new ResponseEntity<List<HrVO>>(hrMonthList, HttpStatus.OK);
		} catch(Exception e) {
			entity = new ResponseEntity<List<HrVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		
		return entity;
	}
}
