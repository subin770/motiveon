package com.motiveon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/office")
public class OfficeController {

	/*
	 * @Autowired private OfficeService officeService;
	 */
    @GetMapping("/main")
    public String mainPage() {
        return "office/main"; 
    }

	/*
	 * @PostMapping("/folder/create")
	 * 
	 * @ResponseBody public String createFolder(@RequestBody FolderVO folder,
	 * HttpSession session) { EmployeeVO loginUser = (EmployeeVO)
	 * session.getAttribute("loginUser"); folder.setOwnerId(loginUser.getEno());
	 * 
	 * int result = officeService.insertFolder(folder); return result > 0 ? "OK" :
	 * "FAIL"; }
	 * 
	 * @GetMapping("/folder/list")
	 * 
	 * @ResponseBody public List<FolderVO> getFolderList(HttpSession session) {
	 * EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser"); return
	 * officeService.getFolderListByOwner(loginUser.getEno()); }
	 */
}