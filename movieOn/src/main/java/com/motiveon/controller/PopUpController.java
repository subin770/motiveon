package com.motiveon.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.motiveon.command.PageMaker;
import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.PopUpVO;
import com.motiveon.service.PopUpService;

@Controller
@RequestMapping("/popup")
public class PopUpController {

	
    @Autowired
    private PopUpService popUpService;

    @GetMapping("/main")
    public void main() {}
    
    // 팝업 목록 페이지 (필요하면 구현)

	@GetMapping("/list")
	public void list(@ModelAttribute PageMaker pageMaker, Model model) throws Exception {
		List<PopUpVO> popUpList = popUpService.list(pageMaker);		
		model.addAttribute("popUpList",popUpList);
	}	
	
    // 팝업 등록 폼 페이지 이동
    @GetMapping("/regist")
    public String regist() {
        return "popup/regist";
    }

    // 팝업 등록 처리
    @PostMapping("/regist")
    public String registSubmit(PopUpVO popup) throws SQLException {
        popUpService.addPopup(popup);
        return "popup/regist_success";
    }
    
    @GetMapping("/detail")
	public void detail(String popNo, HttpServletRequest request,Model model)throws Exception{
		
		ServletContext ctx = request.getServletContext();
		
		HttpSession session = request.getSession();
		EmployeeVO employee = (EmployeeVO)session.getAttribute("loginUser");
		String key = "popup:"+employee.getEno()+popNo;
		
		PopUpVO popup = null;
		
		if(ctx.getAttribute(key) != null) {
		    popup = popUpService.getPopupByPopNo(popNo); // Service 메서드 호출
		} else {
		    ctx.setAttribute(key, key);
		    popup = popUpService.getPopupByPopNo(popNo); // 조회수 증가 로직 있으면 여기서
		}

		model.addAttribute("popup",popup);
	}
    
    // 팝업 수정 폼 페이지 (추가 구현 필요)
    @GetMapping("/modify")
    public String modify(String popNo, Model model) throws SQLException {
        // 기존 팝업 정보 가져오기
    	PopUpVO popup = popUpService.getPopupByPopNo(popNo);
        if (popup == null) {
            // 팝업이 없으면 예외 처리
            throw new RuntimeException("해당 팝업이 존재하지 않습니다.");
        }
        model.addAttribute("popup", popup);
        return "popup/modify"; // JSP 경로
    }

    @PostMapping("/modify")
    public String modifySubmit(PopUpVO popup, Model model) throws SQLException {
        popUpService.updatePopup(popup);
        model.addAttribute("popup", popup);
        return "popup/modify_success";
    }
    
    // 팝업 삭제 처리 (추가 구현 필요)
    @GetMapping("/remove")
    public String remove(String popNo) throws SQLException {
        popUpService.removePopup(popNo);  // 서비스에 삭제 메서드가 있어야 함
        return "popup/remove_success";    // 삭제 후 목록 페이지로 리다이렉트
    }

	@RequestMapping(value = "/removeSelected", method = { RequestMethod.GET, RequestMethod.POST})
    public String removeSelected(@RequestParam("popNos") List<String> popNos) throws SQLException {
        for (String popNo : popNos) {
            popUpService.removePopup(popNo);
        }
        return "redirect:/popup/list";
    }
   
}