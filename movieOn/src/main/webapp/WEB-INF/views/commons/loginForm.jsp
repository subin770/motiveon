<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>MotiveOn</title>
	
	
	<!-- Google Font: Source Sans Pro -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
	<!-- Font Awesome Icons -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/motiveOn/resources/css/loginMain.css">
</head>    
    
<body class="hold-transition login-page">
	<body class="sidebar-mini">
  <div class="hold-transition login-page">
    <img src="../resources/images/빌딩.jpg" alt="배경" class="login-bg">
    <div class="login-overlay"></div>

    <div class="login-box card">
      <div class="card card-body login-card-body">
        <h4 class="modal-title text-center">Sign in</h4>
        <hr>

        <form action="login/post" method="post" name="login" id="login">
          <input type="hidden" name="retUrl" value="">

          <div class="form-group has-feedback">
            <input type="text" class="form-control" name="eno" id="eno" placeholder="사번을 입력하세요.">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>

          <div class="form-group has-feedback">
            <input type="password" class="form-control" name="pwd" placeholder="비밀번호를 입력하세요.">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>

          <div class="col-sm-8">
            <a href="#" data-toggle="modal" data-target="#modal-pdefault">비밀번호를 잊으셨나요?</a>
          </div>

          <div class="social-auth-links text-center mb-3">
            <button type="submit" class="btn btn-block btn-dark">로그인</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- 비밀번호 찾기 모달 -->
  <div class="modal fade" id="modal-pdefault" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">비밀번호 찾기</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <input type="text" class="form-control" placeholder="사번을 입력하세요.">
          </div>
          <div class="form-group">
            <div class="input-group">
              <input type="text" class="form-control" placeholder="이메일을 입력하세요.">
              <span class="input-group-append">
                <button type="button" class="btn btn-info btn-sm">인증</button>
              </span>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-between">
          <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
          <button type="button" class="btn btn-info">확인</button>
        </div>
      </div>
    </div>
  </div>
	
 <!-- jQuery -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/dist/js/adminlte.min.js"></script>
</body>