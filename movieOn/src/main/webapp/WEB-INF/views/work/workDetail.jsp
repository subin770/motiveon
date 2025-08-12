<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>미승인된 업무 상세보기</title>

  <!-- AdminLTE / Bootstrap -->
  <link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.0/dist/sweetalert2.min.css"/>

  <style>
    body { background:#fff; }
    .page-title { font-size:18px; font-weight:700; color:#2B2F3A; }
    .detail-card { border:1px solid #e5e7eb; box-shadow:none; }
    .detail-table th{ width:140px; background:#f8fafc; color:#6b7280; vertical-align:middle; text-align:center; }
    .detail-table td{ background:#fff; color:#111827; }
    .detail-table .content-cell{ white-space:pre-wrap; line-height:1.6; }
    .btn-sm{ padding:.35rem .7rem; }
  </style>
</head>
<body>

<div class="container-fluid p-3">
  <div class="d-flex align-items-center justify-content-between mb-2">
    <div class="page-title">상세보기</div>
    <div class="btn-wrap">
      <button type="button" id="btnApprove" class="btn btn-primary btn-sm">승인</button>
      <button type="button" id="btnObjection" class="btn btn-danger btn-sm">이의신청</button>
    </div>
  </div>

  <div class="card detail-card">
    <div class="card-body p-0">
      <table class="table table-bordered mb-0 detail-table">
        <colgroup>
          <col style="width:140px"><col>
        </colgroup>
        <tbody>
        <tr>
          <th>요청자</th>
          <td>${work.requesterName}</td>
        </tr>
        <tr>
          <th>제목</th>
          <td>${work.title}</td>
        </tr>
        <tr>
          <th>상세내용</th>
          <td class="content-cell">${work.content}</td>
        </tr>
        <tr>
          <th>담당자</th>
          <td>
            <c:choose>
              <c:when test="${not empty work.managerName}">${work.managerName}</c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr>
          <th>기한</th>
          <td>
            <c:choose>
              <c:when test="${not empty work.dueDate}">
                <fmt:formatDate value="${work.dueDate}" pattern="yyyy-MM-dd HH:mm"/>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
        </tr>
        <tr>
          <th>첨부파일</th>
          <td>
            <c:choose>
              <c:when test="${not empty attachList}">
                <ul class="mb-0 pl-3">
                  <c:forEach var="file" items="${attachList}">
                    <li>
                      <a href="<%=ctx%>/work/attach/download?fileId=${file.id}">
                        <i class="fa fa-paperclip mr-1"></i>${file.originalName}
                      </a>
                    </li>
                  </c:forEach>
                </ul>
              </c:when>
              <c:otherwise>첨부파일이 존재하지 않습니다.</c:otherwise>
            </c:choose>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>

  <!-- hidden values -->
  <input type="hidden" id="workId" value="${work.id}">
</div>

<!-- scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="<%=ctx%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.0/dist/sweetalert2.all.min.js"></script>

<script>
  const ctx = '<%=ctx%>';

  // 승인
  $('#btnApprove').on('click', function () {
    const wid = $('#workId').val();
    Swal.fire({
      title: '승인하시겠습니까?',
      icon: 'question',
      showCancelButton: true,
      confirmButtonText: '승인',
      cancelButtonText: '취소'
    }).then(function (r) {
      if (!r.isConfirmed) return;
      $.ajax({
        url: ctx + '/work/approve',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ id: wid })
      }).done(function () {
        Swal.fire({icon:'success', title:'승인되었습니다.'}).then(() => {
          if (window.opener) window.opener.location.reload();
          window.close();
        });
      }).fail(function () {
        Swal.fire({icon:'error', title:'처리 중 오류가 발생했습니다.'});
      });
    });
  });

  // 이의신청
  $('#btnObjection').on('click', function () {
    const wid = $('#workId').val();
    Swal.fire({
      title: '이의 사유를 입력하세요',
      input: 'textarea',
      inputPlaceholder: '이의 사유',
      showCancelButton: true,
      confirmButtonText: '제출',
      cancelButtonText: '취소',
      inputValidator: (v) => (!v || !v.trim()) && '이의 사유를 입력하세요.'
    }).then(function (r) {
      if (!r.isConfirmed) return;
      $.ajax({
        url: ctx + '/work/objection',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ id: wid, reason: r.value })
      }).done(function () {
        Swal.fire({icon:'success', title:'이의신청이 접수되었습니다.'}).then(() => {
          if (window.opener) window.opener.location.reload();
          window.close();
        });
      }).fail(function () {
        Swal.fire({icon:'error', title:'처리 중 오류가 발생했습니다.'});
      });
    });
  });
</script>
</body>
</html>
