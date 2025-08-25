<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 업무 상세보기</title>

<!-- Bootstrap / AdminLTE -->
<link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">
<link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/plugins/bootstrap/css/bootstrap.min.css">

<style>
    body { padding:20px; background:#fff; }
    .page-header { border-bottom: 1px solid #ddd; margin-bottom: 15px; }
    .badge { padding: 5px 10px; font-size: 0.85rem; }
    .table-detail th { width: 20%; background: #f9f9f9; }
</style>
</head>
<body>

    <!-- 헤더 -->
    <div class="page-header">
        <h4>내 업무 상세보기</h4>
    </div>

    <!-- 상세 테이블 -->
    <table class="table table-bordered table-detail">
        <tr>
            <th>제목</th>
            <td>${work.wtitle}</td>
        </tr>
        <tr>
            <th>상세내용</th>
            <td>${work.wcontent}</td>
        </tr>
        <tr>
            <th>담당자</th>
            <td>${work.managerName}</td>
        </tr>
        <tr>
            <th>기한</th>
            <td><fmt:formatDate value="${work.wend}" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
            <th>상태</th>
            <td>
              <c:choose>
                <c:when test="${work.wstatus eq 'WAIT'}"><span class="badge badge-warning">대기</span></c:when>
                <c:when test="${work.wstatus eq 'ING'}"><span class="badge badge-info">진행</span></c:when>
                <c:when test="${work.wstatus eq 'DONE'}"><span class="badge badge-success">완료</span></c:when>
                <c:when test="${work.wstatus eq 'DELEGATE'}"><span class="badge badge-primary">대리</span></c:when>
                <c:when test="${work.wstatus eq 'REJECT'}"><span class="badge badge-danger">반려</span></c:when>
                <c:otherwise>${work.wstatus}</c:otherwise>
              </c:choose>
            </td>
        </tr>
    </table>

    <!-- 버튼 -->
    <div class="text-right mt-3">
        <input type="hidden" id="wcode" value="${work.wcode}">
        <button type="button" class="btn btn-secondary" onclick="window.close()">닫기</button>
        <c:if test="${work.wstatus eq 'WAIT'}">
            <button type="button" class="btn btn-primary" id="btnApprove">승인</button>
            <button type="button" class="btn btn-warning" id="btnReject">반려</button>
        </c:if>
    </div>

    <!-- ===== 반려 모달 (간단형) ===== -->
    <div class="modal fade" id="rejectModal" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header"><h5 class="modal-title">반려</h5></div>
          <div class="modal-body">
            <label for="rejectReason">반려사유</label>
            <textarea id="rejectReason" class="form-control" rows="3"></textarea>
          </div>
          <div class="modal-footer">
            <button id="btnRejectConfirm" type="button" class="btn btn-danger">확인</button>
          </div>
        </div>
      </div>
    </div>

<!-- jQuery / Bootstrap -->
<script src="<%=ctx%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="<%=ctx%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<script>
$(function(){
    var wcode = $("#wcode").val();

    // 승인 버튼
    $("#btnApprove").click(function(){
        if(confirm("승인하시겠습니까?")) {
            $.post("<%=ctx%>/work/approve", { wcode: wcode }, function(res){
                if(res === "success" || res.result === "success"){
                    alert("승인되었습니다.");
                    opener.location.reload();
                    window.close();
                } else {
                    alert("승인 처리 중 오류: " + res);
                }
            }).fail(function(xhr){
                alert("서버 요청 실패: " + xhr.status);
            });
        }
    });


    // 반려 모달 열기
    $("#btnReject").click(function(){
        $("#rejectModal").modal("show");
    });

    // 반려 확정
  // 반려 확정
$("#btnRejectConfirm").click(function(){
    var reason = $("#rejectReason").val();
    if(!reason){
        alert("반려 사유를 입력하세요.");
        return;
    }
    $.post("<%=ctx%>/work/reject", { wcode: wcode, reason: reason }, function(res){
        if(res === "success"){
            alert("반려 처리되었습니다.");
            $("#rejectModal").modal("hide");   
            opener.location.reload();          
            window.close();                  
        }
    });
});

</script>
</body>
</html>
