package com.motiveon.controller;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.NoticeVO; // ✅ DTO 임포트 확인
import com.motiveon.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@GetMapping("/main")
	public String main(@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "pageSize", defaultValue = "20") int pageSize, Model model) throws Exception {

		PageMaker pageMaker = new PageMaker();
		pageMaker.setPage(page);
		pageMaker.setPerPageNum(pageSize);
		pageMaker.setSearchType(searchType != null ? searchType : "");
		pageMaker.setKeyword(keyword != null ? keyword : "");

		List<NoticeVO> noticeList = noticeService.getNoticeList(pageMaker);
		int totalCount = noticeService.getNoticeCount(pageMaker);
		NoticeVO fixedNotice = noticeService.getFixedNotice();

		model.addAttribute("notices", noticeList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pageCount", pageMaker.getRealEndPage());
		model.addAttribute("currentPage", page);
		model.addAttribute("fixedNotice", fixedNotice);

		return "notice/main";
	}

	@GetMapping("/write")
	public String writeForm(Model model) throws Exception {
		PageMaker pageMaker = new PageMaker();
		List<NoticeVO> noticeList = noticeService.getNoticeList(pageMaker);
		NoticeVO fixedNotice = noticeService.getFixedNotice();
		model.addAttribute("fixedNotice", fixedNotice);
		return "notice/write";
	}

	@PostMapping("/write")
	public String writeSubmit(@ModelAttribute NoticeVO notice) {

		notice.setViewcnt(0);
		notice.setEno(24530015);
		notice.setDno(530);

		noticeService.insertNotice(notice);
		return "redirect:/notice/main";
	}

	@GetMapping("/detail/{nno}")
	public String detail(@PathVariable int nno, Model model) {
		NoticeVO notice = noticeService.getNotice(nno);
		if (notice == null) {
			return "error/404";
		}
		model.addAttribute("notice", notice);
		return "notice/detail";
	}

	@GetMapping("/modify/{nno}")
	public String modifyForm(@PathVariable int nno, Model model) {
		model.addAttribute("notice", noticeService.getNotice(nno));

		return "notice/modify";
	}

	@PostMapping("/modify")
	public String modifySubmit(@ModelAttribute NoticeVO notice) {
		noticeService.updateNotice(notice);
		return "redirect:/notice/detail/" + notice.getNno();
	}

	@GetMapping("/delete/{nno}")
	public String delete(@PathVariable int nno) {
		noticeService.deleteNotice(nno);
		return "redirect:/notice/main";
	}
}
