<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>업무기안 – 새 결재 작성</title>
<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: "Pretendard", "맑은 고딕", system-ui, -apple-system, Segoe UI,
		Roboto, Apple SD Gothic Neo, sans-serif;
	background: #fffff;
	color: #52586B;
}

a {
	color: inherit;
	text-decoration: none;
}

.wrap {
	padding: 0 20px;
}

/* ===== Top bar ===== */
.topbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 14px 18px;
	border-bottom: 1px solid #E7EAF2;
}

.topbar .title {
	font-size: 18px;
	font-weight: 800;
	letter-spacing: .2px;
	color: #222;
}

.topbar .actions {
	display: flex;
	gap: 8px;
}

.btn {
	height: 34px;
	padding: 0 14px;
	border-radius: 6px;
	border: 1px solid transparent;
	font-weight: 700;
	cursor: pointer;
}

.btn-primary {
	background: #487FC3;
	color: #fff;
}

.btn-ghost {
	background: #fff;
	color: #3b4052;
	border-color: #DDE2EE;
}

.btn-danger {
	background: #D75340;
	color: #fff;
}

/* ===== Page grid ===== */
.page {
	padding: 18px 22px 32px;
}

.grid {
	display: grid;
	grid-template-columns: 1fr 320px; /* left content, right info */
	gap: 18px;
	max-width: 1200px;
	margin: 0 auto;
}

/* ===== Panels ===== */
.panel {
	background: #fff;
	border: 1px solid #E1E5EF;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 6px 18px rgba(25, 32, 56, .05);
}

.panel .hd {
	padding: 12px 14px;
	border-bottom: 1px solid #E9ECF3;
	font-weight: 800;
}

.panel .bd {
	padding: 16px;
}

/* ===== Form (left) ===== */
.form-wrap {
	display: flex;
	flex-direction: column;
	gap: 16px;
}

/* Big paper look */
.paper-box {
	border: 1px solid #E1E5EF;
	border-radius: 8px;
	padding: 18px;
	background: #fff;
}

.paper-title {
	margin: 0 0 12px;
	text-align: center;
	font-size: 26px;
	font-weight: 900;
	letter-spacing: .35em;
	color: #1e2439;
}

.table {
	width: 100%;
	border-collapse: collapse;
	table-layout: fixed;
}

.table th, .table td {
	border: 1px solid #E1E5EF;
	padding: 8px 10px;
	font-size: 14px;
	vertical-align: middle;
}

.table th {
	background: #FAFBFE;
	color: #4B5164;
	width: 110px;
	text-align: center;
	font-weight: 700;
}

.table input[type="text"], .table input[type="date"] {
	width: 100%;
	border: 0;
	outline: none;
	font: inherit;
	color: #333;
}

/* Rich editor placeholder box */
.editor {
	min-height: 260px;
	border: 1px solid #E1E5EF;
	border-radius: 8px;
	padding: 10px;
	margin-top: 12px;
}

/* Attach */
.row {
	display: grid;
	grid-template-columns: 90px 1fr;
	gap: 10px;
	align-items: start;
}

.label {
	font-weight: 700;
	color: #4B5164;
	padding-top: 6px;
}

.attach {
	border: 1px dashed #CBD3E3;
	border-radius: 8px;
	padding: 16px;
	text-align: center;
	color: #6F7892;
}

.attach input[type="file"] {
	display: block;
	margin: 10px auto 0;
}

.select, select {
	width: 100%;
	height: 38px;
	border: 1px solid #E1E5EF;
	border-radius: 8px;
	padding: 0 10px;
	background: #fff;
}

/* ===== Right: Info / Tabs ===== */
.tabs {
	display: flex;
	border-bottom: 1px solid #E9ECF3;
}

.tabs a {
	padding: 12px 14px;
	font-weight: 800;
	color: #52586B;
	border-bottom: 2px solid transparent;
}

.tabs a.on {
	color: #222;
	border-bottom-color: #487FC3;
}

.info-card {
	border: 1px solid #E1E5EF;
	border-radius: 8px;
	padding: 12px;
	background: #fff;
}

.info-grid {
	display: grid;
	grid-template-columns: 84px 1fr;
	gap: 8px 10px;
	align-items: center;
	color: #222;
}

.badge {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 999px;
	background: #EEF2FF;
	font-size: 12px;
}

