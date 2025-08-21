<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
      <c:choose>
       
        <c:when test="${role eq 'approver'}">
          <button class="btn btn-success btn-sm action-btn" data-action="approve">승인</button>
          <button class="btn btn-danger btn-sm action-btn" data-action="reject">반려</button>
          <button class="btn btn-info btn-sm action-btn" data-action="cooperate">협업요청</button>
          <button class="btn btn-secondary btn-sm action-btn" data-action="delegate">대리요청</button>
        </c:when>

      
        <c:when test="${role eq 'requester'}">
          <c:choose>
            
            <c:when test="${wstatus  eq '대기중'}">
              <button class="btn btn-warning btn-sm action-btn" data-action="modify">수정</button>
              <button class="btn btn-danger btn-sm action-btn" data-action="delete">삭제</button>
            </c:when>
            
            <c:when test="${wstatus  eq '승인' or wstatus  eq '반려'}">
              <button class="btn btn-outline-danger btn-sm action-btn" data-action="objection">이의신청</button>
            </c:when>
          </c:choose>
        </c:when>
      </c:choose>
    </div>
  </div>


  <table class="table table-bordered detail-table">
    <tr>
      <th>요청자</th>
      <td>${work.requesterName}</td>
    </tr>
    <tr>
      <th>제목</th>
      <td>${work.wtitle}</td>
    </tr>
    <tr>
      <th>담당자</th>
      <td>${work.managerName}</td>
    </tr>
    <tr>
      <th>기한</th>
      <td><fmt:formatDate value="${work.wend}" pattern="yyyy-MM-dd" /></td>
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


  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script>
    $(".action-btn").on("click", function(){
      let action = $(this).data("action");
      let wcode = "${work.wcode}";
      let url = "";
      let msg = "";

      switch(action){
        case "approve":   url = "<c:url value='/work/approve'/>";   msg="승인되었습니다."; break;
        case "reject":    url = "<c:url value='/work/reject'/>";    msg="반려되었습니다."; break;
        case "cooperate": url = "<c:url value='/work/cooperate'/>"; msg="협업요청 완료."; break;
        case "delegate":  url = "<c:url value='/work/delegate'/>";  msg="대리요청 완료."; break;
        case "objection": url = "<c:url value='/work/objection'/>"; msg="이의신청 등록."; break;
        case "delete":    url = "<c:url value='/work/delete'/>";    msg="삭제되었습니다."; break;
        case "modify":
          window.open("<c:url value='/work/modify'/>?wcode="+wcode, "workModify",
            "width=850,height=650,scrollbars=yes,resizable=yes");
          return; 
      }

      if(action==="delete" && !confirm("정말 삭제하시겠습니까?")) return;

      $.ajax({
        url: url,
        type: "POST",
        data: { wcode: wcode },
        success: function(){
          alert("업무가 " + msg);
          window.opener.location.reload();
          window.close();
        },
        error: function(){
          alert("처리 중 오류가 발생했습니다.");
        }
      });
    });
  </script>
</body>
</html>
