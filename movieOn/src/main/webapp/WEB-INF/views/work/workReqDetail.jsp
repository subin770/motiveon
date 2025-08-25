<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>요청한 업무 상세보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
    href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
    href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">

<style>
body { background:#fff; padding:20px; }
.table { width:100%; border:1px solid #dee2e6; border-collapse:collapse; }
.table th, .table td {
    border:1px solid #dee2e6;
    padding:10px;
    text-align:left;
}
.table th { background:#f9f9f9; width:120px; }
.btn-wrap { margin-top:20px; text-align:right; }
</style>
</head>
<body>
    <h4>요청한 업무 상세보기</h4>

    <table class="table">
        <tr>
            <th>제목</th>
            <td>${work.wtitle}</td>
        </tr>
        <tr>
            <th>상세내용</th>
            <td>${work.wcontent}</td>
        </tr>
        <tr>
            <th>요청자</th>
            <td>${work.requesterName}</td>
        </tr>
        <tr>
            <th>담당자</th>
            <td>${work.managerName}</td>
        </tr>
        <tr>
            <th>시작일</th>
            <td><fmt:formatDate value="${work.wdate}" pattern="yyyy-MM-dd" /></td>
        </tr>
        <tr>
            <th>마감일</th>
            <td><fmt:formatDate value="${work.wend}" pattern="yyyy-MM-dd" /></td>
        </tr>
        <tr>
            <th>상태</th>
            <td>
                <c:choose>
                    <c:when test="${work.wstatus eq 'PROG'}">
                        <span class="badge badge-info">진행</span>
                    </c:when>
                    <c:when test="${work.wstatus eq 'DONE'}">
                        <span class="badge badge-success">완료</span>
                    </c:when>
                    <c:when test="${work.wstatus eq 'DELEGATE'}">
                        <span class="badge badge-warning">대리 요청</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-secondary">대기</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

    <div class="btn-wrap">
        <!-- 수정 버튼: 새창이 아니라 현재 팝업에서 바로 수정폼으로 전환 -->
        <button class="btn btn-primary" onclick="openEditForm('${work.wcode}')">수정</button>
        <button class="btn btn-secondary" onclick="window.close()">닫기</button>
    </div>

<script src="<%=ctx%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>
    // 수정폼으로 이동 (현재 상세보기 팝업 창에서 그대로 열림)
    function openEditForm(wcode){
        let url = '<%=ctx%>/work/workRegistForm?wcode=' + wcode;
        location.href = url;   // 새창 X, 현재 팝업창 전환
    }
</script>
</body>
</html>
