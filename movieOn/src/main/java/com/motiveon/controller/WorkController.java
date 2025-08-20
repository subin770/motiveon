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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.WorkListDTO;
import com.motiveon.dto.WorkManagerVO;
import com.motiveon.dto.WorkReplyVO;
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

        // 파일 처리 (추후 구현)
        if (form.getFiles() != null) {
            for (MultipartFile f : form.getFiles()) {
                if (!f.isEmpty()) {
                    // 파일 업로드 로직
                }
            }
        }

        workService.regist(form, requesterEno, managerEno);

        rttr.addFlashAttribute("message", "업무가 등록되었습니다.");
        return "redirect:/work/myWorkList";
    }

    /** ================== 상세 ================== */
    @GetMapping("/detail")
    public String workDetail(@RequestParam("wcode") String wcode, Model model) {
        WorkVO work = workService.getWorkDetail(wcode);
        List<WorkManagerVO> managers = workService.getWorkManagersByWcode(wcode);

        model.addAttribute("work", work);
        model.addAttribute("managers", managers);
        return "work/workDetail";
    }

    /** 승인 처리 */
    @PostMapping("/approve")
    @ResponseBody
    public String approve(@RequestParam("wcode") String wcode) {
        try {
            int result = workService.approveWork(wcode);
            return result > 0 ? "SUCCESS" : "FAIL";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }

    /** 반려 처리 */
    @PostMapping("/reject")
    @ResponseBody
    public String reject(@RequestParam("wcode") String wcode, @RequestParam("reason") String reason) {
        try {
            int result = workService.rejectWork(wcode, reason);
            return result > 0 ? "SUCCESS" : "FAIL";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }

    /** 이의신청 처리 */
    @PostMapping("/objection")
    public String objection(@RequestParam String content,
                            @RequestParam String wcode,
                            HttpSession session,
                            RedirectAttributes rttr) throws Exception {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");

        WorkReplyVO reply = new WorkReplyVO();
        reply.setWcode(wcode);
        reply.setEno(loginUser.getEno());
        reply.setWrcontent(content);

        workService.insertObjection(reply);

        rttr.addFlashAttribute("message", "이의신청이 등록되었습니다.");
        return "redirect:/work/myWorkList";
    }

    /** ================== 목록 ================== */

    // 내가 담당자인 업무
    @GetMapping("/myWorkList")
    public String myWorkList(HttpSession session, Model model) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        int eno = loginUser.getEno();

        List<WorkListDTO> myList = workService.getMyWorkList(eno);

        // JSP에서 쓸 이름을 myList 로 고정
        model.addAttribute("myList", myList);

        return "work/myWorkList";
    }

    // 내가 요청한 업무
    @GetMapping("/toReqList")
    public String toReqList(HttpSession session, Model model) {
        int eno = ((EmployeeVO) session.getAttribute("loginUser")).getEno();
        List<WorkListDTO> reqList = workService.getToReqList(eno);
        model.addAttribute("reqList", reqList);
        return "work/toReqList";
    }

    // 대기중 업무
    @GetMapping("/waitDetail")
    public String waitDetail(Model model, HttpSession session) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            List<WorkListDTO> list = workService.getWaitingRequestedList(loginUser.getEno());
            model.addAttribute("workList", list);
        }
        return "work/waitDetail";
    }

    // 부서 업무
    @GetMapping("/depWorkList")
    public String depWorkList(Model model, HttpSession session) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            List<WorkListDTO> list = workService.depWorkList(loginUser.getDno());
            model.addAttribute("workList", list);
        }
        return "work/depWorkList";
    }

    // 승인 대기 업무
    @GetMapping("/pendingApproval")
    public String pendingApproval(Model model, HttpSession session) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            List<WorkListDTO> list = workService.getPendingApprovalList(loginUser.getEno());
            model.addAttribute("workList", list);
        }
        return "work/pendingApproval";
    }

    /** ================== 수정 ================== */
    @PostMapping("/modify")
    public String modify(@ModelAttribute WorkVO form,
                         @SessionAttribute("loginUser") EmployeeVO me,
                         RedirectAttributes rttr) {
        workService.modify(form, me.getEno());
        rttr.addFlashAttribute("message", "업무가 수정되었습니다.");
        rttr.addAttribute("wcode", form.getWcode());
        return "redirect:/work/detail";
    }

    /** ================== 메인 대시보드 ================== */
   
    @GetMapping("/main")
    public String main(Model model, HttpSession session) {
        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
        int eno = loginUser.getEno();

        // 금주 마감 업무
        List<WorkListDTO> weeklyClosingList = workService.selectWeeklyClosingList(eno);
        model.addAttribute("weeklyClosingList", weeklyClosingList);

        // 금주 요청한 업무
        List<WorkListDTO> weeklyRequestedList = workService.selectWeeklyRequestedList(eno);
        model.addAttribute("weeklyRequestedList", weeklyRequestedList);

        // 승인 대기 업무
        List<WorkListDTO> pendingApprovalList = workService.selectPendingApprovalList(eno);
        model.addAttribute("pendingApprovalList", pendingApprovalList);

        // 대기중 요청 업무
        List<WorkListDTO> waitingRequestedList = workService.selectWaitingRequestedList(eno);
        model.addAttribute("waitingRequestedList", waitingRequestedList);

        return "work/main";
    }
    @GetMapping("/workDetail")
    public String workDetail() {
        return "work/workDetail";
    }



    /** ================== 뷰 전용 ================== */
    @GetMapping("/workRegistForm")
    public String workRegistForm() {
        return "work/workRegistForm";
    }

    /** ================== 상태 변경 ================== */
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
