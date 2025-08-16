package com.motiveon.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.motiveon.service.EmployeeService;

@Controller
@RequestMapping("/commons")
public class CommonsController {
	@Resource 
	private EmployeeService employeeService;
	
	@Autowired
	public CommonsController(EmployeeService employeeService) {
		this.employeeService = employeeService;
	}
	
	@GetMapping("/login")
	public String loginGet() {		
		String url = "/commons/loginForm";
		return url;
	}
	
	@GetMapping("/accessDenied")
    public String accessDenied() {
		String url = "/commons/accessDenied";
		return url;
	}

    @GetMapping("/loginTimeOut")
    public String loginTimeOut(Model model) throws Exception {
    	System.out.println("LoginController.loginTimeOut() 호출됨");
        String url = "/commons/sessionOut";
        model.addAttribute("message", "세션이 만료되었습니다. \\n 다시 로그인 해주세요");
        return url;
    }

    @GetMapping("/loginExpired")
    public String loginExpired(Model model) throws Exception {
        String url = "/commons/sessionOut";
        model.addAttribute("message", "다른 기기에서의 중복 로그인이 감지되었습니다. \\n 다시 로그인 해주세요");
        return url;
    }
	
	
//	@PostMapping("/index")
//	public String loginPost(int eno, String pwd,HttpSession session)throws Exception{
//		String url="redirect:/main";
//		
//		EmployeeVO employee=null;
//		employee = employeeService.getEmployee(eno);			
//				
//		if(employee!=null && pwd.equals(employee.getPwd())) { //로그인 성공.
//				session.setAttribute("loginUser",employee);
//		}else {  //아이디 불일치
//			url="redirect://login/main";
//		}	
//		
//		return url;
//	}
//	@GetMapping("/logout")
//	public String logout(HttpSession session) {
//		String url="redirect:/";
//		
//		session.invalidate(); //세션 갱신
//		
//		return url;
//	}

}