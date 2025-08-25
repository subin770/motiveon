<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<body>
	<section class="content-header">
		<div class="container-fluid">
			<div class="row md-2">
				<div class="col-sm-6">
					<h1>계정 상세보기</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item" style="color: blue;">계정관리</li>
						<li class="breadcrumb-item active">상세보기</li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title">상세보기</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-warning" onclick="modify();">수
								정</button>
							<button type="button" class="btn btn-danger" onclick="remove();">삭
								제</button>
							<button type="button" class="btn btn-primary"
								onclick="window.close();">닫 기</button>
						</div>
					</div>

					<div class="card-body">

						<div class="row">
							<div class="form-group col-sm-4">
								<label>로그인번호</label> <span class="form-control">${account.empNo}</span>
							</div>
							<div class="form-group col-sm-4">
								<label>이름</label> <span class="form-control">${account.name}</span>
							</div>
							<div class="form-group col-sm-4">
								<label>소속</label> <span class="form-control">${account.deptName}</span>
							</div>
						</div>

						<div class="row">
							<div class="form-group col-sm-4">
								<label>직위</label> <span class="form-control">${account.ppsName}</span>
							</div>
							<div class="form-group col-sm-4">
								<label>직책</label> <span class="form-control">${account.job}</span>
							</div>
							<div class="form-group col-sm-4">
								<label>권한</label> <span class="form-control">${account.role}</span>
							</div>
						</div>

						<div class="row">
							<div class="form-group col-sm-4">
								<label>입사일</label> <span class="form-control"> <fmt:formatDate
										value="${account.joinDate}" pattern="yyyy-MM-dd" />
								</span>
							</div>
							<div class="form-group col-sm-4">
								<label>퇴사일</label> <span class="form-control"> <fmt:formatDate
										value="${account.leaveDate}" pattern="yyyy-MM-dd" />
								</span>
							</div>
							<div class="form-group col-sm-4">
								<label>계정상태</label> <span class="form-control"> <c:choose>
										<c:when test="${account.enabled == 1}">정상</c:when>
										<c:when test="${account.enabled == 0}">퇴사</c:when>
										<c:otherwise>${account.enabled}</c:otherwise>
									</c:choose>
								</span>
							</div>
						</div>

						<div class="row">
							<div class="form-group col-sm-4">
								<label>안전여부</label> <span class="form-control"> <c:choose>
										<c:when test="${account.safety == '안전'}">안전</c:when>
										<c:when test="${account.safety == '경고'}">경고</c:when>
										<c:when test="${account.safety == '취약'}">취약</c:when>
										<c:otherwise>${account.safety}</c:otherwise>
									</c:choose>
								</span>
							</div>
						</div>

					</div>
				</div>
				<!-- end card -->
			</div>
		</div>
	</section>

	<script>
		function modify() {
			location.href = "modify?empNo=${account.empNo}";
		}

		function remove() {
			location.href = "remove?empNo=${account.empNo}";
		}
	</script>
</body>