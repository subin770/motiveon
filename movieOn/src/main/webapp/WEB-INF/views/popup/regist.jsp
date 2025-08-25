<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<!-- summernote -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.css">
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
</head>

<body>

	<!-- Main content -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row md-2">
				<div class="col-sm-6">
					<h1>공지등록</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item" style="color: blue;">공지사항</li>
						<li class="breadcrumb-item active">등록</li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<!-- Main content -->
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 960px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">공지등록</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn"
								onclick="regist_go();">등 록</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn"
								onclick="CloseWindow();"
								style="background-color: red; color: white; border-color: red;">취
								소</button>
						</div>
					</div>
					<!--end card-header  -->
					<div class="card-body pad">
						<form role="form" method="post" action="regist.do"
							name="registForm">
							<div class="form-group">
								<label for="title">제 목</label> <input type="text" id="title"
									title="제목" name='title' class="form-control notNull"
									placeholder="제목을 쓰세요">
							</div>

							<div class="form-group row">

								<label for="writer" style="left-border: 20px;">작성자</label>
								<div class="col-sm-6 row">

									<div class="col-sm-1">
										<span class="person-info" data-id="${loginUser.eno }"></span>
									</div>
									<div class="col-sm-10">${loginUser.name }</div>

								</div>

								<input type="hidden" id="writer" title="작성자" readonly
									name="writer" class="form-control notNull"
									value="${loginUser.eno }">
							</div>

							<!-- 여기 마감일 추가 -->
							<div class="form-group">
								<label for="deadLine">마감일</label> <input type="date"
									id="deadLine" name="deadLine" class="form-control notNull"
									title="마감일">
							</div>

							<div class="form-group">
								<label for="content">내 용</label>
								<textarea class="textarea" name="content" id="content" rows="15"
									cols="85" placeholder="1000자 내외로 작성하세요."
									style="border: 1px solid #ced4da;"></textarea>
							</div>

							<div class="form-group">
								<div class="card card-outline card-success"
									style="border-top: 0px">
									<div class="card-header">
										<h5 style="display: inline; line-height: 40px;">첨부파일</h5>

									</div>
									<div class="card-footer fileInput">
										<input type="file"
											style="width: 100%; border: 1px solid #ced4da; border-radius: 4px; padding: 6px; font-size: 14px; background-color: #f8f9fa;" />
									</div>
								</div>
							</div>

						</form>
					</div>
					<!--end card-body  -->
					<div class="card-footer" style="display: none"></div>
					<!--end card-footer  -->
				</div>
				<!-- end card -->
			</div>
			<!-- end col-md-12 -->
		</div>
		<!-- end row -->
	</section>



	<script>
function regist_go(){
	var form = document.forms.registForm;
	
	var inputNotNull = document.querySelectorAll(".notNull");
	for(var input of inputNotNull){
		if(!input.value){
			alert(input.getAttribute("title")+"은 필수입니다.");
			input.focus();
			return;
		}
	}	
	
	form.action="regist";
	form.method="post";
	form.submit();
}
</script>

	<script>
MemberPictureBackground("<%=request.getContextPath()%>");

$(".person-info").css({
	"display":"block",
	"width":"30px", 
	"height":"30px",
	"border-radius":"10px"
});

Summernote_go($("textarea#content"),'<%=request.getContextPath()%>');
</script>

	<script>
var dataNum=0;

function addFile_go(){
	//alert("!!!!");
	if($('input[name="uploadFile"]').length >=1){
		alert("파일추가는 1개만 가능합니다.");
		return;
	}
	
	

	div.append(input).append(button);
	$('.fileInput').append(div);
	
	dataNum++;
}

function remove_go(num){
	$('div[data-no="'+num+'"]').remove();
}

$('.fileInput').on('change',"input[name='uploadFile']",function(event){
	if(this.files[0].size > 1024*1024*40){
		alert("첨부파일크기는 40MB 이하만 가능합니다.");
		this.value="";				
	}
});

</script>
</body>