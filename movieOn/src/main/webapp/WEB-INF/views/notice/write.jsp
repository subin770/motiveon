<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice/write_css.css" />


<div class="container">
		<h2>글 등록</h2>

		<!-- ✅ 등록/취소 버튼을 form 위로 -->
		<div class="button-group-top">
			<button type="submit" form="noticeForm" class="submit-btn">등록</button>
			<button type="button" class="cancel-btn" onclick="history.back()">취소</button>
		</div>

		<!-- ✅ 입력 폼 박스 -->
		<div class="form-box">
  <form id="noticeForm"
        action="${pageContext.request.contextPath}/notice/write"
        method="post" enctype="multipart/form-data">

    <!-- 제목 + 상단고정 체크박스 -->
    <div class="form-row" >
      <label>제목</label>
      <input type="text" name="title" required">
      <label>
        <input type="checkbox" name="fixed" value="1"
               ${notice.fixed == 1 ? 'checked' : ''} />
        상단고정
      </label>
    </div>

    <!-- 작성자 -->
    <div class="form-row">
      <label>작성자</label>
      <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
          <input type="text" value="${sessionScope.loginUser.name}" readonly>
        </c:when>
        <c:otherwise>
          <input type="text" value="비로그인자" readonly>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- 게시글 목록 테이블 (있다면) -->
    <c:choose>
      <c:when test="${empty notices}">
        <!-- 없음 -->
      </c:when>
      <c:otherwise>
        <table>...</table>
      </c:otherwise>
    </c:choose>

    <!-- 내용 -->
    <div class="form-row">
      <label>내용</label>
      <textarea name="content" required></textarea>
    </div>

    <!-- 첨부파일 -->
    <div class="form-row">
      <label>첨부파일</label>
      <input type="file" name="uploadFile">
    </div>

  </form>

