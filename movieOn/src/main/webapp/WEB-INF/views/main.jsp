<%@page import="com.motiveon.dto.EmployeeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>MotiveOn</title>

  <!-- AdminLTE 기본 CSS -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap/dist/css/adminlte.min.css">

  <!-- ===== Clean AdminLTE (flat & neat) : AdminLTE 뒤에 로드 ===== -->
  <style>
  :root{
    --primary:#3A8DFE;
    --line: rgba(0,0,0,.08);
    --text:#2B2F3A;
    --muted:#8A94A6;
    --radius:12px;
  }
  /* 그림자 전부 제거 (카드/버튼/모달/사이드바/헤더 등) */
  [class*="elevation-"], .card, .dropdown-menu, .modal-content,
  .main-header, .main-sidebar, .brand-link, .main-footer,
  .control-sidebar, .btn, .form-control, .input-group-text,
  .pagination .page-link { box-shadow:none !important; }

  /* 헤더/푸터/브랜드 하단선 */
  .navbar-white { border-bottom:1px solid var(--line) !important; }
  .main-footer  { border-top:1px solid var(--line) !important; }
  .brand-link   { border-bottom:1px solid var(--line) !important; }

  /* 사이드바–본문 구분선 (한 줄만 사용) */
  .main-sidebar   { border-right:1px solid var(--line); }
  .content-wrapper{ background:#fff; } /* 선은 사이드바에만 */


  /* 유저 패널 컴팩트 */
  .user-panel .image img{ width:32px; height:32px; }
  .user-panel .row{ align-items:center; gap:8px; }
  .user-panel a.d-block{ font-weight:600; }

  /* 사이드바 검색 */
  .form-control-sidebar,
  .input-group .btn-sidebar{ border:1px solid var(--line) !important; }
  .form-control-sidebar{ border-radius:8px 0 0 8px; }
  .btn-sidebar{ border-radius:0 8px 8px 0; }

  /* 사이드바 메뉴 – 플랫 & 간격 */


  /* 버튼/인풋 – 플랫 */
  .btn, .form-control{ border:1px solid var(--line); border-radius:8px; }
  .btn-primary{ background:var(--primary); border-color:var(--primary); }
  .btn-primary:focus{ outline:2px solid rgba(58,141,254,.3); outline-offset:0; }

  /* 표 공통 톤(iframe 안 페이지에도 쓰면 동일 룩) */
  .table{ border-color:var(--line); }
  .table thead th{ border-bottom:1px solid var(--line); color:#5a6272; font-weight:600; }
  .table td{ vertical-align:middle; }

  /* 페이지네이션 – 라운드 */
  .pagination .page-link{ border:1px solid var(--line); border-radius:999px; }
  .pagination .page-item.active .page-link{ background:var(--primary); border-color:var(--primary); }

  /* 컨트롤 사이드바 – 선만 */
  .control-sidebar{ box-shadow:none !important; border-left:1px solid var(--line); }

  /* Iframe – 배경/그림자 없음 */
  iframe#mainContentFrame{ background:transparent; padding:0; width:100%; height:85vh; border:0; }
  
/* === Sidebar active: text-only (no bg / no shadow) === */

/* 1) light 사이드바의 기본/활성/열림 상태 모두 배경 제거 */
.sidebar-light-primary .nav-sidebar > .nav-item > .nav-link,
.sidebar-light-primary .nav-sidebar > .nav-item.menu-open > .nav-link,
.sidebar-light-primary .nav-sidebar > .nav-item > .nav-link.active {
  background: transparent !important;
  box-shadow: none !important;
  border: 0 !important;
}

/* 2) Bootstrap nav-pills 기본 active 배경도 무력화 */
.nav-pills .nav-link.active,
.nav-pills .show > .nav-link {
  background: transparent !important;
  box-shadow: none !important;
}

/* 3) hover에도 배경 없이 텍스트만 */
.nav-sidebar > .nav-item > .nav-link:hover {
  background: transparent !important;
  color: #111 !important;
}

/* 4) 활성 항목 = 진한 검정 + 굵게, 아이콘도 동일 톤 */
.nav-sidebar .nav-link.active,
.nav-sidebar .menu-open > a.nav-link {
  color: #111 !important;
  font-weight: 700;
}
.nav-sidebar .nav-link.active .nav-icon,
.nav-sidebar .menu-open > a.nav-link .nav-icon {
  color: #111 !important;
}

/* (선택) pill 느낌이 남았다면 둥근 모서리도 제거 */
.nav-sidebar > .nav-item > .nav-link { border-radius: 0 !important; margin: 2px 0 !important; }


/* === Sidebar user panel: vertical layout (photo on top) === */
.main-sidebar .user-panel{
  display: block !important;               /* 가로 d-flex 강제 해제 */
  text-align: center;
  padding: 12px 10px;
}
.main-sidebar .user-panel .image{
  float: none;                              /* 혹시 남아있을 float 제거 */
  text-align: center;
  margin: 0;
}
.main-sidebar .user-panel .image img{
  width: 64px; height: 64px;                /* 보기 좋은 크기 */
  object-fit: cover;
}

/* 오른쪽 영역으로 밀던 인라인 margin 제거 + 세로 배치 */
.main-sidebar .user-panel > div:nth-child(2){
  margin: 8px 0 0 0 !important;
  text-align: center;
}

/* 이름/버튼/연락처 정돈 */
.main-sidebar .user-panel a.d-block{
  display: block;
  margin-top: 4px;
  font-weight: 700;
  color: #111;                              /* 진한 글씨 */
}
.main-sidebar .user-panel .row{
  display: flex; justify-content: center; align-items: center;
  gap: 8px; margin: 6px 0 4px;
  flex-wrap: wrap;
}
.main-sidebar .user-panel .btn{
  padding: 4px 10px; border-radius: 8px;    /* 작게, 둥글게 */
}

/* 전화/이메일은 줄바꿈 허용해서 '글자 짤림' 방지 */
.main-sidebar .user-panel a[href^="tel:"],
.main-sidebar .user-panel a[href^="mailto:"]{
  display: block;
  font-size: 12px;
  color: #6b7280;
  line-height: 1.4;
  word-break: break-all;                    /* 긴 이메일도 안전 */
}

  </style>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>

      <!-- 상단 GNB: 권한/메뉴코드에 따라 노출 -->
      <c:forEach items="${menuList}" var="menu">
        <c:choose>
          <c:when test="${ (loginUser.authority eq 'ROLE_ADMIN') 
                        and (menu.mcode.indexOf('M06') eq 0 
                          or menu.mcode.indexOf('M07') eq 0
                          or menu.mcode.indexOf('M08') eq 0) }">
            <li class="nav-item d-none d-sm-inline-block">
              <a href="javascript:subMenu_go('${menu.mcode}');go_page('<%=request.getContextPath()%>${menu.murl}','${menu.mcode}');" 
                 class="nav-link">${menu.mname}</a>
            </li>
          </c:when>
          <c:when test="${loginUser.authority ne 'ROLE_ADMIN' 
                         and not empty menu.mcode
                         and (fn:startsWith(menu.mcode,'M00') 
                              or fn:startsWith(menu.mcode,'M01') 
                              or fn:startsWith(menu.mcode,'M02') 
                              or fn:startsWith(menu.mcode,'M03') 
                              or fn:startsWith(menu.mcode,'M04') 
                              or fn:startsWith(menu.mcode,'M05'))}">
            <li class="nav-item d-none d-sm-inline-block">
              <a href="javascript:subMenu_go('${menu.mcode}');go_page('<%=request.getContextPath()%>${menu.murl}','${menu.mcode}');" 
                 class="nav-link">${menu.mname}</a>
            </li>
          </c:when>
        </c:choose>
      </c:forEach>
    </ul>

    <ul class="navbar-nav ml-auto">
      <!-- (필요시) 검색/알림 등 -->
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar -->
  <aside class="main-sidebar sidebar-light-primary elevation-0">
    <!-- Brand -->
    <a href="index3.html" class="brand-link">
      <img src="<%=request.getContextPath() %>/resources/bootstrap/dist/img/AdminLTELogo.png"
           alt="AdminLTE Logo" class="brand-image img-circle elevation-0" style="opacity:.8">
      <span class="brand-text font-weight-light">MotiveOn</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- User panel -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="<%=request.getContextPath() %>/employyee/getPicture?id=${loginUser.eno}" class="img-circle elevation-0" alt="User Image">
        </div>
        <div style="margin-left:20px;">
          <div class="row">
            <a href="javascript:OpenWindow('employee/detail?id=${loginUser.eno}','회원정보',700,800);" class="d-block">${loginUser.name }</a>
            &nbsp;&nbsp;
            <button class="btn btn-xs btn-primary col-xs-4" type="button" 
                    onclick="location.href='<%=request.getContextPath()%>/commons/logout';">LOGOUT</button>
          </div>
          <a href="tel:${loginUser.phone}">tel : ${loginUser.phone}</a><br/>
          <a href="mailto:${loginUser.email}">email : ${loginUser.email}</a>
        </div>
      </div>

      <!-- Sidebar search -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Dynamic SubMenu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column subMenuList" data-widget="treeview" role="menu" data-accordion="false">
        </ul>
      </nav>
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper -->
  <div class="content-wrapper">
    <section class="content pt-3">
      <div class="container-fluid px-3">
        <iframe name="ifr" id="mainContentFrame"></iframe>
      </div>
    </section>
  </div>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-light">
    <div class="p-3">
      <h5>Title</h5>
      <p>Sidebar content</p>
    </div>
  </aside>

  <!-- Main Footer -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-inline">Anything you want</div>
    <strong>Copyright &copy; 2014-2025 <a href="https://adminlte.io">motiveOn</a>.</strong> All rights reserved.
  </footer>
