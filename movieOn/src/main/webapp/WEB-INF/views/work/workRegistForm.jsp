<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>업무 등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- AdminLTE / Bootstrap / Icons -->
<link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">

<!-- Summernote -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css">

<!-- jsTree -->
<link  href="https://cdn.jsdelivr.net/npm/jstree@3.3.16/dist/themes/default/style.min.css" rel="stylesheet">

<style>
  :root{ --primary:#3A8DFE; --line:rgba(0,0,0,.08); --text:#2B2F3A; }
  body{ background:#fff; color:var(--text); font-size: 14px; }
  .page-wrap{ padding:18px; }
  .topbar{ display:flex; align-items:center; justify-content:space-between; margin-bottom:8px; }
  .btn-primary{ background:var(--primary); border-color:var(--primary); }
  .split{ display:grid; grid-template-columns: 1fr 320px; gap:18px; }
  .left-pane,.right-pane{ border:1px solid var(--line); border-radius:10px; background:#fff; }
  .left-pane{ padding:16px; }
  .right-pane{ display:flex; flex-direction:column; }
  .right-head{ padding:12px 14px; border-bottom:1px solid var(--line); font-weight:700; }
  .right-body{ padding:10px 12px; overflow:auto; height:560px; }
   

  /* 폼 테이블 */
  .form-table{ width:100%; border-collapse:separate; border-spacing:0 8px; }
  .form-table th{
    width:110px; background:#F6F7FB; border:1px solid var(--line);
    padding:12px 14px; border-right:none; border-radius:8px 0 0 8px; font-weight:700; color:#4b5563;
  }
  .form-table td{ border:1px solid var(--line); border-left:none; border-radius:0 8px 8px 0; padding:10px 12px; }
  .input-clean{ width:100%; border:none; outline:none; background:transparent; color:#111827; }
  .input-clean::placeholder{ color:#9AA1AE; }
  .note-editor{ border:1px solid var(--line); border-radius:10px; }
  .file-drop{ border:1px dashed #c8cfdb; border-radius:10px; padding:10px 12px; color:#6b7280; display:flex; align-items:center; gap:8px; }
  .file-drop input[type=file]{ display:none; }
  #orgTree { padding:12px; }
  #orgTree .jstree-anchor { user-select: none; }

  /* date input 높이 */
  input[type="date"].form-control{ min-height:38px; }

  /* 담당자 입력의 X 버튼 */
  .position-relative{ position:relative; }
  .clear-btn{
    position:absolute; right:8px; top:50%; transform:translateY(-50%);
    border:none; background:transparent; font-size:18px; line-height:1; color:#9aa1ae;
    padding:0 4px; cursor:pointer;
  }
  .clear-btn:hover{ color:#6b7280; }
  
  /* 조직도 */
  #orgTree, .jstree-anchor {
    font-size: 13px !important;
}


/* 업무 등록 제목 크기 조정 */
h2, h3, h4, .page-title, .content-header h1 {
    font-size: 18px !important; /* 기본보다 작게 */
    font-weight: bold; /* 굵기는 유지 */
}


/* form-table의 th 스타일 지정 */
.form-table th {
  background-color: #f3f3f3; /* 배경색 */
  color: #52586B;            /* 글씨색 */
  border: 1px solid #ddd;    /* 테두리색 (원하면 변경 가능) */
  padding: 8px 12px;         /* 안쪽 여백 */
  text-align: left;          /* 글씨 왼쪽 정렬 */
  font-weight: 600;          /* 글씨 두께 */
  width: 100px;              /* 고정 폭 (원하는 경우) */
}

/* td에도 같은 테두리 적용해서 표 경계 깔끔하게 */
.form-table td {
  border: 1px solid #ddd;
  padding: 8px 12px;
}


</style>
</head>

<body>
<div class="page-wrap">

  <!-- 상단 타이틀/버튼 -->
  <div class="topbar">
    <h3 class="m-0 font-weight-bold">업무 등록</h3>
    <div>
      <!-- 아이콘 제거: 텍스트만 -->
      <button type="button" class="btn btn-primary btn-sm" id="btnSubmit">등록</button>
      <button type="button" class="btn btn-default btn-sm" id="btnCancel">취소</button>
    </div>
  </div>

  <div class="split">
    <!-- 좌측: 폼 -->
    <div class="left-pane">
      <form id="workForm" action="<%=ctx%>/work/regist" method="post" enctype="multipart/form-data">
        <table class="form-table">
          <tr>
            <th>요청자</th>
            <td>
              <input type="text" class="input-clean" id="requesterName" value="${loginUser.ename}" readonly>
              <input type="hidden" name="eno" value="${loginUser.eno}">
            </td>
          </tr>
          <tr>
            <th>제목</th>
            <td>
              <input type="text" class="input-clean" name="wtitle" id="wtitle" placeholder="제목을 입력해주세요." maxlength="150">
            </td>
          </tr>
          <tr>
            <th>담당자</th>
            <td>
              <div class="position-relative">
                <input type="text" class="input-clean pr-4" name="managerName" id="managerName" placeholder="우측 조직도에서 선택" readonly>
                <input type="hidden" name="managerEno" id="managerEno">
                <!-- X 지우기 버튼 -->
                <button type="button" id="btnClearManager" class="clear-btn d-none" aria-label="담당자 지우기">&times;</button>
              </div>
            </td>
          </tr>
          <tr>
            <th>기한</th>
            <td>
              <div class="input-group">
                <!-- 네이티브 date: 브라우저 아이콘 1개만 표시 -->
                <input type="date" class="form-control" name="dueDate" id="dueDate" placeholder="연도-월-일" style="font-size:14px;">
                
              </div>
            </td>
          </tr>
        </table>

        <!-- 본문 에디터 -->
        <div class="mt-2">
          <textarea id="editor" name="wcontent"></textarea>
        </div>

        <!-- 첨부파일 -->
        <div class="mt-2 file-drop" id="fileBox">
          <i class="fas fa-paperclip"></i><span>첨부파일</span>
          <label class="mb-0 ml-auto">
            <input type="file" name="files" id="files" multiple>
            <span class="btn btn-sm btn-outline-secondary">Add File</span>
          </label>
        </div>
        <ul class="mt-2 small text-muted" id="fileList"></ul>
      </form>
    </div>

    <!-- 우측: 조직도 -->
    <div class="right-pane">
      <div class="right-head">조직도</div>
      <div class="right-body">
        <div class="mb-2">
          <input type="text" class="form-control form-control-sm" id="orgSearch" placeholder="검색(이름/부서)" style="font-size:12px;">
        </div>
        <div id="orgTree"></div>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="<%=ctx%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%=ctx%>/resources/bootstrap/dist/js/adminlte.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/lang/summernote-ko-KR.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/jstree@3.3.16/dist/jstree.min.js"></script>

<script>
/* ===== 폼 위젯 ===== */
$('#editor').summernote({
  placeholder: '내용을 입력해주세요.',
  height: 260,
  lang: 'ko-KR',
  toolbar: [
    ['style', ['bold','italic','underline','clear']],
    ['para',  ['ul','ol','paragraph']],
    ['insert',['table','link']],
    ['view',  ['fullscreen','codeview']]
  ]
});

// 파일 목록 표시
$('#files').on('change', function(){
  const list = $('#fileList').empty();
  for(const f of this.files){
    $('<li/>').text(f.name + ' (' + Math.ceil(f.size/1024) + ' KB)').appendTo(list);
  }
});

// 담당자 X 버튼 show/hide
function toggleManagerClear(){
  const has = !!$('#managerEno').val();
  $('#btnClearManager').toggleClass('d-none', !has);
}
$('#btnClearManager').on('click', function(){
  $('#managerName').val('');
  $('#managerEno').val('');
  toggleManagerClear();
});

/* ===== 등록/취소 ===== */
$('#btnSubmit').on('click', function(){
  const title = $('#wtitle').val().trim();
  const eno   = $('#managerEno').val().trim();
  const due   = $('#dueDate').val().trim();
  const html  = $('#editor').summernote('isEmpty') ? '' : $('#editor').summernote('code');

  if(!title){ alert('제목을 입력해주세요.'); $('#wtitle').focus(); return; }
  if(!eno){ alert('담당자를 선택해주세요.'); return; }
  if(!due){ alert('기한을 선택해주세요.'); $('#dueDate').focus(); return; }
  if(!html || $(html).text().trim()===''){ alert('내용을 입력해주세요.'); $('#editor').summernote('focus'); return; }

  $('#workForm').submit();
});

$('#btnCancel').on('click', function(){
  if(window.opener){ window.close(); } else { history.back(); }
});


/* ====== jsTree (네가 만든 코드 기반) ====== */
$(function () {
  const $tree = $('#orgTree');
  try { $tree.jstree('destroy'); } catch(e) {}

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
            return { id, text, type, children: (type === 'department') };
          });
          cb(fixed);
        }).fail(function(xhr){
          console.error('[children] error', xhr.status, xhr.responseText);
          cb([]);
        });
      },
      check_callback: function (op, node, parent) {
        if(op === 'move_node'){
          if (node.original?.type === 'employee' && parent && parent.type !== 'department') return false;
          if (node.original?.type === 'department' && parent && !(parent.id === '#' || parent.type === 'department')) return false;
        }
        return true;
      },
      dblclick_toggle: false
    },
    types: { department: { icon: "fas fa-building" }, employee: { icon: "fas fa-user" } },
    plugins: ["types","wholerow","search","dnd","contextmenu"],
    contextmenu: { items: customMenu }
  });

  // 검색
  let to=false;
  $('#orgSearch').on('keyup', function(){
    if(to) clearTimeout(to);
    to=setTimeout(function(){ $('#orgTree').jstree(true).search($('#orgSearch').val()); }, 200);
  });

  // 선택: 직원이면 담당자 입력칸 채움 + X 버튼 보이기
  $tree.off('select_node.jstree').on('select_node.jstree', function (e, data) {
    const n = data.node;
    if (n.original?.type === 'department') {
      $tree.jstree(true).open_node(n);
    } else if (n.original?.type === 'employee') {
      const eno = (n.id || '').replace(/^e-/, '');
      $('#managerName').val(n.text);
      $('#managerEno').val(eno);
      toggleManagerClear();
    }
  });

  // 이동 반영
  $tree.off('move_node.jstree').on('move_node.jstree', function(e, data){
    const tree = $tree.jstree(true);
    const node = data.node;
    const myType = node.original && node.original.type;
    const parentNode = tree.get_node(data.parent);
    const childIds = parentNode.children;

    let posType = 0;
    for (let i = 0; i < data.position; i++) {
      const sib = tree.get_node(childIds[i]);
      const sType = sib.original && sib.original.type;
      if (sType === myType) posType++;
    }

    $.post('<c:url value="/org/move"/>', {
      id: node.id,
      parent: data.parent,
      position: posType,
      oldParent: data.old_parent
    }).fail(function(){
      alert('이동 반영 실패. 새로고침하여 상태를 확인하세요.');
      $tree.jstree(true).refresh_node(data.old_parent);
    });
  });

  // 초기 X 버튼 상태
  toggleManagerClear();
});
</script>
</body>
</html>
