<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부서 근태 관리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />

<style>

/* ===== 상단 월 타이틀 바 ===== */
.header {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	margin: 8px 0 14px;
}

.header .ym {
	font-size: 30px;
	font-weight: 700;
	letter-spacing: .2px;
	min-width: 120px;
	text-align: center;
	color: #333;
}

.arrow {
	width: 32px;
	height: 32px;
	line-height: 30px;
	text-align: center;
	user-select: none;
	cursor: pointer;
	background: #fff;
	color: #666;
}

.arrow:hover {
	background: #f3f4f6
}

.box2 {
	border: 1px solid #e6e6e6;
	padding: 1rem;
	background: #fff;
}

/* ===== 카드/테이블 프레임 ===== */
.box {
	background: #fff;
	padding: 1rem 1.5rem;
}

.subbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 10px
}

.badge {
	font-size: 13px;
	color: #555
}

.subbar .right {
	font-size: 13px;
	color: #555
}

.subbar .right .hint-aster {
	color: #9ca3af;
	margin-right: 4px
}

/* ===== 컨트롤 (정렬/검색) ===== */
.controls {
	display: flex;
	align-items: center;
	gap: 8px;
	margin-bottom: 12px
}

.controls label {
	color: #555;
	font-size: 13px;
	margin-right: 4px
}

select, input[type="search"] {
	height: 32px;
	font-size: 13px;
	padding: 0 8px;
	border: 1px solid #e6e6e6;
	border-radius: 6px;
	background: #fff;
	color: #444
}

select {
	min-width: 90px
}

.search-wrap {
	position: relative
}

.search-wrap input[type="search"] {
	width: 200px;
	padding-left: 28px
}

.search-wrap:before {
	content: "";
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	width: 14px;
	height: 14px;
	border: 2px solid #9aa0a6;
	border-radius: 50%;
}

.search-wrap:after {
	content: "";
	position: absolute;
	left: 20px;
	top: 60%;
	width: 7px;
	height: 2px;
	background: #9aa0a6;
	transform: rotate(45deg);
}

/* ===== 테이블 ===== */
.table {
	width: 100%;
	margin: 0;
}

.table th, .table td {
	padding: 8px 0.75rem;
	font-size: 16px;
}

.table thead th {
	background: #f6f7fb;
	color: #444;
	font-weight: 600;
	text-align: center;
}

.table tbody td {
	text-align: center;
}

/* ===== 페이지네이션 ===== */
.pagination {
	display: flex;
	gap: 6px;
	justify-content: center;
	margin: 16px 0 4px;
}

.page-btn {
	min-width: 30px;
	height: 30px;
	border: 1px solid #0c4b8d;
	background: #fff;
	color: #0c4b8d;
	border-radius: 6px;
	font-size: 13px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	text-decoration: none;
}

.page-btn:hover {
	background: #f0f6ff;
}

.page-btn.active {
	background: #0c4b8d;
	border-color: #0c4b8d;
	color: #fff;
	font-weight: 700;
}

/* ===== 근태율 빨간색 ===== */
.rate {
	color: #e11d48;
	font-weight: 700;
}
</style>
</head>

<body>
	<div class="wrap">
		<!-- 상단 경로 -->
		<div class="crumb">
			<h3 class="font-weight-bold"
				style="padding-left: 10px; margin-left: 20px; margin-top: 10px; font-size: 22px;">부서
				인사관리 &gt; ${teamName}</h3>
		</div>

		<div class="box">
			<!-- 상단 헤더 -->
			<div class="header">
				<div class="arrow" onclick="changeMonth(-1)">&#60;</div>
				<div class="ym">${year}.${month}</div>
				<div class="arrow" onclick="changeMonth(1)">&#62;</div>
			</div>

			<div class="box2">

				<!-- 부서명 + 근무일수 -->
				<div class="subbar">
					<span class="badge">*총 근무일수 = 출근 + 결근 + 휴가 </span>
					<div class="right">
						${year}년 ${month}월 근무일수 : <span class="sum"><fmt:formatNumber
								value="${workDays}" /></span>일
					</div>
				</div>

				<!-- 정렬/검색 -->
				<div class="controls">
					<label>정렬기준</label> <select onchange="applySort()">
						<option value="job" ${sort eq 'job' ? 'selected' : ''}>직위</option>
						<option value="name" ${sort eq 'name' ? 'selected' : ''}>이름</option>
					</select> <select onchange="applySortOrder()">
						<option value="asc" ${order eq 'asc' ? 'selected' : ''}>오름차순</option>
						<option value="desc" ${order eq 'desc' ? 'selected' : ''}>내림차순</option>
					</select>
					<div class="search-wrap">
						<input type="search" name="q" placeholder="사번, 이름" value="${q}">
					</div>
				</div>

				<!-- 테이블 -->
				<table class="table">
					<thead>
						<tr>
							<th>성명</th>
							<th>직위</th>
							<th>사번</th>
							<th>지각</th>
							<th>조회</th>
							<th>휴가</th>
							<th>결근</th>
							<th>출근</th>
							<th>합계일수</th>
							<th>근태율(%)</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${list}">
							<tr>
								<td>${row.name}</td>
								<td>${row.job}</td>
								<td>${row.eno}</td>
								<td>${row.late}</td>
								<td>${row.earlyLeave}</td>
								<td>${row.vacation}</td>
								<td>${row.absent}</td>
								<td>${row.present}</td>
								<td>${row.totalDays}</td>
								<td class="rate">${row.rate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 페이지네이션 -->
			<div class="pagination">
				<c:forEach var="i" begin="1" end="${totalPages}">
					<a href="?year=${year}&month=${month}&page=${i}"
						class="page-btn ${i == page ? 'active' : ''}">${i}</a>
				</c:forEach>
			</div>
		</div>
	</div>

	<script>
		function changeMonth(offset) {
			let year = parseInt("${year}");
			let month = parseInt("${month}") - 1; // JS에서 month는 0~11
			let date = new Date(year, month + offset, 1);
			let newYear = date.getFullYear();
			let newMonth = date.getMonth() + 1;
			if (newMonth < 10)
				newMonth = "0" + newMonth;
			location.href = "?year=" + newYear + "&month=" + newMonth;
		}
	</script>

</body>
</html>
