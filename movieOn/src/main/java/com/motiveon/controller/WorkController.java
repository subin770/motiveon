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
	
	@GetMapping("/officeMain")
	public String officeMain() {
		return "work/officeMain";
	}

}
