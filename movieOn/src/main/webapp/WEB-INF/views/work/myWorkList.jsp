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
<title>내 업무</title>
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

body, .content-wrapper, .main-footer, .main-header, .content {
	background-color: #fff !important;
}

/* 페이지 타이틀 */
.page-title {
	padding-left: 20px;
	margin-top: 10px;
	font-size: 18px;
	font-weight: 600;
}

/* 현황 카드 */
.status-wrap {
	display: grid !important;
	grid-template-columns: repeat(6, 1fr);
	gap: 16px;
}

.stat {
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	min-height: 80px;
	border-radius: 12px;
	box-shadow: 0 1px 2px rgba(0, 0, 0, .04);
}

.stat .num {
	position: absolute;
	top: 10px;
	left: 12px;
	font-weight: 700;
	color: #6B7280;
}

.stat .cap {
	font-weight: 700;
	color: #4B5563;
}

.stat.wait {
	background: #D6EFD8;
}

.stat.prog {
	background: #F6D6C6;
}

.stat.agree {
	background: #F4D4ED;
}

.stat.dele {
	background: #D9D9D9;
}

.stat.done {
	background: #FFF7AE;
}

.stat.all {
	background: #E3E7EF;
}

/* 탭 */
.tabs {
	display: flex;
	margin: 0;
	padding: 0;
}

.tab {
	padding: 8px 16px;
	background: #ddd;
	border: 1px solid #ccc;
	border-bottom: none;
	border-radius: 6px 6px 0 0;
	cursor: pointer;
	font-size: 13px;
	font-weight: 400;
	color: #333;
}

.tab.active {
	background: #6ec1e4;
	color: #000;
}

.tab+.tab {
	margin-left: -1px;
}

.tab:hover {
	background: #d0d0d0;
}

/* 검색/헤더 */
.header-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.input-group .form-control {
	height: 38px;
}

.input-group select.form-control {
	width: 110px;
	flex: 0 0 auto;
	padding-left: 8px;
	padding-right: 8px;
	font-size: 13px;
}

.input-group input.form-control {
	flex: 1 1 auto;
}

.btn-search {
	background: #2C3E50;
	color: #fff;
}

/* 테이블 */
.table-clean {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	background: #fff;
}

.table-clean thead th {
	background: #f5f5f5;
	color: #555;
	font-size: 14px;
	font-weight: 700;
	padding: 14px 16px;
	text-align: center;
	border-bottom: 1px solid var(- -line);
}

.table-clean tbody td {
	padding: 14px 16px;
	border-bottom: 1px solid var(- -line);
	vertical-align: middle;
}

.t-title {
	font-weight: 800;
	color: #111827;
}

.t-sub {
	font-size: 12px;
	color: #6B7280;
}

/* 상태 배지 */
.badge-pill {
	border-radius: 999px;
	padding: 6px 12px;
	font-weight: 800;
	font-size: 12px;
}

.badge-wait {
	background: #EEF2F6;
	color: #6B7280;
}

.badge-prog {
	background: rgba(58, 141, 254, .12);
	color: #3A8DFE;
}

.badge-done {
	background: rgba(39, 174, 96, .12);
	color: #27AE60;
}

.badge-dele {
	background: rgba(244, 180, 0, .16);
	color: #C48A00;
}

/* 헤더 폭 */
.table-clean thead th:nth-child(1) {
	width: 15%;
}

.table-clean thead th:nth-child(2) {
	width: 25%;
}

.table-clean thead th:nth-child(3) {
	width: 15%;
}

.table-clean thead th:nth-child(4) {
	width: 15%;
}

.table-clean thead th:nth-child(5) {
	width: 15%;
	text-align: left;
	padding-left: 10px;
}

/* 카드 헤더 */
.card-header {
	font-weight: 800;
	font-size: 15px;
	border-bottom: 1px solid var(- -line);
	position: relative;
}

/* 새업무 버튼 플로팅 */
.btn-newwork-float {
	position: absolute;
	top: 8px;
	right: 12px;
	z-index: 5;
}

