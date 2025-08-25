package com.motiveon.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkVO;
import com.motiveon.service.WorkService;

@Controller
@RequestMapping("/work")
public class WorkController {

    @Resource
    private WorkService workService;

    /** ================== 등록 ================== */
    @PostMapping("/regist")
    public String regist(@ModelAttribute WorkVO form,
                         @SessionAttribute("loginUser") EmployeeVO loginUser,
                         @RequestParam(value = "ownerEno", required = false) Integer ownerEno,
                         RedirectAttributes rttr) {

        int requesterEno = loginUser.getEno(); // 요청자
        int managerEno   = (ownerEno != null) ? ownerEno : requesterEno; // 담당자

        form.setDno(loginUser.getDno());
        if (form.getWstatus() == null || form.getWstatus().isEmpty()) {
            form.setWstatus("WAIT");
        }

        form.setRequesterEno(requesterEno);
        form.setManagerEno(managerEno);

        workService.regist(form, requesterEno, managerEno);

        rttr.addFlashAttribute("message", "업무가 등록되었습니다.");
        return "redirect:/work/myWorkList";
    }

    /** ================== 상세 ================== */
    @GetMapping("/workDetail")
    public String detail(@RequestParam("wcode") String wcode, Model model) {
        WorkVO work = workService.getWorkDetail(wcode);  // DB에서 데이터 조회
        model.addAttribute("work", work);
        return "work/workDetail";
    }
    
    // 내업무
    @GetMapping("/myList")
    public String myList(@SessionAttribute("loginUser") EmployeeVO loginUser, Model model) {
        List<WorkListDTO> list = workService.getMyWorkList(loginUser.getEno());
        model.addAttribute("workList", list);
        return "work/myWorkList";  // 내업무 JSP
    }

 // 요청한 업무 상세보기
    @GetMapping("/toReqDetail")
    public String toReqDetail(@RequestParam("wcode") String wcode, Model model) {
        WorkVO work = workService.getWorkDetail(wcode);
        model.addAttribute("work", work);
        return "work/toReqDetail";  // JSP 경로
    }


    /** 요청한 업무 상세보기 */
    @GetMapping("/workReqDetail")
    public String workReqDetail(@RequestParam("wcode") String wcode, Model model) {
        WorkVO work = workService.getWorkDetail(wcode);
        model.addAttribute("work", work);
        return "work/workReqDetail";
    }

    /** ================== 승인/반려/이의 ================== */
    @PostMapping("/approve")
    @ResponseBody
    public String approve(@RequestParam String wcode,
                          @SessionAttribute("loginUser") EmployeeVO loginUser) {
        workService.approveWork(wcode, loginUser.getEno());
        return "success"; // 반드시 소문자 success 리턴
    }

    @PostMapping("/reject")
    @ResponseBody
    public String reject(@RequestParam String wcode,
                         @RequestParam String reason,
                         @SessionAttribute("loginUser") EmployeeVO loginUser) {
        workService.rejectWork(wcode, loginUser.getEno(), reason);
        return "success";
    }




    @PostMapping("/objection")
    @ResponseBody
    public String objection(@RequestParam("wcode") String wcode,
                            @RequestParam("reason") String reason) {
        workService.insertObjection(wcode, reason);
        return "OK";
    }

    /** 삭제 */
    @PostMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam("wcode") String wcode) {
        workService.deleteWork(wcode);
        return "OK";
    }

    /** ================== 목록 ================== */
    @GetMapping("/myWorkList")
    public String myWorkList(HttpSession session, Model model) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        int eno = loginUser.getEno();
        List<WorkListDTO> myList = workService.getMyWorkList(eno);
        model.addAttribute("myList", myList);
        return "work/myWorkList";
    }

    @GetMapping("/toReqList")
    public String toReqList(HttpSession session, Model model) {
        int eno = ((EmployeeVO) session.getAttribute("loginUser")).getEno();
        List<WorkListDTO> reqList = workService.getToReqList(eno);
        model.addAttribute("reqList", reqList);
        return "work/toReqList";
    }

    @GetMapping("/depWorkList")
    public String depWorkList(HttpSession session, Model model) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        List<WorkListDTO> list = workService.depWorkList(loginUser.getDno());
        model.addAttribute("workList", list);
        return "work/depWorkList";
    }

    @GetMapping("/pendingApproval")
    public String pendingApproval(HttpSession session, Model model) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        List<WorkListDTO> list = workService.getPendingApprovalList(loginUser.getEno());
        model.addAttribute("workList", list);
        return "work/pendingApproval";
    }

    /** ================== 등록/수정 폼 ================== */
    @GetMapping("/workRegistForm")
    public String workRegistForm(@RequestParam(value="wcode", required=false) String wcode,
                                 Model model,
                                 @SessionAttribute("loginUser") EmployeeVO loginUser) {

        if (wcode != null) { // 수정
            WorkVO work = workService.getWorkDetail(wcode);
            model.addAttribute("work", work);
            model.addAttribute("mode", "modify");
        } else { // 등록
            model.addAttribute("work", new WorkVO());
            model.addAttribute("mode", "regist");
        }

        model.addAttribute("loginUser", loginUser);
        return "work/workRegistForm";
    }

    /** 수정 처리 */
    @PostMapping("/modify")
    public String modifySubmit(@ModelAttribute WorkVO work,
                               RedirectAttributes rttr) {
        workService.modify(work, work.getManagerEno());
        rttr.addFlashAttribute("message", "업무가 수정되었습니다.");
        return "redirect:/work/myWorkList";
    }

    /** ================== 메인 ================== */
    @GetMapping("/main")
    public String main(HttpSession session, Model model) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        int eno = loginUser.getEno();

        model.addAttribute("weeklyClosingList", workService.selectWeeklyClosingList(eno));
        model.addAttribute("weeklyRequestedList", workService.selectWeeklyRequestedList(eno));
        model.addAttribute("pendingApprovalList", workService.selectPendingApprovalList(eno));
        model.addAttribute("waitingRequestedList", workService.selectWaitingRequestedList(eno));

        return "work/main";
    }

    /** 상태 변경 */
    @PostMapping("/updateStatus")
    @ResponseBody
    public String updateWorkStatus(@RequestParam("wcode") String wcode,
                                   @RequestParam("status") String status) {
        try {
            workService.updateWorkStatus(wcode, status);
            return "OK";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }
}
