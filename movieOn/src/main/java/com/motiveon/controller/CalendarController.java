package com.motiveon.controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.motiveon.dto.CalendarVO;
import com.motiveon.dto.EmployeeVO;
import com.motiveon.service.CalendarService;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

	@Resource 
	private CalendarService calendarService;
	
	@GetMapping("/main")
	public void starter() {

	}

	@PostMapping("/regist")
	public ResponseEntity<String> regist(@RequestBody CalendarVO calendar, HttpSession session) {
	    System.out.println("=== 등록 요청 도착 ===");
	    System.out.println(calendar.toString());

	    try {
	        // 1. 세션에서 사용자 eno 가져오기 (없으면 테스트용 eno 사용)
	        EmployeeVO loginUser = (EmployeeVO) session.getAttribute("loginUser");
	        if (loginUser != null) {
	            calendar.setEno(loginUser.getEno());
	        } else {
	            calendar.setEno(24330015); // 테스트용 eno
	        }

	        // 2. 문자열 → Date 형식으로 변환
	        calendar.setSdate(parseDate(calendar.getStart()));
	        calendar.setEdate(parseDate(calendar.getEnd()));

	        // 3. 등록 서비스 호출
	        calendarService.registCalendar(calendar);
	        return new ResponseEntity<>("success", HttpStatus.OK);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	// 날짜 파싱용 함수 (private으로 아래 추가)
	private Date parseDate(String dateStr) throws ParseException {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
	    return sdf.parse(dateStr);
	}

	@RequestMapping("/list")
	@ResponseBody
	public List<CalendarVO> getCalendarList() throws SQLException {  
	    return calendarService.getCalendarList();
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

