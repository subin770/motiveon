<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/ehr.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style>
.list-group-item {
	padding: 6px 0.75rem;
}


.table th, .table td {
	padding: 4px 0.75rem;
}

.card-header {
	padding: 4px 1.25rem;
}

.card-body {
	padding: 0.75rem 1.25rem;
}

.small-box {
	margin: 0;
}

.table {
	margin: 0;
}


/* 		.page-link { */
/* 		    line-height: 1; */
/* 		    color: #0c4b8d; */
/* 		    background-color: #fff; */
/* 		    border: 1px solid #0c4b8d; */
/* 		} */
/* 		.page-item.active .page-link { */
/* 		    z-index: 3; */
/* 		    color: #fff; */
/* 		    background-color: #0c4b8d; */
/* 		    border-color: #0c4b8d; */
/* 		} */
/**/
</style>
</head>
<body>
	<!-- <c:set var="today" value="<%=new java.util.Date()%>" /> -->
	<div class="wrapper">
		<!-- 	<div class="preloader flex-column justify-content-center align-items-center" style="max-width:1130px; height: 100vh; margin-left:220px;"> -->
		<%-- 		<img class="animation__shake" src="<%=request.getContextPath() %>/resources/bootstrap/dist/img/AdminLTELogo.png" width="60" height="60"> --%>
		<!-- 	</div> -->
		<!-- 	<h3 class="title">내 근태관리</h3> -->
		<!-- 	<div style="display: inline; margin-left: 10px; margin-top: 25px;"> 	 -->
		<%-- 		<span  class="text-muted"  style="">근태 > 부서 근태관리 > ${loginUser.dname }</span> --%>
		<!-- 	</div> -->
		<section class="content-header p-0">
			<div class="container-fluid">
				<div class="row md-2">
					<div>
						<h3 class="font-weight-bold"
							style="padding-left: 10px; margin-left: 20px; margin-top: 10px; font-size: 22px;">근태
							> 내 근태관리</h3>
					</div>
				</div>
			</div>
		</section>

		<!-- Main content -->
		<section class="top">
			<!-- 		<div class="card"> -->
			<div class="row justify-content-center">
				<div class="card-body" style="text-align: left; padding: 0; ">
					<div class="col-sm-11" style="margin: 0 auto;">
						<div class="info-box card-navy"
							style="padding: 0px; margin-bottom: 0px; background-color: #7A94AF; color: #F8F7F6;">
							<span class="info-box-icon" style="margin-left: 10px; width: 60; height: 60;">
								<img width="60px;" height="60px;" class="ml-2 rounded-circle"
								alt="img"
								src="<%=request.getContextPath()%>/resources/images/picture3.jpg">
								<!-- 하드코딩 -->
							</span>
							<div class="info-box-content" >
								<div class="row text-center">
									<div class="col-md-2">
										<span class="info-box-text text-left"><b>김민준&nbsp;차장</b></span> 
										<!-- 하드코딩 -->
										<span class="info-box-text text-left"
											style="font-size: 0.8em;">인사관리팀</span>
										<!-- 하드코딩-->
									</div>
									<div class="col-md-2">
										<span class="info-box-text">이번 달 근로시간</span> <span
											class="info-box-number mHrTime">시간</span>
									</div>
									<div class="col-md-2">
										<span class="info-box-text">이번 달 기본근무</span> <span
											class="info-box-number mStdTime">시간</span>
									</div>
									<div class="col-md-2">
										<span class="info-box-text">이번 달 연장근무</span> <span
											class="info-box-number mOverTime">시간</span>
									</div>
									<div class="col-md-2">
										<span class="info-box-text">이번 달 지각</span> <span
											class="info-box-number mTardy">건</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- </div> -->
		</section>
		<section class="month" style="margin-bottom: 25px;">
			<div class="row text-center" style="display: flex; ">
				<div class="col-md-12" style="font-size: 1.5em; padding-top: 10px;">
					<a class="btn btn-default btn-sm"
						href="javascript:changeMonth(-1);"> <i
						class="fas fa-angle-left"></i></a> <span id="month">&nbsp;&nbsp;<fmt:formatDate
							value="${standardDate }" pattern="yyyy-MM" />&nbsp;&nbsp;
					</span> <a class="btn btn-default btn-sm"
						href="javascript:changeMonth(1);"> <i
						class="fas fa-angle-right"></i></a> <a class=""
						style="font-size: 0.6em;" href="javascript:location.reload()">Today</a>			
				</div>
				
			</div>
		</section>
		<div class="row justify-content-center">
			<div class="col-sm-11">
				<table id="example1"
					class="table table-bordered table-striped dataTable dtr-inline monthTable-target"
					 style="width: 100%; margin: 0; padding: 0;"
					aria-describedby="example1_info"
					>								
					<thead>
					<tr>
						<th class="sorting" style="width: 15%" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column ascending">
						날짜</th>
						<th class="sorting" style="width: 23%" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">
						출근시간</th>
						<th class="sorting sorting_asc" style="width: 23%" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column descending" aria-sort="ascending">
						퇴근시간</th>
						<th class="sorting" tabindex="0" style="width: 23%" aria-controls="example1" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">
						총 근무시간</th>
						<th class="sorting" tabindex="0" style="width: 16%" aria-controls="example1" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">
						상태</th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<%@ include file="./hr_js.jsp"%>

</body>