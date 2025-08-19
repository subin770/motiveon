package com.motiveon.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.motiveon.dto.ApprovalVO;
import com.motiveon.service.ApprovalService;

@Controller
@RequestMapping("/approval")
public class ApprovalController {

    @Autowired
    private ApprovalService approvalService;

    private static final Long FIXED_ENO = 10330125L;

    private Long getLoginEno(HttpSession session) {
        Long eno = (session != null) ? (Long) session.getAttribute("loginEno") : null;
        return (eno != null) ? eno : FIXED_ENO;
    }
    private Long getLoginDno(HttpSession session) {
        return (session != null) ? (Long) session.getAttribute("loginDno") : null;
    }
    private String getLoginDeptName(HttpSession session) {
        return (session != null) ? (String) session.getAttribute("loginDeptName") : null;
    }
    private String getLoginName(HttpSession session) {
        return (session != null) ? (String) session.getAttribute("loginName") : null;
    }
    private void ensureLoginEmp(HttpSession session) {
        Long eno = getLoginEno(session);
        String name = getLoginName(session);
        String dept = getLoginDeptName(session);
        Long dno = getLoginDno(session);
        if (name == null || dept == null || dno == null) {
            Map<String, Object> emp = approvalService.getEmpBasic(eno);
            if (emp != null) {
                if (name == null) session.setAttribute("loginName", (String) emp.get("NAME"));
                if (dept == null) session.setAttribute("loginDeptName", (String) emp.get("DEPTNAME"));
                if (dno == null) {
                    Object v = emp.get("DNO");
                    if (v instanceof Number) session.setAttribute("loginDno", ((Number) v).longValue());
                }
                if (session.getAttribute("loginEno") == null) session.setAttribute("loginEno", eno);
            }
        }
    }

    @GetMapping("/main")
    public String main(@RequestParam(value = "period", required = false, defaultValue = "all") String period,
                       @RequestParam(value = "field", required = false, defaultValue = "title") String field,
                       @RequestParam(value = "q", required = false, defaultValue = "") String q,
                       Model model, HttpSession session) {
        model.addAttribute("urgentCount",   approvalService.countUrgent());
        model.addAttribute("returnedCount", approvalService.countReturned());
        model.addAttribute("waitingCount",  approvalService.countWaiting());
        model.addAttribute("holdCount",     approvalService.countOnHold());
        model.addAttribute("recentDrafts",  approvalService.findRecentDrafts(period, field, q));
        model.addAttribute("ongoingDrafts", approvalService.findOngoingDrafts());
        model.addAttribute("toApprove",     approvalService.findMyTodo(getLoginEno(session)));
        return "approval/main";
    }

    @GetMapping("/viewerList")
    public String viewerList(@RequestParam(value = "period", required = false, defaultValue = "all") String period,
                             @RequestParam(value = "field", required = false, defaultValue = "title") String field,
                             @RequestParam(value = "q", required = false, defaultValue = "") String q,
                             @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                             @RequestParam(value = "size", required = false, defaultValue = "10") int size,
                             HttpSession session, Model model) {
        Long eno = getLoginEno(session);
        int totalCount = approvalService.viewerListCount(eno, period, field, q);
        if (size <= 0) size = 10;
        int totalPages = (int) Math.ceil(totalCount / (double) size);
        if (page < 1) page = 1;
        if (totalPages > 0 && page > totalPages) page = totalPages;
        int start = (page - 1) * size + 1;
        int end   = page * size;

        model.addAttribute("list", approvalService.viewerList(eno, period, field, q, start, end));
        model.addAttribute("period", period);
        model.addAttribute("field", field);
        model.addAttribute("q", q);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        return "approval/viewerList";
    }