.muted {
	color: #8b90a0;
	font-size: 13px;
}

/* Narrower right column spacing to match screenshot */
.side-section {
	display: flex;
	flex-direction: column;
	gap: 16px;
}
</style>

<script>
  // 줄바꿈 제거
  const ctx = '<%= request.getContextPath() %>';

  function syncEditor() {
    const editor = document.querySelector('.editor');
    document.getElementById('signcontent').value = editor ? editor.innerHTML : '';
  }

  // 줄바꿈 없이 한 줄로
  async function saveTemp() {
    try {
      syncEditor();
      const payload = {
        title: document.getElementById('title').value || '',
        signcontent: document.getElementById('signcontent').value || '',
        sformno: document.getElementById('sformno').value || null,
        emergency: document.getElementById('emergency').checked ? 1 : 0
      };
      const res = await fetch(ctx + '/approval/temp-save', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      const data = await res.json();
      alert(data && data.ok ? '임시저장 되었습니다.' : (data.message || '임시저장 실패'))
    } catch (err) {
      console.error(err);
      alert('임시저장 중 오류가 발생했습니다.');
    }
    
  }

  function requestSign() {
    alert('결재요청 처리(서버 연동 필요)');
  }

  function goBack() {
    if (confirm('작성을 취소할까요? 미저장 내용은 사라집니다.')) history.back();
  }

  // 전역 노출(특히 <script type="module">일 때 필수)
  window.saveTemp = saveTemp;
  window.requestSign = requestSign;
  window.goBack = goBack;
</script>

</head>
<body>
	<!-- ===== Top bar (좌측 제목, 우측 버튼들) ===== -->
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

	<main class="page">
		<div class="grid">
			<!-- ===== Left: Form ===== -->
			<section class="panel">
				<div class="hd">결재 작성</div>
				<div class="bd">
					<div class="form-wrap">
						<div class="paper-box">
							<h2 class="paper-title">
								<c:out
									value="${form.CLASSNAME != null ? form.CLASSNAME : '업무기안'}" />
							</h2>

							<c:choose>
								<c:when test="${not empty renderedFormHtml}">
									<c:out value="${renderedFormHtml}" escapeXml="false" />
								</c:when>
								<c:otherwise>

									<table class="table">
										<colgroup>
											<col style="width: 110px" />
											<col />
											<col style="width: 110px" />
											<col />
										</colgroup>
										<tr>
											<th>기안자</th>
											<td><input type="text" id="drafter"
												value="${loginEmp.name}" readonly></td>
											<th>부서</th>
											<td><input type="text" id="dept"
												value="${loginEmp.deptName}" readonly></td>
										</tr>
										<tr>
											<th>기안일</th>
											<td><input type="date" id="draftDate" value="${today}"></td>
											<th>문서번호</th>
											<td><c:out value="${signNo != null ? signNo : ''}" /></td>
										</tr>
										<tr>
											<th>제목</th>
											<td colspan="3"><input type="text" id="title"
												placeholder="제목을 입력하세요" /></td>
										</tr>
									</table>

									<div class="editor" contenteditable="true"
										aria-label="본문 작성 영역">내용을 입력하세요.</div>
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
					<a class="on" href="javascript:void(0)">문서정보</a> <a
						href="javascript:void(0)">결재선</a> <a href="javascript:void(0)">참조자</a>
				</div>
				<div class="bd side-section">
					<!-- 문서정보 카드 -->
					<div class="info-card">
						<div class="info-grid">
							<div class="label">문서번호</div>
							<div>
								<span class="badge"><c:out
										value="${signNo != null ? signNo : '자동부여'}" /></span>
							</div>
							<div class="label">기안부서</div>
							<div>
								<c:out
									value="${loginEmp.deptName != null ? loginEmp.deptName : '경영지원본부'}" />
							</div>
						</div>
					</div>

					<!-- 결재선/참조자 프리뷰 박스 (스크린샷의 회색 박스) -->
					<div>
						<div class="label" style="margin: 2px 0 6px">결재선</div>
						<div class="info-card muted">결재선을 선택해 주세요.</div>
					</div>
					<div>
						<div class="label" style="margin: 2px 0 6px">참조자</div>
						<div class="info-card muted">참조자를 추가해 주세요.</div>
					</div>
				</div>
			</aside>
		</div>
	</main>
</body>
</html>