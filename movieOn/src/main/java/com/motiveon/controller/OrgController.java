package com.motiveon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

import com.motiveon.service.OrgService;

@Controller
@RequestMapping("/org")
public class OrgController {

    @Autowired
    private OrgService orgService; 

    @GetMapping("/main")
    public String main() {
        return "org/main"; 
    }

    @GetMapping("/tree")
    @ResponseBody
    public List<Map<String, Object>> tree() {
        return orgService.getOrgTree(); 
    }
    @GetMapping("/children")
    @ResponseBody
    public List<Map<String,Object>> children(@RequestParam(defaultValue = "#") String parent){
        return orgService.getChildren(parent);
    }

    
 // 부서 생성
    @PostMapping("/department")
    @ResponseBody
    public Map<String,Object> createDept(@RequestParam String name,
                                         @RequestParam(required=false) String parent){ // 'd-xxx' or null
      Long newDno = orgService.createDepartment(name, parent);
      return Map.of("id", "d-" + newDno);
    }

    // 이름 변경 (부서/직원 공통)
    @PutMapping("/rename")
    @ResponseBody
    public void rename(@RequestParam String id, @RequestParam String name){
      orgService.renameNode(id, name);
    }

    // 삭제 (부서/직원)
    @DeleteMapping("/node")
    @ResponseBody
    public void deleteNode(@RequestParam String id){
      orgService.deleteNode(id);
    }

    // 이동(드래그앤드롭) : parent와 순서 반영
    @PostMapping("/move")
    @ResponseBody
    public void move(
            @RequestParam String id,
            @RequestParam String parent,
            @RequestParam int position,
            @RequestParam(required=false, name="oldParent") String oldParent) {

        orgService.moveNode(id, parent, position, oldParent);
    }

}
