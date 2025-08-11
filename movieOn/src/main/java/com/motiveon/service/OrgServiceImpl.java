package com.motiveon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrgServiceImpl implements OrgService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public List<Map<String, Object>> getOrgTree() {
        return sqlSession.selectList("Org-Mapper.selectOrgTree");
    }

    /**
     * JSTree 비동기 로딩용 children.
     * parent가 '#'이면 최상위 부서 목록, 아니면 해당 부서의 하위 부서 + 직원.
     */
    @Override
    public List<Map<String,Object>> getChildren(String parent){
        if (parent == null || "#".equals(parent)) {
            return sqlSession.selectList("Org-Mapper.selectChildrenRoot");
        } else {
            Map<String,Object> p = new HashMap<>();
            p.put("parent", parent); // 예: d-120
            return sqlSession.selectList("Org-Mapper.selectChildrenByDept", p);
        }
    }

    /**
     * 부서 생성. parent가 '#'(루트)이면 parent_dno = null.
     * 매퍼의 <selectKey>가 p.put("newDno", …) 를 채워줌.
     */
    @Override
    public Long createDepartment(String name, String parent) {
        Map<String,Object> p = new HashMap<>();
        p.put("name", name);
        p.put("parentDno",
              (parent == null || "#".equals(parent)) ? null
                  : Long.valueOf(parent.replace("d-","")));

        sqlSession.insert("Org-Mapper.insertDepartment", p);

        Object newDnoObj = p.get("newDno");
        return newDnoObj == null ? null : ((Number)newDnoObj).longValue();
    }

    /**
     * 노드 이름 변경 (부서/직원 모두 지원)
     */
    @Override
    public void renameNode(String id, String name) {
        if (id.startsWith("d-")) {
            Map<String,Object> m = new HashMap<>();
            m.put("dno",  id.replace("d-",""));
            m.put("name", name);
            sqlSession.update("Org-Mapper.renameDepartment", m);
        } else {
            Map<String,Object> m = new HashMap<>();
            m.put("eno",  id.replace("e-",""));
            m.put("name", name);
            sqlSession.update("Org-Mapper.renameEmployee", m);
        }
    }

    /**
     * 노드 삭제 (부서/직원)
     */
    @Override
    public void deleteNode(String id) {
        if (id.startsWith("d-")) {
            sqlSession.delete("Org-Mapper.deleteDepartment", id.replace("d-",""));
        } else {
            sqlSession.delete("Org-Mapper.deleteEmployee", id.replace("e-",""));
        }
    }

    /**
     * 드래그앤드롭 이동 반영.
     * pos는 같은 부모 내 정렬순서로 사용 (매퍼에서 order_no 업데이트).
     */
    @Override
    public void moveNode(String id, String parent, int pos, String oldParent) {
        final double orderNo = pos + 0.5; // 정렬 트릭

        if (id.startsWith("d-")) { // 부서
            Long dno = Long.valueOf(id.replace("d-",""));
            Long newParent = "#".equals(parent) ? null : Long.valueOf(parent.replace("d-",""));
            Long oldParentDno = (oldParent == null || "#".equals(oldParent)) ? null : Long.valueOf(oldParent.replace("d-",""));

            Map<String,Object> p = new HashMap<>();
            p.put("dno", dno);
            p.put("parentDno", newParent);
            p.put("orderNo", orderNo);
            sqlSession.update("Org-Mapper.updateDeptParentAndOrder", p);

            Map<String,Object> nx = Map.of("parentDno", newParent);
            sqlSession.update("Org-Mapper.compactDeptOrderForParent", nx);

            if (!java.util.Objects.equals(newParent, oldParentDno)) {
                Map<String,Object> ox = Map.of("parentDno", oldParentDno);
                sqlSession.update("Org-Mapper.compactDeptOrderForParent", ox);
            }

        } else { // 직원
            Long eno = Long.valueOf(id.replace("e-",""));
            Long newDept = Long.valueOf(parent.replace("d-",""));
            Long oldDept = (oldParent == null || "#".equals(oldParent)) ? null : Long.valueOf(oldParent.replace("d-",""));

            Map<String,Object> p = new HashMap<>();
            p.put("eno", eno);
            p.put("dno", newDept);
            p.put("orderNo", orderNo);
            sqlSession.update("Org-Mapper.updateEmpDeptAndOrder", p);

            Map<String,Object> nx = Map.of("dno", newDept);
            sqlSession.update("Org-Mapper.compactEmpOrderForParent", nx);

            if (!java.util.Objects.equals(newDept, oldDept)) {
                Map<String,Object> ox = Map.of("dno", oldDept);
                sqlSession.update("Org-Mapper.compactEmpOrderForParent", ox);
            }
        }
    }

}
