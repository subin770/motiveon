<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<body>
	<section class="content-header">
		<div class="container-fluid">
			<div class="row md-2">
				<div class="col-sm-6">
					<h1>상세보기</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item" style="color: blue;">공지사항</li>
						<li class="breadcrumb-item active">상세보기</li>
					</ol>
				</div>
			</div>
		</div>
	</section>


	<!-- Main content -->
	<section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title">상세보기</h3>
						<div class="card-tools">
							<button type="button" id="modifyBtn" class="btn btn-warning"
								onclick="modify();">수 정</button>
							<button type="button" id="removeBtn" class="btn btn-danger"
								onclick="remove();">삭 제</button>
							<button type="button" id="listBtn" class="btn btn-primary"
								onclick="CloseWindow();">닫 기</button>
						</div>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="form-group col-sm-12">
								<label for="title">제 목</label> <span class="form-control"
									id="title">${popup.title}</span>
							</div>
						</div>
						<div class="row">

							<div class="form-group col-sm-4">
								<label for="regDate">마감일</label> <span class="form-control"
									id="deadLine"> <fmt:formatDate
										value="${popup.deadLine}" pattern="yyyy-MM-dd" />
								</span>

							</div>

							


						</div>
						<div class="form-group col-sm-12">
							<label for="content">내 용</label>
							<div id="content">${popup.content}</div>
						</div>
					</div>
				</div>
				<!-- end card -->
			</div>
			<!-- end col-md-12 -->
		</div>
		<!-- end row  -->
	</section>





	<script>
		function modify() {
			location.href = "modify?popNo=${popup.popNo}";
		}

		function remove() {
			location.href = "remove?popNo=${popup.popNo}";
		}

	</script>
</body>



