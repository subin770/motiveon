package com.motiveon.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.service.HrService;

@Controller
@RequestMapping("/ehr")
public class EhrController {

	private HrService hrService;

	@Autowired
	public EhrController(HrService hrService) {
		this.hrService = hrService;
	}

	@GetMapping("/main")
	public ModelAndView main(ModelAndView mnv) throws Exception {

		String url = "ehr/main";

//		EmployeeVO loginUser = (EmployeeVO)session.getAttribute("loginUser");

		EmployeeVO employee = null;
//		employee = hrService.getEmp(eno);
		int eno = 24330015; // 임시하드코딩
		employee = hrService.getEmp(eno);

		Calendar calendar = Calendar.getInstance();
		Date today = calendar.getTime();

		mnv.addObject("standardDate", today);
		mnv.addObject("employee", employee);
		mnv.setViewName(url);

		return mnv;
	}

	@GetMapping("/teamList")
    public String teamList(
            @RequestParam(value = "year", required = false) Integer year,
            @RequestParam(value = "month", required = false) Integer month,
            // @RequestParam(value = "dno") Integer dno, //
            @RequestParam(value = "sort", defaultValue = "job") String sort,
            @RequestParam(value = "order", defaultValue = "asc") String order,
            @RequestParam(value = "q", required = false) String q,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            Model model
    ) {
        // 현재 날짜로 기본값 설정
        LocalDate now = LocalDate.now();
        if (year == null) year = now.getYear();
        if (month == null) month = now.getMonthValue();
        
       // if (dno == null) dno = 330;  //
        
        int dno = 330;
        int workDays = countBusinessDays(year, month);

        Map<String, Object> param = new HashMap<>();
        param.put("year", year);
        param.put("month", String.format("%02d", month));
        param.put("dno", dno);
        param.put("sort", sort);
        param.put("order", order);
        param.put("q", (q != null && !q.trim().isEmpty()) ? q.trim() : null);
        param.put("offset", (page - 1) * size);
        param.put("size", size);

        List<Map<String, Object>> list = hrService.getTeamList(param);
        int totalCount = hrService.countTeamList(param);
        int totalPages = (int) Math.ceil((double) totalCount / size);

        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("dno", dno);
        model.addAttribute("sort", sort);
        model.addAttribute("order", order);
        model.addAttribute("q", q);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("list", list);
        model.addAttribute("workDays", workDays);
        model.addAttribute("teamName", hrService.getteamName(dno));
        
        System.out.println("[teamList] workDays(calc)=" + workDays);

     // ... 조회 후
     System.out.println("[teamList] OUT teamName=" + "teamName" + ", totalCount=" + totalCount + ", totalPages=" + totalPages + ", workDays=" + workDays);
     if (list != null) {
         for (int i = 0; i < Math.min(5, list.size()); i++) {
             Map<String,Object> r = list.get(i);
             System.out.println(" -> row" + (i+1) + " eno=" + r.get("eno") + ", name=" + r.get("name")
                 + ", late=" + r.get("late") + ", earlyLeave=" + r.get("earlyLeave")
                 + ", vacation=" + r.get("vacation") + ", absent=" + r.get("absent")
                 + ", present=" + r.get("present") + ", rate=" + r.get("rate"));
         }
     }
     

        return "ehr/teamList";
    }

	private int countBusinessDays(int year, int month) {
	    LocalDate start = LocalDate.of(year, month, 1);
	    LocalDate end = start.withDayOfMonth(start.lengthOfMonth());

	    int days = 0;
	    for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
	        DayOfWeek dayOfWeek = date.getDayOfWeek();
	        if (dayOfWeek != DayOfWeek.SATURDAY && dayOfWeek != DayOfWeek.SUNDAY) {
	            days++;
	        }
	    }
	    return days;
	}
}
