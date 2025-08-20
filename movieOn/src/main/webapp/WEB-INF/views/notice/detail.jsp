<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice/detail_css.css" />

<div class="container">
  
  <!-- 제목 -->
  <div class="header-box">
    <h2>공지사항</h2>
  </div>

  <!-- 버튼 -->
  <div class="button-group">
    <div class="left">
      <button class="btn btn-gray" onclick="location.href='${pageContext.request.contextPath}/notice/main'">목록</button>
    </div>
    <div class="right">
      <button class="btn btn-blue" onclick="location.href='${pageContext.request.contextPath}/notice/modify?nno=${notice.nno}'">수정</button>
      <button class="btn btn-red" onclick="if(confirm('삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/notice/delete/${notice.nno}'">삭제</button>
    </div>
  </div>

  <!-- 본문 박스 -->
  <div class="box">
    <!-- 제목 -->
    <div class="notice-title">${notice.title}</div>

    <!-- 작성자/날짜/조회수 -->
    <div class="notice-meta">
      <div class="author-box">
        <img src="${pageContext.request.contextPath}/resources/icons/profile.png" alt="프로필" />
        <span>${notice.ename}</span>&nbsp;
        <fmt:formatDate value="${notice.regdate}" pattern="yyyy-MM-dd" />
      </div>
      <div>조회 ${notice.viewcnt}</div>
    </div>

    <!-- 내용 -->
    <div class="notice-content">${notice.content}</div>

    <!-- 첨부파일 -->
    <c:if test="${not empty notice.filename}">
      <div class="file-box">
        <img src="${pageContext.request.contextPath}/resources/icons/file.png" alt="파일">
        <a href="${pageContext.request.contextPath}/notice/download/${notice.nno}">
          ${notice.filename}
        </a>
      </div>
    </c:if>

  </div>
</div>
