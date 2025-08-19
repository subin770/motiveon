<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>기안 문서함</title>
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

.btn {
	display: inline-block;
	padding: 8px 14px;
	border-radius: 0;
	font-weight: 700;
	border: 1px solid transparent;
	font-size: 14px;
}

.btn-ok {
	background: #487FC3;
	color: #fff;
}

.btn-cancel {
	background: #D75340;
	color: #fff;
}

.btn-ghost {
	background: #f5f7fb;
	border-color: #dde2ee;
	color: #52586B;
}

.toolbar {
	display: flex;
	gap: 10px;
	align-items: center;
	justify-content: flex-end;
	margin: 0 0 14px;
}

.select, .search {
	background: #fff;
	border: 1px solid #e9ecf3;
	border-radius: 0;
	padding: 8px 12px;
}

select {
	border: none;
	outline: none;
	background: transparent;
	font: inherit;
	color: #52586B;
}

.search {
	display: flex;
	align-items: center;
	gap: 8px;
}

.search input {
	border: none;
	outline: none;
	width: 220px;
	font: inherit;
	color: #52586B;
	background: transparent;
}

.panel {
	background: #fff;
	border: 1px solid #e9ecf3;
	border-radius: 0;
	overflow: hidden;
}

.panel .head {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 12px 14px;
	border-bottom: 1px solid #e9ecf3;
}

.panel .head .h {
	font-weight: 800;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 11px 12px;
	text-align: left;
	border-bottom: 1px solid #e9ecf3;
	font-size: 14px;
}

th {
	font-size: 12px;
	letter-spacing: .04em;
	color: #8b90a0;
	background: #fafbff;
}

tbody tr:hover {
	background: #fafcff;
}

.badge-done {
	display: inline-block;
	padding: 3px 8px;
	border-radius: 999px;
	background: #dcf0e0;
	color: #226b3a;
	font-size: 12px;
}

.badge-prog {
	display: inline-block;
	padding: 3px 8px;
	border-radius: 999px;
	background: #e6e8ff;
	color: #2e3ea8;
	font-size: 12px;
}

.badge-rej {
	display: inline-block;
	padding: 3px 8px;
	border-radius: 999px;
	background: #ffdede;
	color: #b01818;
	font-size: 12px;
}

.badge-hold {
	display: inline-block;
	padding: 3px 8px;
	border-radius: 999px;
	background: #fff2b3;
	color: #715f00;
	font-size: 12px;
}

.txt-em {
	color: #D75340;
	font-weight: 800;
}

/* paging */
.paging {
	display: flex;
	gap: 6px;
	justify-content: center;
	margin: 14px 0;
}

.paging a, .paging span {
	min-width: 34px;
	height: 34px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #e1e5ef;
	background: #fff;
	color: #52586B;
	text-decoration: none;
	font-weight: 700;
}

.paging .on {
	background: #487FC3;
	border-color: #487FC3;
	color: #fff;
}

.paging .dim {
	opacity: .45;
	pointer-events: none;
}
</style>
</head>
<body>
	<div class="wrap">
		<h3 class="font-weight-bold"
			style="padding-left: 10px; margin-left: 20px; margin-top: 10px; font-size: 22px;">기안
			문서함</h3>

		<!-- 필터 -->
		<div class="toolbar">
			<form action="${pageContext.request.contextPath}/approval/draftList"
				method="get" style="display: flex; gap: 10px; align-items: center;">
				<div class="select">
					<select name="period">
						<option value="all" ${period=='all'?'selected':''}>전체기간</option>
						<option value="1m" ${period=='1m'?'selected':''}>1개월</option>
						<option value="6m" ${period=='6m'?'selected':''}>6개월</option>
						<option value="1y" ${period=='1y'?'selected':''}>1년</option>
					</select>
				</div>
				<div class="select">
					<select name="field">
						<option value="title" ${field=='title'?'selected':''}>제목</option>
						<option value="form" ${field=='form'?'selected':''}>결재양식</option>
						<option value="singno" ${field=='singno'?'selected':''}>문서번호</option>
					</select>
				</div>
				<div class="search">
					<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
						aria-hidden>
          <path d="M21 21l-4.35-4.35" stroke="#9aa1b3" stroke-width="2"
							stroke-linecap="round" />
          <circle cx="11" cy="11" r="7" stroke="#9aa1b3"
							stroke-width="2" fill="none" />
        </svg>
					<input name="q" type="text" value="${fn:escapeXml(q)}"
						placeholder="내용을 입력해주세요." />
				</div>
				<input type="hidden" name="page" value="${page}" /> <input
					type="hidden" name="size" value="${size}" />
				<button type="submit" class="btn btn-ok">검색</button>
				<a href="${pageContext.request.contextPath}/approval/draftList"
					class="btn btn-cancel">초기화</a>
			</form>
		</div>

		<!-- 목록 -->
		<section class="panel">
			<div class="head">
				<div class="h">
					기안문서 목록 <span style="font-weight: 400; color: #8b90a0;">(총
						${totalCount}건)</span>
				</div>
				<div>
					<a href="javascript:openFormPicker()" class="btn btn-ghost">새
						결재 작성</a>
					<script>
