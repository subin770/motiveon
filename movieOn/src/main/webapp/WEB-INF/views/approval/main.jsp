<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>전자결재 홈</title>
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

/* 검색/필터 바 (KPI 위) */
.toolbar {
	display: flex;
	gap: 10px;
	align-items: center;
	justify-content: flex-end;
	margin: 0 0 18px;
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

.btn {
	display: inline-block;
	padding: 10px 16px;
	border-radius: 0;
	font-weight: 700;
	border: 1px solid transparent;
	font-size: 14px;
	text-align: center;
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
align-items: center;
	background: #FFFFF;
	color: #52586B;
}

/* KPI 카드 */
.kpis {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 18px;
	margin-bottom: 18px;
}

.kpi {
	background: #fff;
	border: 1px solid #e9ecf3;
	border-radius: 0;
	overflow: hidden;
	text-align: center;
}

.kpi .count {
	font-weight: 800;
	font-size: 22px;
	padding: 18px;
	text-align: center;
}

.kpi:nth-child(1) .count {
	background: #cfe9d9;
} /* 긴급 */
.kpi:nth-child(2) .count {
	background: #f2d2c5;
} /* 반려 */
.kpi.kpi-hold .count {
	background: #ffe980;
} /* 보류 */
.kpi:nth-child(4) .count {
	background: #e1d3f0;
} /* 대기 */
.kpi .title {
	padding: 12px 16px 6px;
	font-weight: 700;
}

.kpi .go {
	padding: 12px 16px 16px;
}

/* 패널 + 테이블 */
.panel {
	background: #fff;
	border: 1px solid #e9ecf3;
	border-radius: 0;
	overflow: hidden;
	margin-bottom: 18px;
}

.panel .head {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 14px 16px;
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
	padding: 12px 14px;
	text-align: left;
	border-bottom: 1px solid #e9ecf3;
	font-size: 14px;
}

th {
	font-size: 12px;
	text-transform: uppercase;
	letter-spacing: .04em;
	color: #8b90a0;
	background: #fafbff;
}

tbody tr:hover {
	background: #fafcff;
}

/* 하단 2단 */
.grid-2 {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 18px;
}

/* 결재자 표시 */
.approver {
	display: flex;
	align-items: center;
	gap: 8px;
}

.avatar {
	width: 22px;
	height: 22px;
	border-radius: 50%;
	background: #e7ebf6;
}

.chip {
	display: inline-block;
	font-size: 12px;
	padding: 4px 8px;
	border-radius: 999px;
	background: #eef2ff;
	color: #334;
}

.right {
	display: flex;
	gap: 8px;
}
</style>
</head>
<body>
	<div class="wrap">
		<!-- 제목: 요청한 h3 스타일 -->
		<h3 class="font-weight-bold"
			style="padding-left: 10px; margin-left: 20px; margin-top: 10px; font-size: 22px;">
			전자결재 홈</h3>

		<!-- 검색/필터 -->
		<div class="toolbar">
			<form action="${pageContext.request.contextPath}/approval/main"
				method="get" style="display: flex; gap: 10px; align-items: center;">
				<div class="select">
					<select name="period">
						<option value="all" ${param.period == 'all' ? 'selected' : ''}>전체기간</option>
						<option value="1m" ${param.period == '1m' ? 'selected' : ''}>1개월</option>
						<option value="6m" ${param.period == '6m' ? 'selected' : ''}>6개월</option>
						<option value="1y" ${param.period == '1y' ? 'selected' : ''}>1년</option>
					</select>
				</div>
				<div class="select">
					<select name="field">
						<option value="title" ${param.field == 'title' ? 'selected' : ''}>제목</option>
						<option value="form" ${param.field == 'form'  ? 'selected' : ''}>결재양식</option>
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
					<input name="q" type="text" value="${fn:escapeXml(param.q)}"
						placeholder="내용을 입력해주세요." />
				</div>
				<div class="right">
					<button type="submit" class="btn btn-ok">검색</button>
					<a href="${pageContext.request.contextPath}/approval/main"
						class="btn btn-cancel">초기화</a>
				</div>
			</form>
		</div>

		<!-- KPI Cards -->
		<section class="kpis">
			<article class="kpi">
				<div class="count">${urgentCount}</div>
				<div class="title">긴급 결재 문서</div>
				<div class="go">
					<a
						href="${pageContext.request.contextPath}/approval/list?filter=urgent"
						class="btn btn-ghost">바로가기</a>
				</div>
			</article>

			<article class="kpi">
				<div class="count">${returnedCount}</div>
				<div class="title">기안 반려 문서</div>
				<div class="go">
					<a
						href="${pageContext.request.contextPath}/approval/list?filter=returned"
						class="btn btn-ghost">바로가기</a>
				</div>
			</article>

			<article class="kpi kpi-hold">
				<div class="count">${holdCount}</div>
				<div class="title">결재 보류 문서</div>
				<div class="go">
					<a
						href="${pageContext.request.contextPath}/approval/list?filter=hold"
						class="btn btn-ghost">바로가기</a>
				</div>
			</article>

			<article class="kpi">
				<div class="count">${waitingCount}</div>
				<div class="title">결재 대기 문서</div>
				<div class="go">
					<a
						href="${pageContext.request.contextPath}/approval/list?filter=waiting"
						class="btn btn-ghost">바로가기</a>
				</div>
			</article>
		</section>

		<!-- 최근 작성중인 문서 -->
		<section class="panel">
			<div class="head">
				<div class="h">최근 작성중인 문서</div>
			</div>
			<div class="body">
				<table>
					<thead>
						<tr>
							<th style="width: 140px">생성일</th>
							<th style="width: 160px">결재양식</th>
							<th>제목</th>
							<th style="width: 140px">수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${recentDrafts}">
							<tr>
								<td><fmt:formatDate value="${row.draftAt}"
										pattern="yyyy-MM-dd" /></td>
								<td><c:out value="${row.formNo}" /></td>
								<td><a
									href="${pageContext.request.contextPath}/approval/edit?signNo=${row.signNo}"><c:out
											value="${row.title}" /></a></td>
								<td><fmt:formatDate value="${row.updateAt}"
										pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
						<c:if test="${empty recentDrafts}">
							<tr>
								<td colspan="4" style="color: #8b90a0;">최근 작성중인 문서가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</section>

		<!-- 하단 2단 -->
		<section class="grid-2">
			<article class="panel">
				<div class="head">
					<div class="h">진행중인 기안 문서</div>
				</div>
				<div class="body">
					<table>
						<thead>
							<tr>
								<th style="width: 120px">기안일</th>
								<th style="width: 140px">결재양식</th>
								<th>제목</th>
								<th style="width: 220px">현재 결재자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="d" items="${ongoingDrafts}">
								<tr>
									<td><fmt:formatDate value="${d.draftAt}"
											pattern="yyyy-MM-dd" /></td>
									<td><c:out value="${d.formNo}" /></td>
									<td><a
										href="${pageContext.request.contextPath}/approval/detail?signNo=${d.signNo}"><c:out
												value="${d.title}" /></a></td>
									<td><c:choose>
											<c:when test="${not empty d.approverName}">
												<div class="approver">
													<span class="avatar"></span>
													<div>
														<div>
															<c:out value="${d.approverName}" />
														</div>
														<div class="chip">
															부서
															<c:out value="${d.approverDept}" />
														</div>
													</div>
												</div>
											</c:when>
											<c:otherwise>-</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
							<c:if test="${empty ongoingDrafts}">
								<tr>
									<td colspan="4" style="color: #8b90a0;">진행중인 문서가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</article>

			<article class="panel">
				<div class="head">
					<div class="h">승인할 결재 문서</div>
				</div>
				<div class="body">
					<table>
						<thead>
							<tr>
								<th style="width: 120px">기안일</th>
								<th style="width: 140px">결재양식</th>
								<th>제목</th>
								<th style="width: 220px">현재 결재자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="a" items="${toApprove}">
								<tr>
									<td><fmt:formatDate value="${a.draftAt}"
											pattern="yyyy-MM-dd" /></td>
									<td><c:out value="${a.formNo}" /></td>
									<td><a
										href="${pageContext.request.contextPath}/approval/detail?signNo=${a.signNo}"><c:out
												value="${a.title}" /></a></td>
									<td><c:choose>
											<c:when test="${not empty a.approverName}">
												<div class="approver">
													<span class="avatar"></span>
													<div>
														<div>
															<c:out value="${a.approverName}" />
														</div>
														<div class="chip">
															부서
															<c:out value="${a.approverDept}" />
														</div>
													</div>
												</div>
											</c:when>
											<c:otherwise>-</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
							<c:if test="${empty toApprove}">
								<tr>
									<td colspan="4" style="color: #8b90a0;">승인할 문서가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</article>
		</section>
	</div>
</body>
</html>
