<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상세보기</title>

  <!-- AdminLTE / Bootstrap -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">

  <style>
    body { padding: 20px; background: #fff; }
    .detail-table th { width: 20%; background: #f9f9f9; }
    .btn-group-right { float: right; }
  </style>
</head>
<body>

  <!-- 상단 영역 -->
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4>상세보기</h4>
    <div class="btn-group btn-group-right">
      <!-- ✅ 승인자/담당자 -->
      <c:if test="${role eq 'approver'}">
        <button class="btn btn-success btn-sm" id="btnApprove">승인</button>
        <button class="btn btn-danger btn-sm" id="btnReject">반려</button>
        <button class="btn btn-info btn-sm" id="btnCooperate">협업요청</button>
        <button class="btn btn-secondary btn-sm" id="btnDelegate">대리요청</button>
      </c:if>

      <!-- ✅ 요청자 -->
      <c:if test="${role eq 'requester'}">
        <!-- 진행 전 -->
        <c:if test="${status eq '대기중'}">
          <button class="btn btn-warning btn-sm" id="btnModify">수정</button>
          <button class="btn btn-danger btn-sm" id="btnDelete">삭제</button>
        </c:if>
        <!-- 결과 확인 후 -->
        <c:if test="${status eq '승인' or status eq '반려'}">
          <button class="btn btn-outline-danger btn-sm" id="btnObjection">이의신청</button>
        </c:if>
      </c:if>
    </div>
  </div>

  <!-- 상세 정보 테이블 -->
  <table class="table table-bordered detail-table">
    <tr>
      <th>등록자</th>
      <td>${work.requesterName}</td>
    </tr>
    <tr>
      <th>제목</th>
      <td>${work.wtitle}</td>
    </tr>
    <tr>
      <th>담당자</th>
      <td>
        
        ${work.managerName}
      </td>
    </tr>
    <tr>
      <th>기한</th>
      <td>${work.wend}</td>
    </tr>
    <tr>
      <th>상태</th>
      <td>${work.wstatus}</td>
    </tr>
    <tr>
      <th>상세내용</th>
      <td>${work.wcontent}</td>
    </tr>
  </table>

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script>
    // 승인
    $("#btnApprove").on("click", function(){
      $.post("<c:url value='/work/approve'/>", { wcode: "${work.wcode}" }, function(){
        alert("업무가 승인되었습니다.");
        window.opener.location.reload();
        window.close();
      });
    });

    // 반려
    $("#btnReject").on("click", function(){
      $.post("<c:url value='/work/reject'/>", { wcode: "${work.wcode}" }, function(){
        alert("업무가 반려되었습니다.");
        window.opener.location.reload();
        window.close();
      });
    });

    // 협업요청
    $("#btnCooperate").on("click", function(){
      $.post("<c:url value='/work/cooperate'/>", { wcode: "${work.wcode}" }, function(){
        alert("협업 요청이 완료되었습니다.");
        window.opener.location.reload();
        window.close();
      });
    });

    // 대리요청
    $("#btnDelegate").on("click", function(){
      $.post("<c:url value='/work/delegate'/>", { wcode: "${work.wcode}" }, function(){
        alert("대리 요청이 완료되었습니다.");
        window.opener.location.reload();
        window.close();
      });
    });

    // 이의신청
    $("#btnObjection").on("click", function(){
      $.post("<c:url value='/work/objection'/>", { wcode: "${work.wcode}" }, function(){
        alert("이의신청이 등록되었습니다.");
        window.opener.location.reload();
        window.close();
      });
    });

    // 수정
    $("#btnModify").on("click", function(){
      window.open(
        "<c:url value='/work/modify'/>?wcode=${work.wcode}",
        "workModify",
        "width=850,height=650,scrollbars=yes,resizable=yes"
      );
    });

    // 삭제
    $("#btnDelete").on("click", function(){
      if(confirm("정말 삭제하시겠습니까?")){
        $.post("<c:url value='/work/delete'/>", { wcode: "${work.wcode}" }, function(){
          alert("업무가 삭제되었습니다.");
          window.opener.location.reload();
          window.close();
        });
      }
    });
  </script>
</body>
</html>
