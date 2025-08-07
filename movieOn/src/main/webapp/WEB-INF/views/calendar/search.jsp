<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 검색 결과</title>
<style>
body {

	color: #52586B;
	margin: 40px;
}

/* 검색창 */
form {
	margin-bottom: 20px;
}

input[type="text"] {
	width: 100%;
	height: 38px;
	font-size: 15px;
	padding: 6px 12px;
	border: 1.5px solid #52586B;
	border-radius: 6px;
	color: #52586B;
}

/* 제목 */
h2 {
	font-size: 21px;
	
	margin-bottom: 20px;
	color: #52586B;
}
.title-main {
    font-weight: 600 !important;
    color: #212529 !important;  /* 내일정에 쓰인 색상 */
}

.title-sub {
	font-weight: normal;
	font-size: 15px;
	color: #888888;
	margin-left: 6px;
}


/* 테이블 */
table {
	width: 100%;
	border-collapse: collapse;
	font-size: 16px;
}

th, td {
	padding: 10px 12px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

th {
	background-color: #f5f5f5;
	font-weight: bold;
	color: #52586B;
}

mark {
	background-color: #f5e663;
	font-weight: bold;
	padding: 2px 4px;
	border-radius: 3px;
}
</style>
</head>
<body>
  <h2>
    <span class="title-main">검색결과</span>
    <span class="title-sub">(총 ${resultList.size()}건)</span>
  </h2>

  <form action="/motiveOn/calendar/search" method="get">
    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
  </form>

  <table>
    <thead>
      <tr>
        <th>날짜</th>
        <th>기간</th>
        <th>일정명</th>
        <th>일정분류</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="row" items="${resultList}">
        <tr>
          <td>
            <fmt:formatDate value="${row.sdate}" pattern="yyyy-MM-dd(E)" />
          </td>
          <td>
            <fmt:formatDate value="${row.sdate}" pattern="HH:mm" /> ~
            <fmt:formatDate value="${row.edate}" pattern="HH:mm" />
          </td>
          <td>
            <c:out value="${row.title}" />
          </td>
          <td>
            <c:out value="${row.catedetail}" />
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</body>

</html>