    @GetMapping("/draftList")
    public String draftList(@RequestParam(value = "period", required = false, defaultValue = "all") String period,
                            @RequestParam(value = "field", required = false, defaultValue = "title") String field,
                            @RequestParam(value = "q", required = false, defaultValue = "") String q,
                            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                            @RequestParam(value = "size", required = false, defaultValue = "10") int size,
                            HttpSession session, Model model) {
        Long eno = getLoginEno(session);
        int totalCount = approvalService.draftListCount(eno, period, field, q);
        if (size <= 0) size = 10;
        int totalPages = (int) Math.ceil(totalCount / (double) size);
        if (page < 1) page = 1;
        if (totalPages > 0 && page > totalPages) page = totalPages;
        int start = (page - 1) * size + 1;
        int end   = page * size;

        model.addAttribute("list", approvalService.draftList(eno, period, field, q, start, end));
        model.addAttribute("period", period);
        model.addAttribute("field", field);
        model.addAttribute("q", q);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        return "approval/draftList";
    }

    @GetMapping("/new")
    public String newDraftLauncher() {
        return "redirect:/approval/formPicker";
    }

    @GetMapping("/formPicker")
    public String formPicker(Model model) {
        model.addAttribute("classes", approvalService.findFormClasses());
        model.addAttribute("formsAll", approvalService.findFormsAll());
        return "approval/formPicker";
    }

    @GetMapping("/compose")
    public String compose(@RequestParam("sformno") String sformNo, Model model, HttpSession session) {
        ensureLoginEmp(session);

        Map<String, Object> f = approvalService.getForm(sformNo);
        Map<String, Object> form = new HashMap<>();
        if (f != null) {
            form.put("formName", f.get("FORMNAME"));
            form.put("formHtml", f.get("FORMHTML"));
            form.put("sformNo",  f.get("SFORMNO"));
        }
        model.addAttribute("form", form);
        model.addAttribute("signNoPreview", approvalService.newDocNo());

        Map<String, Object> loginEmp = new HashMap<>();
        loginEmp.put("name",     getLoginName(session));
        loginEmp.put("deptName", getLoginDeptName(session));
        loginEmp.put("eno",      getLoginEno(session));
        loginEmp.put("dno",      getLoginDno(session));
        model.addAttribute("loginEmp", loginEmp);

        model.addAttribute("today", java.time.LocalDate.now().toString());
        return "approval/compose";
    }

    @PostMapping("/tempSave")
    public String tempSave(ApprovalVO vo, HttpSession session, RedirectAttributes rttr) {
        ensureLoginEmp(session);
        vo.setEno(getLoginEno(session));
        if (vo.getDno() == null) vo.setDno(getLoginDno(session));
        if (vo.getEmergency() == null) vo.setEmergency(0);
        String signNo = approvalService.saveTemp(vo);
        rttr.addFlashAttribute("savedSignNo", signNo);
        return "redirect:/approval/tempList";
    }

    @GetMapping("/tempList")
    public String tempList(@RequestParam(value = "period", required = false, defaultValue = "all") String period,
                           @RequestParam(value = "field", required = false, defaultValue = "title") String field,
                           @RequestParam(value = "q", required = false, defaultValue = "") String q,
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           HttpSession session, Model model) {
        Long eno = getLoginEno(session);
        int pageSize = 10;
        int start = (page - 1) * pageSize + 1;
        int end   = page * pageSize;

        Map<String, Object> p = new HashMap<>();
        p.put("eno", eno);
        p.put("period", period);
        p.put("field", field);
        p.put("q", q);
        p.put("start", start);
        p.put("end", end);

        int totalCount = approvalService.tempListCount(p);
        List<ApprovalVO> list = approvalService.tempList(p);

        model.addAttribute("list", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("period", period);
        model.addAttribute("field", field);
        model.addAttribute("q", q);
        return "approval/tempList";
    }

    @PostMapping(value = "/temp-save", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public Map<String, Object> tempSaveJson(@RequestBody ApprovalVO vo, HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        try {
            ensureLoginEmp(session);
            Long eno = getLoginEno(session);
            Long dno = getLoginDno(session);

            vo.setEno(eno);
            vo.setDno(dno);
            if (vo.getEmergency() == null) vo.setEmergency(0);

            String signNo = approvalService.saveTemp(vo);
            res.put("ok", true);
            res.put("signNo", signNo);
        } catch (Exception e) {
            res.put("ok", false);
            res.put("message", e.getMessage());
        }
        return res;
    }
}
