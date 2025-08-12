package com.motiveon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/work")
public class WorkController {

	
	@GetMapping("/main")
	public String main() {
		return "work/main";
	}
	
// 목록 
	@GetMapping("/myWorkList")
	public String myWorkList() {
		return "work/myWorkList";
	}
	
	@GetMapping("/toReqList")
	public String toReqList() {
		return "work/toReqList";
	}
	
	@GetMapping("/depWorkList")
	public String depWorkList() {
		return "work/depWorkList";
	}
	
// 업무 등록 상세 수정 
	@GetMapping("/workRegistForm")
	public String workRegistForm() {
		return "work/workRegistForm";
	}
	
	@GetMapping("/workDetail")
	public String workDetail() {
		return "work/workDetail";
	}
	
	@GetMapping("/workModifyForm")
	public String workModifyForm() {
		return "work/workModifyForm";
	}
	
	
	@GetMapping("/waitDetail")
	public String waitDetail() {
		return "work/waitDetail";
	}

}
