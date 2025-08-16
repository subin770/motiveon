<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>업무 홈</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">

<style>
:root { -
	-primary: #3A8DFE; -
	-navy: #1d3557; -
	-line: rgba(0, 0, 0, .08); -
	-text: #2B2F3A;
}

body {
	background: #f4f6f9;
	color: var(- -text);
}

/* 페이지 타이틀 */
.page-title {
	padding-left: 20px;
	margin-top: 10px;
	font-size: 18px;
	font-weight: 600;
}

/* 카드 헤더 */
.card-header {
	font-weight: 800;
	font-size: 15px;
	border-bottom: 1px solid var(- -line);
}

/* 탭 */
.tabs {
	display: flex;
	margin: 0;
	padding: 0;
}

.tab {
	padding: 8px 16px;
	color: #333;
	background: #ddd;
	border: 1px solid #ccc;
	border-bottom: none;
	border-radius: 6px 6px 0 0;
	cursor: pointer;
	font-size: 13px;
	font-weight: 400;
}

.tab+.tab {
	margin-left: -1px;
}

.tab:hover {
	background: #d0d0d0;
}

.tab.active {
	background: #6ec1e4;
	color: #000;
}

/* 표 */
.table-clean {
	width: 100%;
	table-layout: fixed;
	border-collapse: separate;
	border-spacing: 0;
	background: #fff;
	border-top: none;
}

.table-clean thead th {
	background: #f5f5f5;
	color: #555;
	font-size: 14px;
	font-weight: 700;
	padding: 12px 16px;
	text-align: center;
	border-bottom: 1px solid var(- -line);
}

.table-clean tbody td {
	padding: 30px 16px;
	border-bottom: 1px solid var(- -line);
	vertical-align: middle;
}

/* 높이 통일 */
#tbl-weekly, #tbl-pending, #tbl-waitreq {
	min-height: 200px;
}

#tbl-weekly tbody, #tbl-pending tbody, #tbl-waitreq tbody {
	min-height: 200px;
	display: table-row-group;
}

/* 빈 데이터 문구 */
.empty-text {
	color: #95A1AF;
	text-align: center;
	padding: 100px 0;
	font-size: 14px;
}

/* 4컬럼 폭 : 40/20/20/20 */
#tbl-weekly thead th:nth-child(1), #tbl-weekly-req thead th:nth-child(1) {
	width: 40%;
}

#tbl-weekly thead th:nth-child(2), #tbl-weekly-req thead th:nth-child(2) {
	width: 20%;
}

#tbl-weekly thead th:nth-child(3), #tbl-weekly-req thead th:nth-child(3) {
	width: 20%;
}

#tbl-weekly thead th:nth-child(4), #tbl-weekly-req thead th:nth-child(4) {
	width: 20%;
}

/* 페이지 여백 */
.content .container-fluid {
	padding-left: 20px;
	padding-right: 20px;
}

/* 부트스트랩 pagination 커스텀 */
.pagination {
    margin: 0;
    margin-top: 20px; 
}

.pagination .page-link {
	min-width: 36px;
	text-align: center;
	border: 1px solid #dee2e6;
	background: #fff;
}

.pagination .page-item:first-child .page-link {
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
}

.pagination .page-item:last-child .page-link {
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
}

.pagination .page-item.active .page-link {
	background: #fff;
	color: #0d6efd;
	border-color: #dee2e6;
}

.pagination .page-link:focus {
	box-shadow: none;
}

/* 탑내비 흰색 */
.content-wrapper {
	margin-left: 0 !important;
}

