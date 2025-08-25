<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>

	<!-- Main content -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row md-2">
				<div class="col-sm-6">
					<h1>부서 등록</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item" style="color: blue;">부서관리</li>
						<li class="breadcrumb-item active">등록</li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-6" style="max-width: 600px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">부서 등록</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary"
								onclick="addDepartment();">등 록</button>
							&nbsp;&nbsp;
							<button type="button" class="btn btn-warning"
								onclick="CloseWindow();" style="background-color: red; color: #fff; border-color: red;">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="<%=request.getContextPath()%>/department/regist" name="registForm">

							<div class="form-group row">
								<label class="col-sm-3 col-form-label" for="dno">부서 코드</label>
								<div class="col-sm-6">
									<input type="text" id="dno" name="dno"
										class="form-control notNull" placeholder="부서 코드" title="부서 코드">
								</div>
								<div class="col-sm-3">
									<button type="button" class="btn btn-secondary"
										onclick="generateDeptCode();">부서코드 생성</button>
								</div>
							</div>

							<div class="form-group">
								<label for="name">부서명</label> 
								<input type="text" id="name" name="name" 
									class="form-control notNull" placeholder="부서명" title="부서명">
							</div>

							<div class="form-group">
								<label for="memberCount">부서원 수</label> 
								<input type="number" id="memberCount" name="memberCount" 
									class="form-control" placeholder="부서원 수" min="0">
							</div>

							<!-- 생성일 -->
							<div class="form-group">
								<label for="createDate">생성일</label> 
								<input type="date" id="createDate" name="createDate" 
									class="form-control notNull" title="생성일">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>
	window.onload = function(){
	    // 오늘 날짜 yyyy-MM-dd 형식으로 세팅
	    var today = new Date();
	    var yyyy = today.getFullYear();
	    var mm = String(today.getMonth()+1).padStart(2,'0');
	    var dd = String(today.getDate()).padStart(2,'0');
	    document.getElementById("createDate").value = yyyy + "-" + mm + "-" + dd;
	};

	function addDepartment(){
	    var form = document.forms.registForm;
	    var inputNotNull = document.querySelectorAll(".notNull");
	    for(var input of inputNotNull){
	        if(!input.value){
	            alert(input.getAttribute("title") + "은 필수입니다.");
	            input.focus();
	            return;
	        }
	    }
	    form.submit();   // action은 JSP에서 이미 설정했으므로 변경 불필요
	}

	function generateDeptCode(){
	    // 간단한 랜덤 코드 예시
	    var code = Math.floor(Math.random()*900+100); // 100~999
	    document.getElementById("dno").value = code;
	}
	</script>