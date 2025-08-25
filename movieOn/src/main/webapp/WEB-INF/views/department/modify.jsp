<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<!-- Bootstrap / Summernote CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.css">
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
</head>

<body>
	<section class="content-header">
		<div class="container-fluid">
			<div class="row md-2">
				<div class="col-sm-6">
					<h1>부서 수정</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item" style="color: blue;">부서관리</li>
						<li class="breadcrumb-item active">수정</li>
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
						<h3 class="card-title">부서 정보 수정</h3>
						<div class="card-tools">
							<div class="float-right">
								<button type="button" class="btn btn-warning"
									onclick="submitModify();">수 정</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-default"
									onclick="history.back();">취 소</button>
							</div>
						</div>
					</div>

					<div class="card-body">
						<form id="modifyForm" method="post" action="modify">
							<!-- 부서 번호(hidden) -->
							<input type="hidden" name="dno" value="${department.dno}" />

							<div class="form-group">
								<label for="name">부서명</label> <input type="text" id="name"
									name="name" class="form-control" value="${department.name}"
									required>
							</div>

							<div class="form-group">
								<label for="manager">부서장</label> <input type="text" id="manager"
									name="manager" class="form-control"
									value="${department.manager}">
							</div>

							<div class="form-group">
								<label for="memberCount">부서원 수</label> <input type="number"
									id="memberCount" name="memberCount" class="form-control"
									value="${department.memberCount}" min="0" required>
							</div>

							<div class="form-group">
								<label for="enabled">상태</label> <select id="enabled"
									name="enabled" class="form-control">
									<option value="1" ${department.enabled == 1 ? 'selected' : ''}>사용</option>
									<option value="0" ${department.enabled != 1 ? 'selected' : ''}>미사용</option>
								</select>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>
		function submitModify() {
			const form = document.getElementById('modifyForm');
			form.submit();
		}
	</script>
</body>