.content-wrapper, .main-header {
	background: #fff !important;
}
</style>
</head>
<body class="hold-transition layout-top-nav">
	<div class="content-wrapper">

		<!-- 상단 제목 -->
		<section class="content-header">
			<div class="container-fluid">
				<h3 class="page-title">업무</h3>
			</div>
		</section>

		<section class="content">
			<div class="container-fluid">

				<!-- 금주 마감 업무 -->
				<div class="card mb-3">
					<div class="card-header">금주 마감 업무</div>
					<div class="card-body p-3">

						<!-- 탭 -->
						<div class="tabs">
							<div class="tab active" data-tab="my">내 업무</div>
							<div class="tab" data-tab="req">요청한 업무</div>
						</div>

						<!-- 내 업무 -->
						<div id="tab-my">
							<table id="tbl-weekly" class="table-clean">
								<thead>
									<tr>
										<th>제목</th>
										<th>담당자</th>
										<th>상태</th>
										<th>기한</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty weeklyClosingList}">
										<tr>
											<td colspan="4" class="empty-text">금주 마감 업무가 존재하지 않습니다.</td>
										</tr>
									</c:if>
									<c:forEach var="w" items="${weeklyClosingList}">
										<tr>
											<td class="text-truncate">
												<a href="<%=ctx%>/work/detail?wid=${w.wcode}">${w.wtitle}</a>
											</td>
											<td>${w.ownerName}</td>
											<td>${w.statusName}</td>
											<td>${w.wend}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<!-- 요청한 업무 -->
						<div id="tab-req" style="display: none;">
							<table id="tbl-weekly-req" class="table-clean">
								<thead>
									<tr>
										<th>제목</th>
										<th>담당자</th>
										<th>상태</th>
										<th>기한</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty weeklyRequestedList}">
										<tr>
											<td colspan="4" class="empty-text">금주 마감 업무가 존재하지 않습니다.</td>
										</tr>
									</c:if>
									<c:forEach var="r" items="${weeklyRequestedList}">
										<tr>
											<td class="text-truncate">
												<a href="<%=ctx%>/work/detail?wid=${r.wcode}">${r.wtitle}</a>
											</td>
											<td>${r.ownerName}</td>
											<td>${r.statusName}</td>
											<td>${r.wend}</td>
											
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

					</div>
				</div>

				<!-- 하단 2분할 -->
				<div class="row">
					<!-- 미승인 업무 -->
					<div class="col-lg-6 col-12">
						<div class="card h-100 mb-3">
							<div class="card-header">미승인 업무</div>
							<div class="card-body p-3">
								<table id="tbl-pending" class="table-clean">
									<thead>
										<tr>
											<th>제목</th>
											<th>요청자</th>
											<th>기한</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty pendingApprovalList}">
											<tr>
												<td colspan="3" class="empty-text">미승인 업무가 존재하지 않습니다.</td>
											</tr>
										</c:if>
										<c:forEach var="p" items="${pendingApprovalList}">
											<tr>
												<td class="text-truncate">
													<a href="<%=ctx%>/approval/detail?wid=${p.wcode}">${p.wtitle}</a>
												</td>
												<td>${p.requesterName}</td>
												<td>${p.wend}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- 대기중인 요청한 업무 -->
					<div class="col-lg-6 col-12">
						<div class="card h-100 mb-3">
							<div class="card-header">대기중인 요청한 업무</div>
							<div class="card-body p-3">
								<table id="tbl-waitreq" class="table-clean">
									<thead>
										<tr>
											<th>제목</th>
											<th>담당자</th>
											<th>기한</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty waitingRequestedList}">
											<tr>
												<td colspan="3" class="empty-text">대기중인 요청업무가 존재하지 않습니다.</td>
											</tr>
										</c:if>
										<c:forEach var="x" items="${waitingRequestedList}">
											<tr>
												<td class="text-truncate">
													<a href="<%=ctx%>/work/detail?wid=${x.wcode}">${x.wtitle}</a>
												</td>
												<td>${x.ownerName}</td>
												<td>${x.wend}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
 	
			</div>
		</section>
</div>

<script src="<%=ctx%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="<%=ctx%>/resources/bootstrap/dist/js/adminlte.min.js"></script>

<script>
	// 탭 토글
	$('.tab').on('click', function() {
		$('.tab').removeClass('active');	
		$(this).addClass('active');
		const key = $(this).data('tab');
		if (key === 'my') {
			$('#tab-my').show();
			$('#tab-req').hide();
		} else {
			$('#tab-my').hide();
			$('#tab-req').show();
		}
	});
</script>
</body>
</html>
