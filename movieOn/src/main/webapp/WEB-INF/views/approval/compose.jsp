<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>업무기안 – 새 결재 작성</title>

<!-- jsTree (조직도 트리) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jstree/dist/themes/default/style.min.css" />
<script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jstree/dist/jstree.min.js"></script>

<style>
* { box-sizing: border-box; }
body {
  margin: 0;
  font-family: "Pretendard", "맑은 고딕", system-ui, -apple-system, Segoe UI, Roboto, Apple SD Gothic Neo, sans-serif;
  background: #ffffff; /* fix: #fffff -> #ffffff */
  color: #52586B;
}
a { color: inherit; text-decoration: none; }
.wrap { padding: 0 20px; }

/* ===== Top bar ===== */
.topbar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 14px 18px; border-bottom: 1px solid #E7EAF2;
}
.topbar .title { font-size: 18px; font-weight: 800; letter-spacing: .2px; color: #222; }
.topbar .actions { display: flex; gap: 8px; }
.btn {
  height: 34px; padding: 0 14px; border-radius: 6px; border: 1px solid transparent;
  font-weight: 700; cursor: pointer;
}
.btn-primary { background: #487FC3; color: #fff; }
.btn-ghost { background: #fff; color: #3b4052; border-color: #DDE2EE; }
.btn-danger { background: #D75340; color: #fff; }

/* ===== Page grid ===== */
.page { padding: 18px 22px 32px; }
.grid {
  display: grid; grid-template-columns: 1fr 320px; gap: 18px; max-width: 1200px; margin: 0 auto;
}

/* ===== Panels ===== */
.panel {
  background: #fff; border: 1px solid #E1E5EF; border-radius: 8px; overflow: hidden;
  box-shadow: 0 6px 18px rgba(25, 32, 56, .05);
}
.panel .hd { padding: 12px 14px; border-bottom: 1px solid #E9ECF3; font-weight: 800; }
.panel .bd { padding: 16px; }

/* ===== Form (left) ===== */
.form-wrap { display: flex; flex-direction: column; gap: 16px; }

/* Big paper look */
.paper-box { border: 1px solid #E1E5EF; border-radius: 8px; padding: 18px; background: #fff; }
.paper-title { margin: 0 0 12px; text-align: center; font-size: 26px; font-weight: 900; letter-spacing: .35em; color: #1e2439; }

.table { width: 100%; border-collapse: collapse; table-layout: fixed; }
.table th, .table td { border: 1px solid #E1E5EF; padding: 8px 10px; font-size: 14px; vertical-align: middle; }
.table th {
  background: #FAFBFE; color: #4B5164; width: 110px; text-align: center; font-weight: 700;
}
.table input[type="text"], .table input[type="date"] {
  width: 100%; border: 0; outline: none; font: inherit; color: #333;
}

/* Rich editor placeholder box */
.editor { min-height: 260px; border: 1px solid #E1E5EF; border-radius: 8px; padding: 10px; margin-top: 12px; }

/* Attach */
.row { display: grid; grid-template-columns: 90px 1fr; gap: 10px; align-items: start; }
.label { font-weight: 700; color: #4B5164; padding-top: 6px; }
.attach {
  border: 1px dashed #CBD3E3; border-radius: 8px; padding: 16px; text-align: center; color: #6F7892;
}
.attach input[type="file"] { display: block; margin: 10px auto 0; }
.select, select {
  width: 100%; height: 38px; border: 1px solid #E1E5EF; border-radius: 8px; padding: 0 10px; background: #fff;
}

/* ===== Right: Info / Tabs ===== */
.tabs { display: flex; border-bottom: 1px solid #E9ECF3; }
.tabs a { padding: 12px 14px; font-weight: 800; color: #52586B; border-bottom: 2px solid transparent; }
.tabs a.on { color: #222; border-bottom-color: #487FC3; }
.info-card { border: 1px solid #E1E5EF; border-radius: 8px; padding: 12px; background: #fff; }
.info-grid { display: grid; grid-template-columns: 84px 1fr; gap: 8px 10px; align-items: center; color: #222; }
.badge { display: inline-block; padding: 4px 10px; border-radius: 999px; background: #EEF2FF; font-size: 12px; }
.muted { color: #8b90a0; font-size: 13px; }
.side-section { display: flex; flex-direction: column; gap: 16px; }

/* 클릭 가능한 박스 */
.clickable { cursor: pointer; }
.pills { display: flex; flex-wrap: wrap; gap: 6px; }
.pill {
  display: inline-flex; align-items: center; gap: 6px;
  padding: 4px 10px; border: 1px solid #E1E5EF; border-radius: 999px; background: #FAFBFE; font-size: 12px;
}

/* Modal */
.modal {
  position: fixed; inset: 0; background: rgba(0,0,0,.4);
  display: none; align-items: center; justify-content: center; z-index: 999;
}
.modal.on { display: flex; }
.modal-content {
  background: #fff; padding: 16px; border-radius: 8px; width: min(720px, 92vw); max-height: 84vh; overflow: auto;
}
.modal-hd { font-weight: 800; margin-bottom: 10px; }
.modal-actions { margin-top: 12px; display: flex; gap: 8px; justify-content: flex-end; }
.org-tree { border: 1px solid #E1E5EF; border-radius: 6px; padding: 8px; }
</style>

<script>
  /* ===== 전역 ===== */
  const ctx = '<%= request.getContextPath() %>';   // ★ 꼭 있어야 /org/tree 호출됨
  let currentTarget = null;                        // 'line' | 'cc'
  let selectedApproverIds = [], selectedApproverTexts = [];
  let selectedRefIds = [],      selectedRefTexts = [];

  /* ===== 조직도 열기: /org/tree 한 번에 로드 ===== */
  function openOrgModal(target) {
    currentTarget = target; // 'line' | 'cc'
    document.getElementById('orgModal').classList.add('on');

    const $tree = $('#orgTree');
    if ($tree.data('jstree')) $tree.jstree('destroy');

    $.ajax({
      url: ctx + '/org/tree',
      dataType: 'json',
      cache: false
    })
    .done(function(resp){
      const data = Array.isArray(resp) ? resp : (resp?.list || resp?.data || []);
      $tree.jstree({
        core: { data },
        plugins: ['checkbox','types'],
        types: { department:{icon:'jstree-folder'}, employee:{icon:'jstree-file'} },
        checkbox: { keep_selected_style: false }
      })
      // 부서(d-xxx)는 체크 막기
      .off('check_node.jstree')
      .on('check_node.jstree', function (e, data) {
        if (String(data.node.id).startsWith('d-')) {
          $(this).jstree(true).uncheck_node(data.node);
          alert('직원만 선택할 수 있습니다.');
        }
      })
      .on('ready.jstree', function(){
        $(this).jstree('open_all'); // 데이터 많으면 주석 처리
      });
    })
    .fail(function(xhr){
      console.error('[orgTree] /org/tree fail:', xhr.status, xhr.responseText);
      const msg = xhr.responseText ? xhr.responseText.substring(0,300) : '';
      alert('조직도 로딩 실패(' + xhr.status + ')\n/org/tree' + (msg ? '\n\n' + msg : ''));
    });
  }

  /* ===== 확인/닫기 ===== */
  function closeOrgModal() {
    const $tree = $('#orgTree');
    if ($tree.data('jstree')) $tree.jstree('destroy');
    document.getElementById('orgModal').classList.remove('on');
  }

  function confirmOrgSelection() {
    const inst = $('#orgTree').jstree(true);
    if (!inst) return;

    const nodes = inst.get_selected(true).filter(n => String(n.id).startsWith('e-'));

    const ids   = nodes.map(n => Number(String(n.id).replace('e-',''))).filter(Number.isFinite);
    const texts = nodes.map(n => n.text); // 서버에서 내려준 "이름 [직급/부서]" 문자열

    if (ids.length === 0) { alert('선택된 직원이 없습니다.'); return; }

    if (currentTarget === 'line') {
      selectedApproverIds = ids; selectedApproverTexts = texts;
      document.getElementById('approverIds').value = ids.join(',');
      renderPills(document.getElementById('lineBox'), texts);
    } else {
      selectedRefIds = ids; selectedRefTexts = texts;
      document.getElementById('refIds').value = ids.join(',');
      renderPills(document.getElementById('refBox'), texts);
    }
    closeOrgModal();
  }

  function renderPills(container, texts) {
    container.innerHTML = '';
    const wrap = document.createElement('div'); wrap.className = 'pills';
    texts.forEach(t => {
      const el = document.createElement('span'); el.className = 'pill'; el.textContent = t;
      wrap.appendChild(el);
    });
    container.appendChild(wrap);
  }

  // 전역 노출(버튼에서 호출)
  window.openOrgModal = openOrgModal;
  window.closeOrgModal = closeOrgModal;
  window.confirmOrgSelection = confirmOrgSelection;
</script>

<script>
  // ── 교체본 시작 ──────────────────────────────────────────────────────────
  // 유틸
  function uniq(arr){ return Array.from(new Set(arr)); }

  // 본문 동기화
  function syncEditor() {
    const editor = document.querySelector('.editor');
    document.getElementById('signcontent').value = editor ? editor.innerHTML : '';
  }

  // 임시저장
  async function saveTemp() {
    try {
      syncEditor();
      const payload = {
        title:       document.getElementById('title').value || '',
        signcontent: document.getElementById('signcontent').value || '',
        sformno:     document.getElementById('sformno').value || null,
        emergency:   document.getElementById('emergency').checked ? 1 : 0
      };

      const btn = document.querySelector('.btn.btn-ghost'); // 임시저장 버튼
      btn && btn.setAttribute('disabled', 'disabled');

      const res  = await fetch(ctx + '/approval/temp-save', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      const data = await res.json().catch(() => null);

      alert(data && data.ok ? '임시저장 되었습니다.' : (data?.message || '임시저장 실패'));
    } catch (e) {
      console.error(e);
      alert('임시저장 중 오류가 발생했습니다.');
    } finally {
      const btn = document.querySelector('.btn.btn-ghost');
      btn && btn.removeAttribute('disabled');
    }
  }

  // 결재요청
  async function requestSign() {
    try {
      // 1) 유효성
      const titleEl = document.getElementById('title');
      if (!titleEl || !titleEl.value.trim()) {
        alert('제목을 입력해 주세요.');
        titleEl && titleEl.focus();
        return;
      }
      if (!selectedApproverIds.length) {
        alert('결재선을 선택해 주세요.');
        return;
      }

      // 2) 본문 동기화
      syncEditor();

      // 3) 결재선/참조 중복 제거 (참조에서 결재자 제외)
      const approvers = uniq(selectedApproverIds);
      const refs = uniq(selectedRefIds).filter(id => !approvers.includes(id));

      // 4) 페이로드 (ApprovalVO 매핑 가정)
      const payload = {
        title:       titleEl.value.trim(),
        signcontent: document.getElementById('signcontent').value || '',
        content:     document.getElementById('signcontent').value || '', // 서버에서 content 사용 시 대비
        sformno:     document.getElementById('sformno').value || null,
        emergency:   document.getElementById('emergency').checked ? 1 : 0,
        approvers:   approvers,  // [ENO, ENO, ...] → 서버에서 SIGNRANK 1..N 부여
        refs:        refs        // [ENO, ...]
      };

      // 5) 중복 제출 방지
      const btn = document.querySelector('.btn.btn-primary');
      btn && btn.setAttribute('disabled', 'disabled');

      // 6) 전송
      const res = await fetch(ctx + '/approval/save', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });

      if (!res.ok) {
        const text = await res.text();
        throw new Error('서버 오류: ' + res.status + '\n' + text.slice(0,300));
      }
      const data = await res.json().catch(() => null);
      if (!data || !data.ok) {
        throw new Error(data?.message || '등록 실패');
      }

      // 7) 이동
      const signNo = data.signNo;
      if (signNo) {
        location.href = ctx + '/approval/detail?signNo=' + encodeURIComponent(signNo);
      } else {
        alert('저장되었습니다.');
      }
    } catch (err) {
      console.error(err);
      alert(err.message || '결재요청 중 오류가 발생했습니다.');
    } finally {
      const btn = document.querySelector('.btn.btn-primary');
      btn && btn.removeAttribute('disabled');
    }
  }

  // 취소
  function goBack() {
    if (confirm('작성을 취소할까요? 미저장 내용은 사라집니다.')) history.back();
  }

  // 전역 노출
  window.saveTemp = saveTemp;
  window.requestSign = requestSign;
  window.goBack = goBack;
  // ── 교체본 끝 ───────────────────────────────────────────────────────────
</script>

</head>
<body>
  <!-- ===== Top bar ===== -->
  <header class="topbar">
    <div class="title">업무기안</div>
    <div class="actions">
      <button class="btn btn-primary" type="button" onclick="requestSign()">결재요청</button>
      <button class="btn btn-ghost" type="button" onclick="saveTemp()">임시저장</button>
      <button class="btn btn-danger" type="button" onclick="goBack()">취소</button>
    </div>
  </header>

  <!-- ===== Hidden fields ===== -->
  <input type="hidden" id="sformno" value="${form.sformNo}" />
  <input type="hidden" id="signcontent" />
  <input type="checkbox" id="emergency" style="display: none" />
  <!-- 로그인 사번/부서번호 (세션에 저장되어 있다고 가정) -->
  <input type="hidden" id="loginEno" value="${sessionScope.loginEno}" />
  <input type="hidden" id="loginDno" value="${sessionScope.loginDno}" />
  <!-- 선택 결과 보관(백엔드 필요 시 활용) -->
  <input type="hidden" id="approverIds" />
  <input type="hidden" id="refIds" />

  <main class="page">
    <div class="grid">
      <!-- ===== Left: Form ===== -->
      <section class="panel">
        <div class="hd">결재 작성</div>
        <div class="bd">
          <div class="form-wrap">
            <div class="paper-box">
              <h2 class="paper-title">
                <c:out value="${form.CLASSNAME != null ? form.CLASSNAME : '업무기안'}" />
              </h2>

              <c:choose>
                <c:when test="${not empty renderedFormHtml}">
                  <c:out value="${renderedFormHtml}" escapeXml="false" />
                </c:when>
                <c:otherwise>
                  <table class="table">
                    <colgroup>
                      <col style="width: 110px" /><col /><col style="width: 110px" /><col />
                    </colgroup>
                    <tr>
                      <th>기안자</th>
                      <td><input type="text" id="drafter" value="${loginEmp.name}" readonly></td>
                      <th>부서</th>
                      <td><input type="text" id="dept" value="${loginEmp.deptName}" readonly></td>
                    </tr>
                    <tr>
                      <th>기안일</th>
                      <td><input type="date" id="draftDate" value="${today}"></td>
                      <th>문서번호</th>
                      <td><c:out value="${signNo != null ? signNo : ''}" /></td>
                    </tr>
                    <tr>
                      <th>제목</th>
                      <td colspan="3"><input type="text" id="title" placeholder="제목을 입력하세요" /></td>
                    </tr>
                  </table>

                  <div
  class="editor"
  contenteditable="true"
  role="textbox"
  aria-multiline="true"
  aria-label="본문 작성 영역"
  data-placeholder="내용을 입력하세요">
</div>

                </c:otherwise>
              </c:choose>
            </div>

            <div class="row">
              <div class="label">파일첨부</div>
              <div class="attach">
                파일을 드래그하거나 클릭하여 첨부하세요. <input type="file" multiple>
              </div>
            </div>
            <div class="row">
              <div class="label">열람설정</div>
              <div>
                <select class="select" name="viewScope">
                  <option value="line">결재선만</option>
                  <option value="org">부서 공개</option>
                  <option value="all">전사 공개</option>
                </select>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- ===== Right: Document Info / Line / CC ===== -->
      <aside class="panel">
        <div class="tabs">
          <a class="on" href="javascript:void(0)">문서정보</a>
        </div>
        <div class="bd side-section">
          <!-- 문서정보 카드 -->
          <div class="info-card">
            <div class="info-grid">
              <div class="label">문서번호</div>
              <div><span class="badge"><c:out value="${signNo != null ? signNo : '자동부여'}" /></span></div>
              <div class="label">기안부서</div>
              <div><c:out value="${loginEmp.deptName != null ? loginEmp.deptName : '경영지원본부'}" /></div>
            </div>
          </div>

          <!-- 결재선 -->
          <div>
            <div class="label" style="margin: 2px 0 6px">결재선</div>
            <div class="info-card muted clickable" onclick="openOrgModal('line')">
              <div id="lineBox">결재선을 선택해 주세요.</div>
            </div>
          </div>

          <!-- 참조자 -->
          <div>
            <div class="label" style="margin: 2px 0 6px">참조자</div>
            <div class="info-card muted clickable" onclick="openOrgModal('cc')">
              <div id="refBox">참조자를 추가해 주세요.</div>
            </div>
          </div>
        </div>
      </aside>
    </div>
  </main>

  <!-- 조직도 모델-->
  <div id="orgModal" class="modal" role="dialog" aria-modal="true" aria-labelledby="orgModalTitle">
    <div class="modal-content">
      <div class="modal-hd" id="orgModalTitle">조직도 선택</div>
      <div id="orgTree" class="org-tree" aria-label="조직도"></div>
      <div class="modal-actions">
        <button class="btn btn-ghost" type="button" onclick="closeOrgModal()">취소</button>
        <button class="btn btn-primary" type="button" onclick="confirmOrgSelection()">확인</button>
      </div>
    </div>
  </div>
</body>
</html>
