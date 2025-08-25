<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<!-- Main content -->
		<section class="content">
			<div class="card">

				<!-- 헤더 영역 -->
				<div class="card-header">
					<h3 style="padding-left: 20px; margin-top: 10px; font-size: 22px;">인사
						기록 관리</h3>

					<div class="d-flex justify-content-between align-items-center mt-3">
						<div>
							<button type="button" class="btn btn-primary"
								onclick="OpenWindow('regist','계정등록',700,460);">계 정 등 록</button>
						</div>

						<div class="d-flex align-items-center" style="gap: 8px;">
							<select id="sortSelect" class="form-select"
								style="width: 70px; height: 38px; line-height: 1.2; text-align: center; background-color: #fff; color: #495057; border: 1px solid #ced4da; border-radius: .25rem;">
								<option value="name">이름</option>
								<option value="deptName">소속</option>
								<option value="ppsCode">직위</option>
							</select> <input type="text" id="searchInput" placeholder="검색"
								class="form-control" style="width: 180px;">
							<button type="button" class="btn btn-secondary"
								onclick="searchRecords();">검색</button>
						</div>
					</div>
				</div>

				<!-- 테이블 영역 -->
				<div class="card-body">
					<table class="table table-bordered table-striped text-center"
						id="accountTable">
						<thead>
							<tr>
								<th>로그인시간</th>
								<th>이름</th>
								<th>소속</th>
								<th>직위</th>
								<th>직책</th>
								<th>입사일</th>
								<th>퇴사일</th>
								<th>권한</th>
								<th>계정상태</th>
								<th>안전여부</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty accountList}">
								<tr>
									<td colspan="10">등록된 계정이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${accountList}" var="account">
								<tr
									onclick="OpenWindow('detail?empNo=${account.empNo}','계정 상세',700,800);"
									style="cursor: pointer;">
									<td>${account.loginTime}</td>
									<td>${account.name}</td>
									<td>${account.deptName}</td>
									<!-- 부서명 -->
									<td>${account.ppsName}</td>
									<!-- 직위 -->
									<td>${account.job}</td>
									<!-- 직책 -->
									<td><fmt:formatDate value="${account.joinDate}"
											pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatDate value="${account.leaveDate}"
											pattern="yyyy-MM-dd" /></td>
									<td>${account.role}</td>
									<td><span
										class="status-tag 
        <c:choose>
            <c:when test="${account.enabled == 1}">status-normal</c:when>
            <c:when test="${account.enabled == 0}">status-leave</c:when>
        </c:choose>">
											<c:choose>
												<c:when test="${account.enabled == 1}">정상</c:when>
												<c:when test="${account.enabled == 0}">퇴사</c:when>
											</c:choose>
									</span></td>
									<td><span
										class="status-tag 
                                    <c:choose>
                                        <c:when test="${account.safety == '안전'}">status-safe</c:when>
                                        <c:when test="${account.safety == '경고'}">status-warning</c:when>
                                        <c:when test="${account.safety == '취약'}">status-danger</c:when>
                                    </c:choose>">${account.safety}</span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<!-- 페이징 영역 -->
				<div class="card-footer text-center">
					<%@ include file="/WEB-INF/views/module/pagination.jsp"%>
				</div>
			</div>
		</section>
	</div>

	<!-- 상태 표시 스타일 -->
	<style>
.status-tag {
	padding: 3px 8px;
	border-radius: 5px;
	font-weight: bold;
	color: #fff;
}

.status-normal {
	background-color: gray;
}

.status-leave {
	background-color: gray;
}

.status-safe {
	background-color: #28a745;
}

.status-warning {
	background-color: #ffc107;
	color: #000;
}

.status-danger {
	background-color: #dc3545;
}

.status-active {
	background-color: gray;
}

.status-inactive {
	background-color: #dc3545;
}
</style>

	<!-- 추후 기능용 JS -->
	<script>
		function openAccountForm() {
			console.log("계정 등록");
		}
		function editAccount(id) {
			console.log("수정: " + id);
		}
		function searchRecords() {
			console.log("검색어:", document.getElementById('searchInput').value);
		}
	</script>

</body>