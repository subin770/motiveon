package com.motiveon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.motiveon.dto.MenuVO;
import com.motiveon.dto.NoticeVO;
import com.motiveon.service.MenuService;
import com.motiveon.service.NoticeService; // ✅ 반드시 import

@Controller
public class MainController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private NoticeService noticeService; // ✅ 누락된 부분

    @GetMapping("/index")
    public String main(String mcode, Model model) throws Exception {
        String url = "main";

        List<MenuVO> menuList = menuService.getMainMenuList();
        model.addAttribute("menuList", menuList);

        MenuVO menu = (mcode != null)
            ? menuService.getMenuByMcode(mcode)
            : menuService.getMenuByMcode("M000000");
        model.addAttribute("menu", menu);

        List<NoticeVO> noticeList = noticeService.getRecentNotices();
        model.addAttribute("noticeList", noticeList);

        return url;
    }
    
    @RequestMapping("/home/main")
    public String indexPage(Model model) {
        model.addAttribute("sidebarPath", "NONE"); // 사이드바 표시 안 함
        
        List<NoticeVO> noticeList = noticeService.getRecentNotices();
        model.addAttribute("noticeList", noticeList);
        
        return "main/main"; // index.jsp 같은 페이지
    }

}
