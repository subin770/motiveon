package com.motiveon.controller;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.ObjectionDTO;
import com.motiveon.dto.WorkManagerVO;
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

        int requesterEno = loginUser.getEno();
        int assigneeEno = (ownerEno != null) ? ownerEno : requesterEno;

        form.setDno(loginUser.getDno()); // 부서번호
        if (form.getWstatus() == null || form.getWstatus().isEmpty()) {
            form.setWstatus("WAIT");
        }
        form.setEno(assigneeEno);

        // service 내부에서 WORK + WORKMANAGER 모두 저장
        workService.regist(form, requesterEno, assigneeEno);

        rttr.addFlashAttribute("message", "업무가 등록되었습니다.");
        // ✅ 등록 후 "내 업무 목록"으로 고정 이동
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

    /** 대기 상세 */
    @GetMapping("/waitDetail")
    public String waitDetail(@RequestParam("wcode") String wcode, Model model) {
        WorkVO work = workService.getWorkDetail(wcode);
        List<WorkManagerVO> managers = workService.getWorkManagersByWcode(wcode);

        model.addAttribute("work", work);
        model.addAttribute("managers", managers);

        return "work/waitDetail";
    }

    /** ================== 승인/이의신청 ================== */
    @PostMapping("/approve")
    public String approve(@RequestParam("wcode") String wcode,
                          @SessionAttribute("loginUser") EmployeeVO me,
                          RedirectAttributes rttr) {
        workService.approve(wcode, me.getEno());
        rttr.addAttribute("wcode", wcode);
        return "redirect:/work/waitDetail";
    }

    @PostMapping("/objection")
    public String objection(@ModelAttribute ObjectionDTO dto,
                            @SessionAttribute("loginUser") EmployeeVO me,
                            RedirectAttributes rttr) {
        dto.setEno(me.getEno());
        workService.objection(dto);
        rttr.addAttribute("wcode", dto.getWcode());
        return "redirect:/work/detail";
    }

    /** ================== 목록 ================== */
    // 내 업무
    @GetMapping("/myWorkList")
    public String myWorkList(@RequestParam(defaultValue = "ALL") String status,
                             @SessionAttribute("loginUser") EmployeeVO me,
                             Model model) {
        model.addAttribute("workList", workService.myList(me.getEno(), status));
        model.addAttribute("status", status);
        return "work/myWorkList";   // /WEB-INF/views/work/myWorkList.jsp
    }

    // 요청한 업무
    @GetMapping("/toReqList")
    public String toReqList(@RequestParam(defaultValue = "ALL") String status,
                            @SessionAttribute("loginUser") EmployeeVO me,
                            Model model) {
        model.addAttribute("workList", workService.requestedList(me.getEno(), status));
        model.addAttribute("status", status);
        return "work/toReqList";    // /WEB-INF/views/work/toReqList.jsp
    }

    // 부서 업무
    @GetMapping("/depWorkList")
    public String depWorkList() {
        return "work/depWorkList";  // /WEB-INF/views/work/depWorkList.jsp
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
    public String main(@SessionAttribute("loginUser") EmployeeVO me, Model model) {
        int eno = me.getEno();
        model.addAttribute("weeklyClosingList", workService.getWeeklyClosingList(eno));
        model.addAttribute("weeklyRequestedList", workService.getWeeklyRequestedList(eno));
        model.addAttribute("pendingApprovalList", workService.getPendingApprovalList(eno));
        model.addAttribute("waitingRequestedList", workService.getWaitingRequestedList(eno));
        return "work/main";  // /WEB-INF/views/work/main.jsp
    }

    /** ================== 뷰 전용 (단순 이동) ================== */
    @GetMapping("/workRegistForm")
    public String workRegistForm() { 
        return "work/workRegistForm"; 
    }
}