/* 탑내비 사용 시 좌여백 제거 */
.content-wrapper {
	margin-left: 0 !important;
}
</style>
</head>
<body class="hold-transition layout-top-nav">
	<div class="content-wrapper">
		<section class="content-header">
			<div class="container-fluid">
				<h3 class="page-title">업무 &nbsp;&gt;&nbsp; 내 업무</h3>
			</div>
		</section>

		<section class="content">
			<div class="container-fluid">

				<!-- 미확인 업무 현황 -->
				<div class="card mb-3">
					<div class="card-header">미확인 업무 현황</div>
					<div class="card-body p-3">
						<div class="status-wrap">
							<div class="stat wait" data-filter="WAIT">
								<div class="num">${summary.wait}</div>
								<div class="cap">대기</div>
							</div>
							<div class="stat prog" data-filter="PROG">
								<div class="num">${summary.progress}</div>
								<div class="cap">진행</div>
							</div>
							<div class="stat agree" data-filter="AGREE">
								<div class="num">${summary.agree}</div>
								<div class="cap">협업요청</div>
							</div>
							<div class="stat dele" data-filter="DELEGATE">
								<div class="num">${summary.delegate}</div>
								<div class="cap">대리요청</div>
							</div>
							<div class="stat done" data-filter="DONE">
								<div class="num">${summary.done}</div>
								<div class="cap">완료</div>
							</div>
							<div class="stat all" data-filter="ALL">
								<div class="num">${summary.total}</div>
								<div class="cap">전체</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 내 업무 목록 -->
				<div class="card">
					<div class="card-header">
						내 업무 목록
						<button id="btnNewWork" type="button"
							class="btn btn-outline-primary btn-sm btn-newwork-float">
							<i class="fas fa-plus mr-1"></i> 새 업무
						</button>
					</div>
					<div class="card-body p-3">

						<!-- 탭 + 검색 -->
						<div class="header-row">
							<div class="tabs">
								<div class="tab active" data-filter="ALL">전체</div>
								<div class="tab" data-filter="WAIT">대기</div>
								<div class="tab" data-filter="PROG">진행</div>
								<div class="tab" data-filter="AGREE">협업요청</div>
								<div class="tab" data-filter="DELEGATE">대리요청</div>
								<div class="tab" data-filter="DONE">완료</div>
							</div>

							<div class="input-group" style="max-width: 420px;">
								<select id="searchField" class="form-control">
									<option value="title">전체</option>
									<option value="requester">요청자</option>
									<option value="assignee">담당자</option>
								</select> <input id="keyword" type="text" class="form-control"
									placeholder="검색어를 입력하세요."
									style="flex: 1 1 auto; font-size: 13px;">
								<div class="input-group-append">
									<button id="btnSearch" class="btn btn-search">
										<i class="fas fa-search"></i>
									</button>
								</div>
							</div>
						</div>

						<!-- 목록 -->
						<table class="table-clean">
							<thead>
								<tr>
									<th>제목</th>
									<th>요청자</th>
									<th>담당자</th>
									<th class="text-center">기한</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<c:forEach var="w" items="${workList}">
									<tr data-status="${w.status}" data-title="${w.title}"
										data-requester="${w.requesterName}"
										data-assignee="${w.assigneeName}">
										<td>
											<div class="t-title">${w.title}</div>
											<div class="t-sub">${w.categoryName}</div>
										</td>
										<td>${w.requesterName}</td>
										<td>${w.assigneeName}</td>
										<td class="text-center">${w.dueDate}</td>
										<td class="text-right"><c:choose>
												<c:when test="${w.status eq 'PROG'}">
													<span class="badge-pill badge-prog">진행</span>
												</c:when>
												<c:when test="${w.status eq 'DONE'}">
													<span class="badge-pill badge-done">완료</span>
												</c:when>
												<c:when test="${w.status eq 'DELEGATE'}">
													<span class="badge-pill badge-dele">대리 요청</span>
												</c:when>
												<c:otherwise>
													<span class="badge-pill badge-wait">대기</span>
												</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
								<c:if test="${empty workList}">
									<tr>
										<td colspan="5" class="text-center"
											style="padding: 40px 0; color: #95A1AF; font-size: 14px;">표시할
											업무가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>

					</div>
				</div>

			</div>
		</section>
	</div>

	<script src="<%=ctx%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	<script src="<%=ctx%>/resources/bootstrap/dist/js/adminlte.min.js"></script>
	<script>
    function filterBy(status){
      $('.tab').removeClass('active');
      $('.tab[data-filter="'+status+'"]').addClass('active');
      if(status==='ALL'){ $('#tbody tr').show(); return; }
      $('#tbody tr').each(function(){ $(this).toggle($(this).data('status')===status); });
    }
    $('.tab').on('click', function(){ filterBy($(this).data('filter')); });
    $('.stat').on('click', function(){ filterBy($(this).data('filter')); });

    $('#btnSearch').on('click', function(e){
      e.preventDefault();
      const f = $('#searchField').val();
      const kw = ($('#keyword').val()||'').toLowerCase().trim();
      $('#tbody tr').each(function(){
        const allText = ($(this).find('td').map((i,td)=>$(td).text()).get().join(' ')||'').toLowerCase();
        const fieldVal = (String($(this).data(f))||'').toLowerCase();
        $(this).toggle( (f==='title' ? allText : fieldVal).indexOf(kw) > -1 );
      });
    });
    $('#keyword').on('keydown', e=>{ if(e.key==='Enter') $('#btnSearch').click(); });

    // 새업무 버튼 팝업
    (function(){
      var ctx = '<%=ctx%>';
      $('#btnNewWork').on('click', function(){
        var url = ctx + '/work/workRegistForm';
        var opt = 'width=980,height=720,top=80,left=120,scrollbars=yes';
        window.open(url, 'workRegPopup', opt);
      });
    })();

    // 초기 상태
    filterBy('ALL');
  </script>
</body>
</html>
