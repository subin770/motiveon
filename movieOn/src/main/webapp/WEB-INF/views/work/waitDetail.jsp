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
  <title>대기 업무 상세</title>
  <link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">
  <style>
    body { background:#fff; }
    .page-title { font-size:18px; font-weight:700; color:#2B2F3A; }
    .detail-card { border:1px solid #e5e7eb; box-shadow:none; }
    .detail-table th{ width:140px; background:#f8fafc; color:#6b7280; vertical-align:middle; text-align:center; }
    .detail-table td{ background:#fff; color:#111827; }
    .detail-table .content-cell{ white-space:pre-wrap; line-height:1.6; }
  </style>
</head>
<body>

<div class="container-fluid p-3">
  <div class="d-flex align-items-center justify-content-between mb-2">
    <div class="page-title">상세보기</div>
  </div>

  <div class="card detail-card">
    <div class="card-body p-0">
      <table class="table table-bordered mb-0 detail-table">
        <colgroup>
          <col style="width:140px"><col>
        </colgroup>
        <tbody>
        <tr>
          <th>업무코드</th>
          <td>${work.wcode}</td>
        </tr>
        <tr>
          <th>제목</th>
          <td>${work.wtitle}</td>
        </tr>
        <tr>
          <th>상세내용</th>
          <td class="content-cell">
            <c:out value="${work.wcontent}" escapeXml="false"/>
          </td>
        </tr>
        <tr>
          <th>담당자</th>
          <td>${work.eno}</td>
        </tr>
        <tr>
          <th>기한</th>
          <td><fmt:formatDate value="${work.wend}" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
          <th>상태</th>
          <td>${work.wstatus}</td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>

  <input type="hidden" id="wcode" value="${work.wcode}">
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="<%=ctx%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
