<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link  href="https://cdn.jsdelivr.net/npm/jstree@3.3.16/dist/themes/default/style.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/jstree@3.3.16/dist/jstree.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet"/>

<style>
  #orgTree { padding:12px; }
  #orgTree .jstree-anchor { user-select: none; }
</style>

<div id="orgTree"></div>

<script>
$(function () {
  const $tree = $('#orgTree');
  try { $tree.jstree('destroy'); } catch(e) {}

  // 컨텍스트 메뉴
  function customMenu(node){
    const items = {};
    if (node.original && node.original.type === 'department') {
      items.createDept = {
        label: "부서 추가",
        action: function(){
          const name = (prompt("추가할 부서명을 입력하세요.") || '').trim();
          if(!name) return;
          $.post('<c:url value="/org/department"/>', { name, parent: node.id }, function(res){
            $tree.jstree(true).create_node(node, {
              id: res.id, parent: node.id, text: name, type: 'department', children: true
            }, "last", function(){ $tree.jstree('open_node', node); });
          }, 'json').fail(() => alert('부서 추가 실패'));
        }
      };
    }
    items.rename = {
      label: "이름 변경",
      action: function(){
        const name = (prompt("새로운 이름", node.text) || '').trim();
        if(!name) return;
        $.post('<c:url value="/org/rename"/>', { id: node.id, name })
          .done(() => $tree.jstree(true).rename_node(node, name))
          .fail(() => alert('이름 변경 실패'));
      }
    };
    items.remove = {
      label: "삭제",
      action: function(){
        if(!confirm("삭제할까요?")) return;
        $.post('<c:url value="/org/delete"/>', { id: node.id })
          .done(() => $tree.jstree(true).delete_node(node))
          .fail(() => alert('삭제 실패'));
      }
    };
    return items;
  }

  // jstree 초기화
  $tree.jstree({
    core: {
      data: function (node, cb) {
        $.ajax({
          url: '<c:url value="/org/children"/>',
          data: { parent: node.id || '#' },
          dataType: 'json',
          cache: false
        }).done(function(res){
          if (!Array.isArray(res)) { console.error('children not array', res); cb([]); return; }
          const fixed = res.map(r => {
            const id    = r.id    ?? r.ID;
            const text  = r.text  ?? r.TEXT;
            const type0 = r.type  ?? r.TYPE;
            const type  = (type0 ? String(type0).toLowerCase()
                                 : (String(id).startsWith('e-') ? 'employee' : 'department'));
            return {
              id, text, type,
              // 부서는 항상 펼칠 수 있게 children=true, 직원은 false
              children: (type === 'department')
            };
          });
          cb(fixed);
        }).fail(function(xhr){
          console.error('[children] error', xhr.status, xhr.responseText);
          cb([]);
        });
      },
      check_callback: function (op, node, parent) {
        // 이동 제약(원하면 활성화)
        if(op === 'move_node'){
          // 직원은 부서 밑으로만
          if (node.original?.type === 'employee' && parent && parent.type !== 'department') return false;
          // 부서는 루트(#) 또는 부서 밑으로만
          if (node.original?.type === 'department' && parent && !(parent.id === '#' || parent.type === 'department')) return false;
        }
        return true;
      },
      dblclick_toggle: false
    },
    types: {
      department: { icon: "fas fa-building" },
      employee:   { icon: "fas fa-user" }
    },
    plugins: ["types","wholerow","search","dnd","contextmenu"],
    contextmenu: { items: customMenu }
  });

  // 부서 클릭 시 자동으로 열기
  $tree.off('select_node.jstree').on('select_node.jstree', function (e, data) {
    const n = data.node;
    if (n.original?.type === 'department') {
      $tree.jstree(true).open_node(n);
    } else if (n.original?.type === 'employee') {
      const eno = (n.id || '').replace('e-','');
      // TODO: 직원 상세 조회
    }
  });

  // 드래그앤드롭 반영 (같은 타입끼리의 위치로 전송 + oldParent 포함)
  $tree.off('move_node.jstree').on('move_node.jstree', function(e, data){
    const tree = $tree.jstree(true);
    const node = data.node;
    const myType = node.original && node.original.type;
    const parentNode = tree.get_node(data.parent);
    const childIds = parentNode.children; // 최종 자식 배열

    // 같은 타입끼리의 새 위치(0부터) 계산
    let posType = 0;
    for (let i = 0; i < data.position; i++) {
      const sib = tree.get_node(childIds[i]);
      const sType = sib.original && sib.original.type;
      if (sType === myType) posType++;
    }

    $.post('<c:url value="/org/move"/>', {
      id: node.id,
      parent: data.parent,       // '#', 'd-xxx'
      position: posType,         // 같은 타입 내 인덱스
      oldParent: data.old_parent // 이전 부모
    }).fail(function(){
      alert('이동 반영 실패. 새로고침하여 상태를 확인하세요.');
      $tree.jstree(true).refresh_node(data.old_parent);
    });
  });
});
</script>
