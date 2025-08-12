package com.motiveon.controller;

import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
