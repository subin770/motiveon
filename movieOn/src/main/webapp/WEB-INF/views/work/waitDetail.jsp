<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>대기 업무 상세</title>
<link rel="stylesheet"
	href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
body {
	background: #fff;
}

.page-title {
	font-size: 18px;
	font-weight: 700;
	color: #2B2F3A;
}

.detail-card {
	border: 1px solid #e5e7eb;
	box-shadow: none;
}

.detail-table th {
	width: 140px;
	background: #f8fafc;
	color: #6b7280;
	vertical-align: middle;
	text-align: center;
}

.detail-table td {
	background: #fff;
	color: #111827;
}

.detail-table .content-cell {
	white-space: pre-wrap;
	line-height: 1.6;
}
</style>
</head>
<body>

	<div class="container-fluid p-3">
		<!-- 제목 + 버튼 영역 -->
		<div class="d-flex align-items-center justify-content-between mb-2">
			<div class="page-title">상세보기</div>
			<div>
				<!-- 승인 버튼 -->
				<button type="button" id="btnApprove" class="btn btn-success btn-sm">승인</button>

				<!-- 이의신청 버튼 -->
				<button type="button" class="btn btn-danger btn-sm"
					data-toggle="modal" data-target="#objectionModal">이의신청</button>
			</div>
		</div>

		<!-- 상세 테이블 -->
		<div class="card detail-card">
			<div class="card-body p-0">
				<table class="table table-bordered mb-0 detail-table">
					<colgroup>
						<col style="width: 140px">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th>업무코드</th>
							<td>${work.wcode}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${work.wtitle}</td>
						</tr>
						<tr>
							<th>상세내용</th>
							<td class="content-cell"><c:out value="${work.wcontent}" escapeXml="false" /></td>
						</tr>
						<tr>
							<th>담당자</th>
							<td>${work.eno}</td>
						</tr>
						<tr>
							<th>기한</th>
							<td><fmt:formatDate value="${work.wend}" pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<th>상태</th>
							<td>${work.wstatus}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<input type="hidden" id="wcode" value="${work.wcode}">
	</div>

	<!-- ================= 이의신청 모달 ================ -->
	<div class="modal fade" id="objectionModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-md" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">이의신청</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="닫기">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="objectionForm" action="<%=ctx%>/work/objection" method="post">
					<div class="modal-body">
						<input type="hidden" name="wcode" value="${work.wcode}">

						<div class="form-group">
							<label for="type">이의유형</label>
							<select class="form-control" id="type" name="type" required>
								<option value="">선택하세요</option>
								<option value="업무관련">업무관련</option>
								<option value="일정관련">일정관련</option>
								<option value="기타">기타</option>
							</select>
						</div>

						<div class="form-group">
							<label for="content">이의내용</label>
							<textarea class="form-control" id="content" name="content" rows="4" required></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">이의신청</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- ================================================= -->

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="<%=ctx%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

	<script>
	// JSP 컨텍스트 경로를 JS 변수에 전달
	var ctx = "<%=ctx%>";

	// ✅ 승인 버튼 처리
	$("#btnApprove").on("click", function(){
	    $.post(ctx + "/work/approve", { wcode: $("#wcode").val() })
	     .done(function(res){
	         if(res === "OK"){
	             Swal.fire({
	                 icon: "success",
	                 title: "승인되었습니다.",
	                 confirmButtonText: "확인"
	             }).then(() => {
	                 opener.location.reload(); // 부모창 새로고침
	                 window.close(); // 팝업 닫기
	             });
	         }
	     });
	});

	// ✅이의신청 처리 (모달 내부 폼 AJAX)
	$("#objectionForm").on("submit", function(e){
	    e.preventDefault();
	    $.post(ctx + "/work/objection", $(this).serialize())
	     .done(function(res){
	         if(res === "OK"){
	             Swal.fire({
	                 icon: "success",
	                 title: "이의신청이 등록되었습니다.",
	                 confirmButtonText: "확인"
	             }).then(() => {
	                 opener.location.reload();
	                 window.close();
	             });
	         }
	     });
	});
	</script>
</body>
</html>