function openFormPicker(){
  const w=680,h=560; 
  const y=window.top.outerHeight/2 + window.top.screenY - (h/2);
  const x=window.top.outerWidth/2 + window.top.screenX - (w/2);
  window.open('${pageContext.request.contextPath}/approval/formPicker','formPicker',
    `width=${w},height=${h},left=${x},top=${y},resizable=no,scrollbars=yes`);
}
</script>

				</div>
			</div>
			<table>
				<thead>
					<tr>
						<th style="width: 48px"><input type="checkbox"
							onclick="toggleAll(this)"></th>
						<th style="width: 120px">기안일</th>
						<th style="width: 150px">결재양식</th>
						<th style="width: 80px">긴급</th>
						<th>제목</th>
						<th style="width: 140px">문서번호</th>
						<th style="width: 120px">결재상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="d" items="${list}">
						<tr>
							<td><input type="checkbox"></td>
							<td><fmt:formatDate value="${d.draftAt}"
									pattern="yyyy-MM-dd" /></td>
							<td><c:out value="${d.formNo}" /></td>
							<td><c:if test="${d.emergency == 1}">
									<span class="txt-em">긴급</span>
								</c:if></td>
							<td><a
								href="${pageContext.request.contextPath}/approval/detail?signNo=${d.signNo}"><c:out
										value="${d.title}" /></a></td>
							<td><c:out value="${d.signNo}" /></td>
							<td><c:choose>
									<c:when test="${d.docStatus == 3}">
										<span class="badge-done">완료</span>
									</c:when>
									<c:when test="${d.docStatus == 4}">
										<span class="badge-rej">반려</span>
									</c:when>
									<c:when test="${d.docStatus == 6}">
										<span class="badge-hold">보류</span>
									</c:when>
									<c:otherwise>
										<span class="badge-prog">진행중</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="7" style="color: #8b90a0; text-align: center;">표시할
								문서가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<!-- 페이징 -->
			<div class="paging">
				<c:url var="baseUrl" value="/approval/draftList">
					<c:param name="period" value="${period}" />
					<c:param name="field" value="${field}" />
					<c:param name="q" value="${q}" />
					<c:param name="size" value="${size}" />
				</c:url>

				<c:choose>
					<c:when test="${page <= 1}">
						<span class="dim">&laquo;</span>
					</c:when>
					<c:otherwise>
						<a href="${baseUrl}&page=${page-1}">&laquo;</a>
					</c:otherwise>
				</c:choose>

				<c:set var="startP" value="${page-2 < 1 ? 1 : page-2}" />
				<c:set var="endP"
					value="${page+2 > totalPages ? totalPages : page+2}" />
				<c:forEach var="p" begin="${startP}" end="${endP}">
					<c:choose>
						<c:when test="${p == page}">
							<span class="on">${p}</span>
						</c:when>
						<c:otherwise>
							<a href="${baseUrl}&page=${p}">${p}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${page >= totalPages || totalPages == 0}">
						<span class="dim">&raquo;</span>
					</c:when>
					<c:otherwise>
						<a href="${baseUrl}&page=${page+1}">&raquo;</a>
					</c:otherwise>
				</c:choose>
			</div>
		</section>
	</div>

	<script>
		function toggleAll(chk) {
			var boxes = document
					.querySelectorAll('tbody input[type="checkbox"]');
			boxes.forEach(function(b) {
				b.checked = chk.checked;
			});
		}
	</script>
</body>
</html>
