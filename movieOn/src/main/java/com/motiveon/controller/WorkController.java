package com.motiveon.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.motiveon.dto.WorkVO;
import com.motiveon.service.WorkService;

@Controller
@RequestMapping("/work")
public class WorkController {

	@Resource
	private WorkService workService;

	@GetMapping("/main")
	public String main(Model model) throws Exception {
	    model.addAttribute("list", workService.getList());
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

	@GetMapping("/registForm")
	public String registForm() {
		return "work/workRegistForm";
	}

	@PostMapping("/regist")
	public String regist(WorkVO work, HttpSession session, RedirectAttributes rttr) {
		try {
			// 로그인 있으면 세션 eno 고정
			com.motiveon.dto.EmployeeVO loginUser = (com.motiveon.dto.EmployeeVO) session.getAttribute("loginUser");
			if (loginUser != null)
				work.setEno(loginUser.getEno());
			else if (work.getEno() == null && work.getManagerEno() != null)
				work.setEno(work.getManagerEno()); // 개발 폴백

			// 기본값
			if (work.getWopen() == null)
				work.setWopen(0);
			if (work.getWalarm() == null)
				work.setWalarm(0);
			work.setWstatus("대기");

			// 필수 체크
			if (work.getWtitle() == null || work.getWtitle().trim().isEmpty() || work.getEno() == null
					|| work.getManagerEno() == null || work.getWend() == null) {
				rttr.addFlashAttribute("error", "필수값 누락");
				return "redirect:/work/registForm";
			}

			workService.register(work);
			rttr.addFlashAttribute("result", "OK");
			return "redirect:/work/list";
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("error", "서버오류");
			return "redirect:/work/registForm";
		}
	}

	@GetMapping("/list")
	public String list(Model model) {
		try {
			model.addAttribute("list", workService.getList());
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("list", java.util.Collections.emptyList());
		}
		return "work/workList";
	}

}
