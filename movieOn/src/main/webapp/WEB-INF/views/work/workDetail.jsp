<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<html>
<head>
  <meta charset="UTF-8">
  <title>업무 상세</title>
  <link rel="stylesheet" href="${cpath}/resources/bootstrap/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>
<body>
<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h3 class="card-title mb-0">업무 상세</h3>
    <div>
      <!-- 승인 -->
      <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#approveModal">승인</button>
      <!-- 반려 -->
      <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#rejectModal">반려</button>
      <!-- 이의신청 -->
      <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#objModal">이의신청</button>
      <a href="${cpath}/work/my" class="btn btn-secondary btn-sm">목록</a>
    </div>
  </div>

  <div class="card-body">
    <dl class="row">
      <dt class="col-sm-2">제목</dt>
      <dd class="col-sm-10">${work.wtitle}</dd>

      <dt class="col-sm-2">담당자</dt>
      <dd class="col-sm-10">${work.eno}</dd>

      <dt class="col-sm-2">기한</dt>
      <dd class="col-sm-10">
        <fmt:formatDate value="${work.wend}" pattern="yyyy-MM-dd"/>
      </dd>

      <dt class="col-sm-2">상태</dt>
      <dd class="col-sm-10">${work.wstatus}</dd>

      <dt class="col-sm-2">내용</dt>
      <dd class="col-sm-10">
        <c:out value="${work.wcontent}" escapeXml="false"/>
      </dd>
    </dl>
  </div>
</div>

<!-- 승인 모달 -->
<div class="modal fade" id="approveModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">승인</h5></div>
      <div class="modal-body">해당 업무를 승인하시겠습니까?</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" id="btnApprove">승인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 반려 모달 -->
<div class="modal fade" id="rejectModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">반려 사유</h5></div>
      <div class="modal-body">
        <textarea id="rejectReason" class="form-control" rows="4" placeholder="반려 사유를 입력하세요"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" id="btnReject">반려</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 이의신청 모달 -->
<div class="modal fade" id="objModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <form id="objForm">
        <input type="hidden" name="wcode" value="${work.wcode}">
        <div class="modal-header"><h5 class="modal-title">이의신청</h5></div>
        <div class="modal-body">
          <select name="type" class="form-control mb-2">
            <option>업무관련</option>
            <option>일정관련</option>
            <option>기타</option>
          </select>
          <textarea name="content" class="form-control" rows="5" required></textarea>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-warning">이의신청</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  const wcode = "${work.wcode}";

  // 승인 처리
  $("#btnApprove").click(function(){
    $.post("${cpath}/work/approve", { wcode: wcode }, function(res){
      if(res === "SUCCESS"){
        Swal.fire("승인 완료", "업무가 승인되었습니다.", "success")
          .then(() => { window.opener.location.reload(); window.close(); });
      } else {
        Swal.fire("실패", "처리 중 오류 발생", "error");
      }
    });
  });

  // 반려 처리
  $("#btnReject").click(function(){
    $.post("${cpath}/work/reject", { wcode: wcode, reason: $("#rejectReason").val() }, function(res){
      if(res === "SUCCESS"){
        Swal.fire("반려 완료", "업무가 반려 처리되었습니다.", "success")
          .then(() => { window.opener.location.reload(); window.close(); });
      } else {
        Swal.fire("실패", "처리 중 오류 발생", "error");
      }
    });
  });

  // 이의신청 처리
  $("#objForm").submit(function(e){
    e.preventDefault();
    $.post("${cpath}/work/objection", $(this).serialize(), function(res){
      if(res === "SUCCESS"){
        Swal.fire("이의신청 완료", "이의신청이 접수되었습니다.", "success")
          .then(() => { window.opener.location.reload(); window.close(); });
      } else {
        Swal.fire("실패", "처리 중 오류 발생", "error");
      }
    });
  });
</script>

</body>
</html>
