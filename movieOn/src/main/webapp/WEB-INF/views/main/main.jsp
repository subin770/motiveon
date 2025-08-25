<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%-- 경로/아이콘을 c:url로 안전하게 생성 --%>
<c:url var="urlFormPicker" value="/approval/formPicker"/>
<c:url var="urlNoticeMain" value="/notice/main"/>
<c:url var="urlWorkList"   value="/work/main"/>
<c:url var="urlWorkReg"    value="/work/regist"/>
<c:url var="urlCalRegForm" value="/calendar/regist"/>
<c:url var="urlApprList"   value="/approval/approveList"/>
<c:url var="icoCalendar"   value="/resources/icons/calendar.png"/>
<c:url var="icoDoc"        value="/resources/icons/document.png"/>
<c:url var="icoTask"       value="/resources/icons/task.png"/>

<head>
  <link rel="stylesheet" href="${ctx}/resources/css/dashboard_css.css">
  <style>
    :root{
      --bg:#fff; --ink:#2B2F3A; --muted:#8B90A0;
      --primary:#487FC3; --accent:#2F77E5;
      --border:#E6EAF0; --line:#EEF1F6; --thead:#FAFBFF; --hover:#F7FAFF;
      --radius:14px; --pad:16px; --gap:18px;
      --shadow:0 6px 18px rgba(16,24,40,.06);
    }
    html,body{ background:var(--bg); color:var(--ink); }
    .container.dashboard{ padding:12px var(--pad) 24px; max-width:1200px; margin:0 auto; }
    .row{ display:flex; gap:var(--gap); margin-bottom:var(--gap); flex-wrap:wrap; }
    .flex-1{ flex:1 1 340px; } .flex-2{ flex:2 1 520px; }
    .box{ background:#fff; border:1px solid var(--border); border-radius:var(--radius); overflow:hidden; box-shadow:var(--shadow); }
    .box .title{ display:flex; align-items:center; justify-content:space-between; gap:10px; padding:12px 18px; border-bottom:1px solid var(--line); background:linear-gradient(180deg,#fff 0%,#fcfdff 100%); font-weight:800; }
    .title .title-link{ color:var(--primary); } .title .more{ color:#6A738B; font-size:13px; font-weight:700; }
    .title .more:hover{ color:var(--primary); }
    .table-container{ padding:12px 18px 18px; }
    table{ width:100%; border-collapse:separate; border-spacing:0; table-layout:fixed; }
    thead th{ background:var(--thead); color:#6B7280; font-size:12px; letter-spacing:.02em; font-weight:800; padding:12px 14px; border-bottom:1px solid var(--border); }
    th,td{ padding:12px 14px; border-bottom:1px solid var(--line); font-size:14px; vertical-align:middle; }
    a.row-link{ color:inherit; text-decoration:none; }
    a.row-link:hover{ text-decoration:underline; }
    .text-ellipsis{ white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }

    /* 퀵메뉴 */
    .quick-items{ padding:12px 18px 18px; display:grid; gap:10px; }
    .qm-item{ display:flex; align-items:center; justify-content:space-between; gap:12px; padding:12px 14px; border:1px solid var(--line); border-radius:12px; background:#fff; transition:.15s ease; }
    .qm-item:hover{ background:var(--hover); border-color:#e3eaf6; text-decoration:none; }
    .qm-left{ display:flex; align-items:center; gap:10px; }
    .qm-ico{ width:28px; height:28px; border-radius:999px; display:inline-flex; align-items:center; justify-content:center; background:#EFF4FF; box-shadow: inset 0 0 0 1px #dae6ff; }
    .qm-arrow{ color:#A7B0C5; }

    /* 상태/프로그레스 */
    .status-wrap{ display:flex; align-items:center; gap:8px; }
    .status-bar{ width:140px; height:8px; border-radius:999px; background:#EEF1F6; overflow:hidden; }
    .status-bar .progress{ height:100%; background:var(--accent); }
    .pill{ display:inline-flex; align-items:center; padding:6px 10px; border-radius:999px; font-weight:800; font-size:12px; border:1px solid transparent; }
    .pill.wait{ background:#EEF2F6; color:#6B7280; }
    .pill.prog{ background:#E9F1FF; color:#2F77E5; border-color:#DCE9FF; }
    .pill.done{ background:#EAF7F0; color:#1F7A47; border-color:#D6F0E0; }
    .pill.dele{ background:#FFF6E0; color:#B58100; border-color:#FFECB3; }

    .muted{ color:var(--muted); }
    .profile{ display:inline-flex; align-items:center; gap:8px; }
    .avatar-dot{ width:8px; height:8px; border-radius:999px; background:#C8D0E2; display:inline-block; }

    /* 업무/결재 세로 나열: 각 박스를 전체 폭으로 */
    .stack .box{ flex:1 1 100%; }

    @media (max-width: 768px){
      thead{ display:none; }
      table, tbody, tr, td { display:block; width:100%; }
      tr{ border-bottom:1px solid var(--line); padding:8px 0; }
      td{ border:0; padding:6px 0; }
    }
  </style>
  <script>
    function openFormPicker(){
      const w=750,h=600;
      const y=(window.outerHeight/2 + window.screenY) - (h/2);
      const x=(window.outerWidth/2  + window.screenX) - (w/2);
      window.open('${urlFormPicker}','formPicker',`width=${w},height=${h},left=${x},top=${y},resizable=yes,scrollbars=yes`);
    }
  </script>
</head>

<body>
<div class="container dashboard">

  <!-- 상단: 퀵메뉴 + 공지 -->
  <div class="row">

    <!-- 퀵메뉴 -->
    <section class="box flex-1" aria-label="퀵메뉴">
      <div class="title">퀵메뉴</div>
      <div class="quick-items">
        <a class="qm-item" href="${urlCalRegForm}">
          <span class="qm-left">
            <span class="qm-ico"><img src="${icoCalendar}" alt="" width="16" height="16"></span>
            <strong>일정 작성</strong>
          </span>
          <span class="qm-arrow" aria-hidden="true">➜</span>
        </a>
        <a class="qm-item" href="javascript:void(0)" onclick="openFormPicker()">
          <span class="qm-left">
            <span class="qm-ico"><img src="${icoDoc}" alt="" width="16" height="16"></span>
            <strong>새 결재</strong>
          </span>
          <span class="qm-arrow" aria-hidden="true">➜</span>
        </a>
        <a class="qm-item" href="${urlWorkReg}">
          <span class="qm-left">
            <span class="qm-ico"><img src="${icoTask}" alt="" width="16" height="16"></span>
            <strong>업무 등록</strong>
          </span>
          <span class="qm-arrow" aria-hidden="true">➜</span>
        </a>
      </div>
    </section>

    <!-- 공지사항 최신글 -->
    <section class="box flex-2" aria-label="공지사항 최신글">
      <div class="title">
        <a href="${urlNoticeMain}" class="title-link">공지사항 최신글</a>
        <a href="${urlNoticeMain}" class="more">더보기</a>
      </div>
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th style="width:80px">번호</th>
              <th>제목</th>
              <th style="width:120px">작성자</th>
              <th style="width:120px">작성일</th>
              <th style="width:90px">조회수</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="notice" items="${noticeList}">
              <tr>
                <td>${notice.nno}</td>
                <td class="text-ellipsis" title="${notice.title}">
                  <a class="row-link" href="${ctx}/notice/detail/${notice.nno}">${notice.title}</a>
                </td>
                <td>${notice.ename}</td>
                <td><fmt:formatDate value="${notice.regdate}" pattern="yyyy-MM-dd"/></td>
                <td>${notice.viewcnt}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty noticeList}">
              <tr><td colspan="5" class="muted" style="text-align:center; padding:28px 0;">공지사항이 없습니다.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </section>

  </div>

  <!-- 하단: 업무/결재 세로 스택 -->
  <div class="row stack">

    <!-- 업무 현황 (세로 첫 번째) -->
    <section class="box" aria-label="업무 현황">
      <div class="title">
        <span>업무 현황</span>
        <a href="${urlWorkList}" class="more">더보기</a>
      </div>
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>제목</th>
              <th style="width:140px">요청자</th>
              <th style="width:160px">담당자</th>
              <th style="width:220px">진척도</th>
              <th style="width:110px">기한</th>
              <th style="width:100px">상태</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="w" items="${workList}">
              <tr>
                <td class="text-ellipsis" title="${w.wtitle}">
                  <a class="row-link" href="${ctx}/work/detail?wcode=${w.wcode}">${w.wtitle}</a>
                </td>
                <td>${w.requesterName}<br><span class="muted">${w.requesterDept}</span></td>
                <td class="profile"><span class="avatar-dot"></span>${w.managerName}<br><span class="muted">${w.managerDept}</span></td>
                <td>
                  <span class="status-wrap">
                    <span class="status-bar"><span class="progress" style="width:${w.progressPct}%"></span></span>
                    ${w.progressPct}% 완료
                  </span>
                </td>
                <td><fmt:formatDate value="${w.wend}" pattern="yyyy-MM-dd"/></td>
                <td>
                  <c:choose>
                    <c:when test="${w.wstatus eq 'WAIT'}"><span class="pill wait">대기</span></c:when>
                    <c:when test="${w.wstatus eq 'ING'}"><span class="pill prog">진행</span></c:when>
                    <c:when test="${w.wstatus eq 'DONE'}"><span class="pill done">완료</span></c:when>
                    <c:when test="${w.wstatus eq 'DELEGATE'}"><span class="pill dele">대리</span></c:when>
                    <c:when test="${w.wstatus eq 'REJECT'}"><span class="pill wait">반려</span></c:when>
                    <c:otherwise><span class="pill wait">${w.statusName}</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty workList}">
              <tr>
                <td class="text-ellipsis" title="TEST"><a class="row-link" href="${urlWorkList}">TEST</a></td>
                <td>홍길동 부장<br><span class="muted">인사관리팀</span></td>
                <td class="profile"><span class="avatar-dot"></span>박동규 팀장<br><span class="muted">인사관리팀</span></td>
                <td>
                  <span class="status-wrap">
                    <span class="status-bar"><span class="progress" style="width:60%"></span></span>
                    60% 완료
                  </span>
                </td>
                <td>2025-07-04</td>
                <td><span class="pill prog">진행</span></td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </section>

    <!-- 전자 결재 (세로 두 번째) -->
    <section class="box" aria-label="전자 결재">
      <div class="title">
        <span>전자 결재</span>
        <a href="${urlApprList}" class="more">더보기</a>
      </div>
      <div class="table-container">
        <table>
          <thead>
          
        <tr>

          <th style="width:120px">기안일</th>
          <th style="width:150px">결재양식</th>
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
          <tr><td colspan="11" style="color:#8b90a0; text-align:center;">표시할 문서가 없습니다.</td></tr>
   
            </c:if>
          </tbody>
        </table>
      </div>
    </section>

  </div>
</div>
</body>