<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>회원가입</title>

	<!-- 구글 폰트 및 아이콘 -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">

	<!-- 스타일 및 라이브러리 -->
	
	<link rel="stylesheet" href="/motiveOn/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
	<link rel="stylesheet" href="/motiveOn/resources/bootstrap/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/motiveOn/resources/bootstrap/plugins/summernote/summernote-bs4.min.css">
	<link rel="stylesheet" href="/motiveOn/resources/css/profileRegist.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">

	<script src="/motiveOn/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

	
</head>

<body class="sidebar-mini" style="min-height: 100vh;">
	<div class="login-container">
		
		<div class="login-overlay"></div>

				
                <div class="form-box">
                <h4>회원정보</h4>
                <hr style= "margin-bottom: 20px;border-top: 1px solid rgba(0, 0, 0, 0.2);z-index: 2;">
                    <form>
                        <!-- 이름 -->
                        <div class="form-group">
                            <label class="form-label"><span class="text-danger">*</span> 이름 </label>
                            <input type="text" class="form-control">
                            <div class="form-text">사용 가능합니다.</div>
                        </div>

                        <!-- 비밀번호 -->
                        <div class="form-group">
                            <label class="form-label"><span class="text-danger">*</span> 비밀번호 </label>
                            <input type="password" class="form-control">
                            <div class="form-text">사용 가능합니다.</div>
                        </div>

                        <!-- 비밀번호 확인 -->
                        <div class="form-group">
                            <label class="form-label"><span class="text-danger">*</span> 비밀번호 확인 </label>
                            <input type="password" class="form-control">
                            <div class="form-text">일치합니다.</div>
                        </div>

                        <!-- 이메일 + 인증 버튼 -->
                        <div class="form-group row">
                            <div class="col-9 pr-1">
                                <label class="form-label"><span class="text-danger">*</span> E-MAIL </label>
                                <input type="email" class="form-control">
                            </div>
                            <div class="col-3 pl-1 d-flex align-items-end form-controller">
                                <button class="btn btn-secondary btn-block btn-auth" >E-MAIL 인증</button>
                            </div>
                        </div>

                        <!-- 이메일 인증코드 -->
                        <div class="form-group">
                            <label class="form-label"><span class="text-danger">*</span> 인증코드 </label>
                            <input type="text" class="form-control" placeholder="인증코드를 입력하세요.">
                            <div class="form-text">사용 가능합니다.</div>
                        </div>

                        <!-- 전화번호 + 인증 버튼 -->
                        <div class="form-group row">
                            <div class="col-9 pr-1">
                                <label class="form-label"><span class="text-danger">*</span> 전화번호 </label>
                                <input type="text" class="form-control">
                            </div>
                            <div class="col-3 pl-1 d-flex align-items-end  form-controller">
                                <button class="btn btn-secondary btn-block btn-auth">전화번호 인증</button>
                            </div>
                        </div>

                        <!-- 전화 인증코드 -->
                        <div class="form-group">
                            <label class="form-label"><span class="text-danger">*</span> 인증코드 </label>
                            <input type="text" class="form-control" placeholder="인증코드를 입력하세요.">
                            <div class="form-text">사용 가능합니다.</div>
                        </div>

                        <!-- 버튼 영역 -->
                        <div class="form-group btn-wrap mt-4">
                            <button type="submit" class="btn btn-primary" style="background-color: #52586B;border-color: #52586B;">가입하기</button>
                            <button type="reset" class="btn btn-secondary" style="background-color: #E8E8E8; color: #52586B;">취소</button>
                        </div>
                    </form>
                </div>
            </div>
	</div>

	</div>

	<!-- 필수 스크립트 -->
	<script src="/motiveOn/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	<script src="/motiveOn/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/motiveOn/resources/bootstrap/dist/js/adminlte.min.js"></script>
	<script src="/motiveOn/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
	<script src="/motiveOn/resources/js/common.js"></script>
</body>
</html>