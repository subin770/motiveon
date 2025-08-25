<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>결재 문서함</title>
<style>
* { box-sizing: border-box; }
body {
  margin: 0;
  font-family: "Pretendard","맑은 고딕",system-ui,-apple-system,Segoe UI,Roboto,Apple SD Gothic Neo,sans-serif;
  background: #ffffff; /* ← 오타 수정 (#fffff → #ffffff) */
  color: #52586B;
}
a { color: inherit; text-decoration: none; }
.wrap { padding: 0 20px; }

.btn { display:inline-block; padding:8px 14px; border-radius:0; font-weight:700; border:1px solid transparent; font-size:14px }
.btn-ok{ background:#487FC3; color:#fff }
.btn-cancel{ background:#D75340; color:#fff }
.btn-ghost{ background:#f5f7fb; border-color:#dde2ee; color:#52586B }

.toolbar{ display:flex; gap:10px; align-items:center; justify-content:flex-end; margin:0 0 14px }

.select,.search{ background:#fff; border:1px solid #e9ecf3; border-radius:0; padding:8px 12px; }
select{ border:none; outline:none; background:transparent; font:inherit; color:#52586B }
.search{ display:flex; align-items:center; gap:8px }
.search input{ border:none; outline:none; width:220px; font:inherit; color:#52586B; background:transparent }

.tabs{ display:flex; gap:8px; margin:8px 0 12px; }
.tab a{ display:inline-block; padding:8px 12px; border:1px solid #e1e5ef; background:#fff; border-radius:0; font-weight:700; }
.tab.on a{ background:#487FC3; border-color:#487FC3; color:#fff; }

.panel{ background:#fff; border:1px solid #e9ecf3; border-radius:0; overflow:hidden }
.panel .head{ display:flex; align-items:center; justify-content:space-between; padding:12px 14px; border-bottom:1px solid #e9ecf3 }
.panel .head .h{ font-weight:800 }

table{ width:100%; border-collapse:collapse }
th,td{ padding:11px 12px; text-align:left; border-bottom:1px solid #e9ecf3; font-size:14px }
th{ font-size:12px; letter-spacing:.04em; color:#8b90a0; background:#fafbff }
tbody tr:hover{ background:#fafcff }

.badge{ display:inline-block; padding:3px 8px; border-radius:999px; font-size:12px; border:1px solid #e1e5ef; }
.badge-wait{ background:#fffbe6; border-color:#f7d76a; }
.badge-approve{ background:#e9f7ef; border-color:#6ec48a; }
.badge-reject{ background:#fde8e8; border-color:#f28b82; }
.badge-turn{ background:#e7f0ff; border-color:#8ab4f8; font-weight:700; }
.txt-em{ color:#D75340; font-weight:800 }

.paging{ display:flex; gap:6px; justify-content:center; margin:14px 0 }
.paging a,.paging span{ min-width:34px; height:34px; display:inline-flex; align-items:center; justify-content:center; border:1px solid #e1e5ef; background:#fff; color:#52586B; text-decoration:none; font-weight:700; }
.paging .on{ background:#487FC3; border-color:#487FC3; color:#fff }
.paging .dim{ opacity:.45; pointer-events:none }
</style>
</head>
<body>
<div class="context-wrap">
  <h3 class="font-weight-bold" style="padding-left:10px; margin-left:20px; margin-top:10px; font-size:22px;">결재 문서함</h3>

  <!-- 탭: mine(내 차례)/wait(대기)/approved/ rejected/ all -->
  <c:set var="ctx" value="${pageContext.request.contextPath}" />
  <div class="tabs">
    <c:url var="baseTab" value="/approval/approveList">
      <c:param name="period" value="${period}" />
      <c:param name="field" value="${field}" />
      <c:param name="q" value="${q}" />
      <c:param name="size" value="${size}" />
      <c:param name="page" value="1" />
    </c:url>
    <div class="tab ${tab=='mine'?'on':''}"><a href="${baseTab}&tab=mine">내 차례</a></div>
    <div class="tab ${tab=='wait'?'on':''}"><a href="${baseTab}&tab=wait">대기</a></div>
    <div class="tab ${tab=='approved'?'on':''}"><a href="${baseTab}&tab=approved">승인</a></div>
    <div class="tab ${tab=='rejected'?'on':''}"><a href="${baseTab}&tab=rejected">반려</a></div>
    <div class="tab ${tab=='all'?'on':''}"><a href="${baseTab}&tab=all">전체</a></div>
  </div>

  <!-- 필터 -->
  <div class="toolbar">
    <form action="${ctx}/approval/approveList" method="get" style="display:flex; gap:10px; align-items:center;">
      <input type="hidden" name="tab" value="${tab}" />
      <div class="select">
        <select name="period">
          <option value="all" ${period=='all'?'selected':''}>전체기간</option>
          <option value="1m"  ${period=='1m'?'selected':''}>1개월</option>
          <option value="6m"  ${period=='6m'?'selected':''}>6개월</option>
          <option value="1y"  ${period=='1y'?'selected':''}>1년</option>
        </select>
      </div>
      <div class="select">
        <select name="field">
          <option value="title"   ${field=='title'?'selected':''}>제목</option>
          
          <option value="drafter" ${field=='drafter'?'selected':''}>기안자</option>
          <option value="dept"    ${field=='dept'?'selected':''}>부서</option>
          <option value="form"    ${field=='form'?'selected':''}>결재양식</option>
        </select>
      </div>
      <div class="search">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden>
          <path d="M21 21l-4.35-4.35" stroke="#9aa1b3" stroke-width="2" stroke-linecap="round" />
          <circle cx="11" cy="11" r="7" stroke="#9aa1b3" stroke-width="2" fill="none" />
        </svg>
        <input name="q" type="text" value="${fn:escapeXml(q)}" placeholder="내용을 입력해주세요." />
      </div>
      <input type="hidden" name="page" value="${page}" />
      <input type="hidden" name="size" value="${size}" />
      <button type="submit" class="btn btn-ok">검색</button>
      <a href="${ctx}/approval/approveList" class="btn btn-cancel">초기화</a>
    </form>
  </div>

  <!-- 목록 -->
  <section class="panel">
    <div class="head">
      <div class="h">결재 문서함 <span style="font-weight:400; color:#8b90a0;">(총 ${totalCount}건)</span></div>
    </div>
    <table>
      <thead>
        <tr>
          <th style="width:48px"><input type="checkbox" onclick="toggleAll(this)"></th>
          <th style="width:120px">기안일</th>
          <th style="width: 150px">결재양식</th>
          <th>제목</th>
          <th style="width:120px">기안자</th>
          <th style="width:140px">부서</th>
          <th style="width:140px">문서번호</th>
          <th style="width:120px">내 결재</th>
          <th style="width:80px">순번</th>
          <th style="width:120px">비고</th>
          <th style="width:80px">긴급</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="d" items="${list}">
          <tr>
            <td><input type="checkbox"></td>
            <td><fmt:formatDate value="${d.ddate}" pattern="yyyy-MM-dd" /></td>
            <td><c:out value="${d.formNo}" /></td>
            <td>
              <a href="${ctx}/approval/detail?signNo=${d.signNo}">
                <c:out value="${d.title}" />
              </a>
            </td>
            <td><c:out value="${d.docName}" /></td>
            <td><c:out value="${d.docDept}" /></td>
            <td><c:out value="${d.signNo}" /></td>
            <td>
              <c:choose>
                <c:when test="${d.myState == 1}">
                  <span class="badge badge-approve">승인</span>
                </c:when>
                <c:when test="${d.myState == 2}">
                  <span class="badge badge-reject">반려</span>
                </c:when>
                <c:otherwise>
                  <span class="badge badge-wait">대기</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td>${d.myRank}</td>
            <td>
              <c:if test="${d.myTurn == 1}">
                <span class="badge badge-turn">내 차례</span>
              </c:if>
            </td>
            <td>
              <c:if test="${d.emergency == 1}">
                <span class="txt-em">긴급</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}">
          <tr>
            <td colspan="10" style="color:#8b90a0; text-align:center;">표시할 문서가 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="paging">
      <c:url var="baseUrl" value="/approval/approveList">
        <c:param name="tab" value="${tab}" />
        <c:param name="period" value="${period}" />
        <c:param name="field" value="${field}" />
        <c:param name="q" value="${q}" />
        <c:param name="size" value="${size}" />
      </c:url>

      <!-- 이전 -->
      <c:choose>
        <c:when test="${page <= 1}">
          <span class="dim">&laquo;</span>
        </c:when>
        <c:otherwise>
          <a href="${baseUrl}&page=${page-1}">&laquo;</a>
        </c:otherwise>
      </c:choose>

      <!-- 페이지 번호 (현재 -2 ~ +2) -->
      <c:set var="startP" value="${page-2 < 1 ? 1 : page-2}" />
      <c:set var="endP"   value="${page+2 > totalPages ? totalPages : page+2}" />
      <c:forEach var="p" begin="${startP}" end="${endP}">
        <c:choose>
          <c:when test="${p == page}">
            <span class="on">${p}</span>
          </c:when>
          <c:otherwise>
            <a href="${baseUrl}&page=${p}">${p}</a>
          </c:otherwise>
        </c:choose>
      </c:forEach>

      <!-- 다음 -->
      <c:choose>
        <c:when test="${page >= totalPages || totalPages == 0}">
          <span class="dim">&raquo;</span>
        </c:when>
        <c:otherwise>
          <a href="${baseUrl}&page=${page+1}">&raquo;</a>
        </c:otherwise>
      </c:choose>
    </div>
  </section>
</div>

<script>
  function toggleAll(chk){
    document.querySelectorAll('tbody input[type="checkbox"]').forEach(function(b){ b.checked = chk.checked; });
  }
</script>
</body>
</html>
