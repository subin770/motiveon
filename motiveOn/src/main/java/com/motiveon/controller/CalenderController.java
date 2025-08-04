package com.motiveon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/calendar") 
public class CalenderController {

    @GetMapping("/main")
    public void starter() {
       
    }
    @GetMapping("/registForm")
    public String registForm() {
        return "calendar/regist"; 
    }
    @GetMapping("/modifyForm")
    public String modifyForm() {
    	return "calendar/modify"; 
    }
    
    @GetMapping("/detail")
    public String detail() {
    	return "calendar/detail"; 
    }
    
    @GetMapping("/search")
    public String search() {
    	return "calendar/search"; 
    }
}
