/*
 * package com.motiveon.controller.rest;
 * 
 * import java.util.List; import java.util.Map;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.http.HttpStatus; import
 * org.springframework.http.ResponseEntity; import
 * org.springframework.web.bind.annotation.*;
 * 
 * import com.motiveon.command.Criteria; import com.motiveon.dto.CalendarVO;
 * import com.motiveon.service.CalendarService;
 * 
 * @RestController
 * 
 * @RequestMapping("/calendar") public class CalendarRestController {
 * 
 * @Autowired private CalendarService service;
 * 
 * @RequestMapping("/getCalendar") public ResponseEntity<List<CalendarVO>>
 * getCalendarList(Criteria cri, int eno) throws Exception { List<CalendarVO>
 * calendarList = service.getCalendarList(cri, eno); return new
 * ResponseEntity<>(calendarList, HttpStatus.OK); }
 * 
 * // 일정 삭제
 * 
 * @PostMapping("/deleteRest") public ResponseEntity<String>
 * deleteCalendar(@RequestBody Map<String, Object> map) { String ccode =
 * (String) map.get("ccode");
 * 
 * try { service.remove(ccode); return ResponseEntity.ok("success"); } catch
 * (Exception e) { e.printStackTrace(); return
 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail"); } }
 * 
 * }
 */
