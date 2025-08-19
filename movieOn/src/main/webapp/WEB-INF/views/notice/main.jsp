<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice/main_css.css" />

<!-- 페이지 계산 -->
<c:set var="totalCount" value="${empty totalCount ? 0 : totalCount}" />
<c:set var="pageSize" value="${empty param.pageSize ? 10 : param.pageSize}" />
<c:set var="pageSize" value="${pageSize + 0}" />
<c:set var="curr" value="${not empty currentPage ? currentPage : (empty param.page ? 1 : param.page)}" />
<c:set var="curr" value="${curr + 0}" />
<c:set var="pages" value="${empty pageCount ? (((totalCount + pageSize - 1) / pageSize)) : pageCount}" />
<c:set var="pages" value="${pages + 0}" />
<c:set var="blockSize" value="5" />
<c:set var="startPage" value="${((curr-1)/blockSize)*blockSize + 1}" />
<c:set var="endPage" value="${startPage + blockSize - 1}" />
<c:if test="${endPage > pages}">
  <c:set var="endPage" value="${pages}" />
</c:if>
<c:url var="baseUrl" value="${pageContext.request.contextPath}/notice/main">
  <c:param name="searchType" value="${param.searchType}" />
  <c:param name="keyword" value="${param.keyword}" />
  <c:param name="pageSize" value="${pageSize}" />
</c:url>

<!-- 검색 / 상단바 -->
<form method="get" action="${pageContext.request.contextPath}/notice/main">
  <div class="top-bar">
    <div class="title">공지사항</div>
    <div class="right-controls">
      <select name="pageSize">
        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
        <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
        <option value="30" ${pageSize == 30 ? 'selected' : ''}>30</option>
        <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
      </select>
      <select name="searchType">
        <option value="t" ${param.searchType == 't' ? 'selected' : ''}>제목</option>
        <option value="c" ${param.searchType == 'c' ? 'selected' : ''}>내용</option>
        <option value="e" ${param.searchType == 'e' ? 'selected' : ''}>작성자</option>
      </select>
      <div class="search-box">
        <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" />
        <span class="search-icon">&#128269;</span>
      </div>
    </div>
  </div>

  <div class="bottom-bar">
    <div>총 ${totalCount}건</div>
    <button type="button" class="write-btn"
      onclick="location.href='${pageContext.request.contextPath}/notice/write'">글 등록</button>
  </div>
</form>

<!-- 공지사항 표 -->
<table class="notice-table">
  <thead>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>첨부</th>
      <th>조회수</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="n" items="${notices}">
      <tr>
        <td>
          <c:choose>
            <c:when test="${n.fixed eq '1'}"><span class="notice-label">[공지]</span></c:when>
            <c:otherwise>${n.nno}</c:otherwise>
          </c:choose>
        </td>
        <td>
          <a href="${pageContext.request.contextPath}/notice/detail/${n.nno}"
             class="${n.fixed eq '1' ? 'notice-title' : ''}">${n.title}</a>
        </td>
        <td>${n.ename}</td>
        <td><fmt:formatDate value="${n.regdate}" pattern="yyyy-MM-dd" /></td>
        <td>
          <c:if test="${not empty n.filename}">
            <a href="${pageContext.request.contextPath}/notice/download/${n.nno}">
              <img src="${pageContext.request.contextPath}/resources/icons/file.png" alt="첨부" class="icon-file" />
              ${n.filename}
            </a>
          </c:if>
        </td>
        <td>${n.viewcnt}</td>
      </tr>
    </c:forEach>
  </tbody>

  <!-- 페이징을 tfoot에 -->
  <tfoot>
  <!-- ★ 조건 제거: 항상 출력되도록 true로 고정 -->
  <div class="pagination">
  <c:forEach var="i" begin="1" end="${pageCount}">
    <c:url var="pageLink" value="${pageContext.request.contextPath}/notice/list">
      <c:param name="searchType" value="${param.searchType}" />
      <c:param name="keyword" value="${param.keyword}" />
      <c:param name="pageSize" value="${pageSize}" />
      <c:param name="page" value="${i}" />
    </c:url>
    <a href="${pageLink}" class="${i == currentPage ? 'active' : ''}">${i}</a>
  </c:forEach>
</div>

</tfoot>
</table>
