package com.motiveon.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.dto.MenuVO;
import com.motiveon.dto.NoticeVO;
import com.motiveon.service.MenuService;
import com.motiveon.service.NoticeService;

@Controller
public class MainController {

    @Autowired
    private MenuService menuService;

     @Autowired
        private NoticeService noticeService; 


    @GetMapping("/index")
    public String main(String mcode,Model model, HttpSession session) throws Exception{
        String url="/main";

        EmployeeVO loginUser = (EmployeeVO)session.getAttribute("loginUser");

        if(loginUser == null){
            return "redirect:/";
        }

        List<MenuVO> menuList = menuService.getMainMenuList();

        model.addAttribute("menuList",menuList);

        MenuVO menu = null;
        if (mcode != null) {
            menu = menuService.getMenuByMcode(mcode);
        }else {
            menu = menuService.getMenuByMcode("M000000");
        }
        model.addAttribute("menu", menu);

        return "main";
    }

    @GetMapping("/user/home")
    public String userHome() {
        return "redirect:/home/main";
    }


     @RequestMapping("/home/main")
        public String indexPage(Model model) {
            model.addAttribute("sidebarPath", "NONE"); // 사이드바 표시 안 함

            List<NoticeVO> noticeList = noticeService.getRecentNotices();
            model.addAttribute("noticeList", noticeList);



            return "main/main"; // index.jsp 같은 페이지
        }
}