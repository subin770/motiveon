package com.motiveon.controller;

import java.sql.SQLException;
import java.util.List;

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
import com.motiveon.dto.EmployeeAccountVO;
import com.motiveon.service.AccountService;

@Controller
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @GetMapping("/main")
    public void main() {}

    @GetMapping("/list")
    public void list(@ModelAttribute PageMaker pageMaker, Model model) throws SQLException {
        List<EmployeeAccountVO> accountList = accountService.getAccounts(pageMaker);
        model.addAttribute("accountList", accountList);
    }

    @GetMapping("/regist")
    public String regist() {
        return "account/regist";
    }

    @PostMapping("/regist")
    public String regist(EmployeeAccountVO account) throws SQLException {
        accountService.addAccount(account);
        return "account/regist_success";
    }

    @GetMapping("/detail")
    public void detail(@RequestParam("empNo") Integer empNo, Model model) throws SQLException {
        EmployeeAccountVO account = accountService.getAccountById(empNo);
        if (account == null) {
            throw new RuntimeException("해당 계정이 존재하지 않습니다.");
        }
        model.addAttribute("account", account);
    }

    @GetMapping("/modify")
    public String modify(@RequestParam("empNo") Integer empNo, Model model) throws SQLException {
        EmployeeAccountVO account = accountService.getAccountById(empNo);
        if (account == null) {
            throw new RuntimeException("해당 계정이 존재하지 않습니다.");
        }
        model.addAttribute("account", account);
        return "account/modify";
    }

    @PostMapping("/modify")
    public String modifySubmit(EmployeeAccountVO account, Model model) throws SQLException {
        accountService.updateAccount(account);
        model.addAttribute("account", account);
        return "account/modify_success";
    }

    @GetMapping("/remove")
    public String remove(@RequestParam("empNo") Integer empNo) throws SQLException {
        accountService.removeAccount(empNo);
        return "redirect:/account/remove_success";
    }

    @RequestMapping(value = "/removeSelected", method = {RequestMethod.GET, RequestMethod.POST})
    public String removeSelected(@RequestParam("empNos") List<Integer> empNos) throws SQLException {
        for (Integer empNo : empNos) {
            accountService.removeAccount(empNo);
        }
        return "redirect:/account/list";
    }
}