</div>
<!-- /.wrapper -->

<!-- Scripts -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/bootstrap/dist/js/adminlte.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.8/handlebars.min.js"></script>

<!-- Handlebars template: SubMenu -->
<script id="subMenu-list-template" type="text/x-handlebars-template">
{{#each .}}
<li class="nav-item subMenu">
  <a href="javascript:go_page('<%=request.getContextPath()%>{{murl}}','{{mcode}}');" class="nav-link">
    <i class="{{micon}} nav-icon"></i><p>{{mname}}</p>
  </a>
</li>
{{/each}}
</script>

<script>
  var sub_func = Handlebars.compile($("#subMenu-list-template").html());

  // 서브메뉴 로드
  function subMenu_go(mcode){
    if(!mcode || mcode === "M000000") {
      $('.subMenuList').html("");
      return;
    }
    $.ajax({
      url: "menu/subMenu?mcode=" + mcode,
      method: "get",
      success: function(data){
        if (data && data.length > 0) {
          $('.subMenuList').html(sub_func(data));
          // 첫 항목 활성화 표시
          $('.subMenuList .nav-link').first().addClass('active');
        } else {
          $('.subMenuList').html("");
        }
      },
      error: function(){
        alert("서버장애가 발생했습니다.");
      }
    });
  }

  // 페이지 이동 + 주소 표시
  function go_page(url, mcode){
    $('iframe[name="ifr"]').attr("src", url);

    var renewURL = location.href;
    if(renewURL.indexOf("index") > -1){
      renewURL = renewURL.substring(0, renewURL.indexOf("index") + 5);
    }
    if(mcode && mcode !== 'M000000'){
      renewURL += "?mcode=" + mcode;
    }
    history.pushState(mcode, null, renewURL);
  }

  // 서브메뉴 클릭 시 active 토글
  $(document).on('click', '.subMenuList .nav-link', function(){
    $('.subMenuList .nav-link').removeClass('active');
    $(this).addClass('active');
  });

  // 접힘 상태 유지 (옵션)
  document.addEventListener('DOMContentLoaded', function(){
    const body = document.body;
    if (localStorage.getItem('sidebar-collapsed') === '1') body.classList.add('sidebar-collapse');
    document.querySelectorAll('[data-widget="pushmenu"]').forEach(btn=>{
      btn.addEventListener('click', ()=>{
        setTimeout(()=> {
          const collapsed = body.classList.contains('sidebar-collapse');
          localStorage.setItem('sidebar-collapsed', collapsed ? '1' : '0');
        }, 250);
      });
    });

    // 권한별 초기 페이지 로드
    var isAdmin = "${loginUser.authority}" === "ROLE_ADMIN";
    var initUrl  = isAdmin ? '<%=request.getContextPath()%>/popup/list' : '<%=request.getContextPath()%>/user/home';
    var initCode = isAdmin ? "M060000" : "M000000";
    go_page(initUrl, initCode);
  });
</script>
</body>
</html>