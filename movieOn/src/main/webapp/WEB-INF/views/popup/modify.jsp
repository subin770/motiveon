<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
	<!-- summernote -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap/plugins/summernote/summernote-bs4.min.css">

	<!-- Summernote -->
	<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
</head>

<body>
<section class="content-header">
	  	<div class="container-fluid">
	  		<div class="row md-2">
	  			<div class="col-sm-6">
	  				<h1>수정하기</h1>  				
	  			</div>
	  			<div class="col-sm-6">
	  				<ol class="breadcrumb float-sm-right">
			        <li class="breadcrumb-item" style="color: blue;">
				        	공지사항
			        </li>
			        <li class="breadcrumb-item active">
			        	수정하기
			        </li>		        
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
						<h3 class="card-title">공지 수정</h3>
						<div class="card-tools">
							<div class="float-right">
								<button type="button" id="toggleEnabledBtn"  
								class="btn ${popup.enabled == 1 ? 'btn-success' : 'btn-secondary'}"
								onclick="toggleEnabled();">${popup.enabled == 1 ? '활성' : '비활성'}
								</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-warning" id="modifyBtn" onclick="modify_go();">수 정</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-default " id="cancelBtn" onclick="history.go(-1);">취 소</button>
							</div>
						</div>
					</div><!--end card-header  -->
					<div class="card-body">
						<form role="form" method="post" action="modify" name="modifyForm" onsubmit="return false;">
							<input type="hidden" name="popNo" value="${popup.popNo }" />
							<input type="hidden" id="enabled" name="enabled" value="${popup.enabled}" />
							
							
							<div class="form-group">
								<label for="title">제 목</label> 
								<input type="text" id="title" name='title' class="form-control" value="${popup.title }">
							</div>
							
							
							
							<div class="form-group">
								<label for="content">내 용</label>		
								<textarea class="form-control" name="content" id="content" rows="3"
									placeholder="500자 내외로 작성하세요.">${fn:escapeXml(popup.content) }</textarea>						
							</div>
						</form>
					</div><!--end card-body  -->
					
				</div><!-- end card -->				
			</div><!-- end col-md-12 -->
		</div><!-- end row -->
    </section>

<script>
	Summernote_go($("textarea#content"),"<%=request.getContextPath() %>") ;
</script>

<script>
function modify_go(){
	let form = document.forms.modifyForm;
	form.action="modify";
	form.method="post";
	form.submit();
}


function toggleEnabled() {
    const btn = document.getElementById('toggleEnabledBtn');
    const hiddenInput = document.getElementById('enabled');
    const isEnabled = btn.textContent.trim() === '활성';

    if (isEnabled) {
        btn.textContent = '비활성';
        btn.classList.remove('btn-success');
        btn.classList.add('btn-secondary');
        hiddenInput.value = '0';  // 비활성 = 0
    } else {
        btn.textContent = '활성';
        btn.classList.remove('btn-secondary');
        btn.classList.add('btn-success');
        hiddenInput.value = '1';  // 활성 = 1
    }
}

</script>
</body>




