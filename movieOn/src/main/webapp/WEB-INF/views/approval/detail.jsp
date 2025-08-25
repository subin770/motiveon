<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>업무기안 – 결재 상세</title>

<style>
:root{
  --bg:#ffffff; --text:#52586B; --text-strong:#222;
  --border:#E1E5EF; --border-soft:#E9ECF3;
  --card:#fff; --muted:#8b90a0;
  --primary:#487FC3; --danger:#D75340; --ok:#32a05f;
  --badge-blue:#EEF2FF; --badge-red:#FFEFEF;
  --shadow:0 6px 18px rgba(25,32,56,.05);
}

*{ box-sizing:border-box; }
html,body{ height:100%; }
body{
  margin:0; font-family:"Pretendard","맑은 고딕",system-ui,-apple-system,Segoe UI,Roboto,Apple SD Gothic Neo,sans-serif;
  background:var(--bg); color:var(--text);
}
a{ color:inherit; text-decoration:none; }

/* ===== Topbar ===== */
.topbar{
  display:flex; align-items:center; justify-content:space-between;
  padding:14px 18px; border-bottom:1px solid var(--border-soft); background:#fff;
  position:sticky; top:0; z-index:10;
}
.topbar .title{ font-size:18px; font-weight:800; letter-spacing:.2px; color:var(--text-strong); }
.actions{ display:flex; gap:8px; }

/* ===== Buttons ===== */
.btn{ height:34px; padding:0 14px; border-radius:8px; border:1px solid transparent;
  font-weight:700; cursor:pointer; font-size:14px; }
.btn-ghost{ background:#fff; color:#3b4052; border-color:#DDE2EE; }
.btn-primary{ background:var(--primary); color:#fff; }
.btn-danger{ background:var(--danger); color:#fff; }
.btn-ok{ background:var(--ok); color:#fff; }
.btn-cancel{ background:var(--danger); color:#fff; }

/* ===== Layout ===== */
.page{ padding:18px 22px 32px; }
.container{ max-width:1200px; margin:0 auto; }
.grid{ display:grid; grid-template-columns:1fr 320px; gap:18px; }

/* ===== Panels ===== */
.panel{
  background:var(--card); border:1px solid var(--border); border-radius:12px; overflow:hidden; box-shadow:var(--shadow);
}
.panel .hd{ padding:12px 16px; border-bottom:1px solid var(--border-soft); font-weight:800; color:var(--text-strong); }
.panel .bd{ padding:16px; }

/* ===== Paper ===== */
.paper-box{ border:1px solid var(--border); border-radius:12px; padding:18px; background:#fff; }
.paper-title{
  margin:0 0 12px; text-align:center; font-size:24px; font-weight:900; letter-spacing:.12em; color:#1e2439;
}

.table{ width:100%; border-collapse:collapse; table-layout:fixed; }
.table th, .table td{ border:1px solid var(--border); padding:10px 12px; font-size:14px; vertical-align:middle; }
.table th{ background:#FAFBFE; color:#4B5164; width:120px; text-align:center; font-weight:700; }

.editor{
  min-height:260px; border:1px solid var(--border); border-radius:12px; padding:14px; margin-top:12px;
  color:#222; background:#fff; line-height:1.6; word-break:break-word;
}
.editor *{ max-width:100%; }

/* ===== Right side ===== */
.tabs{ display:flex; border-bottom:1px solid var(--border-soft); }
.tabs a{ padding:12px 14px; font-weight:800; color:var(--text); border-bottom:2px solid transparent; }
.tabs a.on{ color:var(--text-strong); border-bottom-color:var(--primary); }

.info-card{ border:1px solid var(--border); border-radius:12px; padding:12px; background:#fff; }
.info-grid{ display:grid; grid-template-columns:96px 1fr; gap:10px; align-items:center; color:#222; }

.badge{ display:inline-block; padding:5px 10px; border-radius:999px; background:var(--badge-blue); font-size:12px; }
.badge.red{ background:var(--badge-red); color:#b32727; }
.muted{ color:var(--muted); font-size:13px; }

.pills{ display:flex; flex-direction:column; gap:6px; }
.pill{ display:flex; align-items:center; justify-content:space-between; gap:8px; padding:10px 12px;
  border:1px solid var(--border); border-radius:12px; background:#FAFBFE; font-size:13px; }
.pill .meta{ color:#6f7892; font-size:12px; }

/* ===== Action bar (approve/reject) ===== */
.action-bar{ margin-top:16px; display:flex; flex-wrap:wrap; gap:8px; align-items:center; }
.action-bar input[type="text"]{ width:300px; padding:8px 10px; border:1px solid var(--border); border-radius:8px; }

/* ===== Feedback messages ===== */
.flash{ margin-top:10px; font-weight:700; }
.flash.ok{ color:#226b3a; }
.flash.err{ color:var(--danger); }

/* ===== Responsive ===== */
@media (max-width: 1024px){
  .grid{ grid-template-columns:1fr; }
}

/* ===== Print ===== */
@media print{
  .topbar, .action-bar, .tabs, .flash{ display:none !important; }
  .page{ padding:0; }
  .panel, .paper-box, .editor{ box-shadow:none; border-color:#999; }
}
</style>

<script>
  function goBack(){ history.back(); }
  function goList(){ location.href = '<c:out value="${ctx}"/>/approval/approveList'; }
  function doPrint(){ window.print(); }
</script>
</head>
<body>

<%-- 상태 텍스트를 한 번만 계산해서 전체에서 재사용 --%>
<c:set var="stateText" value="-" />
<c:choose>
  <c:when test="${doc.docStatus == 0}"><c:set var="stateText" value="작성/대기"/></c:when>
  <c:when test="${doc.docStatus == 1}"><c:set var="stateText" value="진행중"/></c:when>
  <c:when test="${doc.docStatus == 2}"><c:set var="stateText" value="완료"/></c:when>
  <c:when test="${doc.docStatus == 3}"><c:set var="stateText" value="반려"/></c:when>
  <c:when test="${doc.docStatus == 4}"><c:set var="stateText" value="회수/보류"/></c:when>
</c:choose>

<header class="topbar">
  <div class="title">업무기안</div>
  <div class="actions">
    <button class="btn btn-ghost"  type="button" onclick="goList()">목록</button>
    <button class="btn btn-ghost"  type="button" onclick="goBack()">뒤로</button>
    <button class="btn btn-primary" type="button" onclick="doPrint()">인쇄</button>
  </div>
</header>

<main class="page">
  <div class="container grid">
    <!-- ===== Left: 문서 ===== -->
    <section class="panel">
      <div class="hd">결재 상세</div>
      <div class="bd">
        <div class="paper-box">
          <!-- 문서 상단 타이틀 (EL 수정: += 제거, 안전한 분기) -->
          <h2 class="paper-title">
            <c:choose>
              <c:when test="${not empty doc.formName}">
                <c:out value="${doc.formName}"/>
              </c:when>
              <c:when test="${not empty doc.sformno}">
                양식 <c:out value="${doc.sformno}"/>
              </c:when>
              <c:otherwise>
                업무기안
              </c:otherwise>
            </c:choose>
          </h2>

          <table class="table">
            <colgroup>
              <col style="width:120px" /><col />
              <col style="width:120px" /><col />
            </colgroup>
            <tr>
              <th>문서번호</th>
              <td><span class="badge"><c:out value="${doc.signNo}"/></span></td>
              <th>긴급</th>
              <td>
                <c:choose>
                  <c:when test="${doc.emergency == 1}"><span class="badge red">긴급</span></c:when>
                  <c:otherwise>일반</c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <th>기안일</th>
              <td>
                <c:choose>
                  <c:when test="${not empty doc.draftAt}">
                    <fmt:formatDate value="${doc.draftAt}" pattern="yyyy-MM-dd HH:mm"/>
                  </c:when>
                  <c:otherwise>-</c:otherwise>
                </c:choose>
              </td>
              <th>완료일</th>
              <td>
                <c:choose>
                  <c:when test="${not empty doc.completeAt}">
                    <fmt:formatDate value="${doc.completeAt}" pattern="yyyy-MM-dd HH:mm"/>
                  </c:when>
                  <c:otherwise>-</c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <th>상태</th>
              <td colspan="3"><c:out value="${stateText}"/></td>
            </tr>
            <tr>
              <th>제목</th>
              <td colspan="3"><c:out value="${doc.title}"/></td>
            </tr>
          </table>

          <!-- 본문 -->
          <div class="editor">
            <c:choose>
              <c:when test="${not empty doc.signcontent}">
                <c:out value="${doc.signcontent}" escapeXml="false"/>
              </c:when>
              <c:otherwise>
                <div class="muted">본문 내용이 없습니다.</div>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- 승인/반려 액션 -->
          <div class="action-bar">
            <form id="actForm" action="${ctx}/approval/line/act" method="post" class="action-form">
              <c:if test="${not empty _csrf}">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
              </c:if>
              <input type="hidden" name="signNo" value="${doc.signNo}" />
              <input type="text"   name="comment" placeholder="결재 의견(선택)">
              <button type="submit" name="action" value="approve" class="btn btn-ok"
                      onclick="return confirm('승인하시겠습니까?');">승인</button>
              <button type="submit" name="action" value="reject" class="btn btn-cancel"
                      onclick="return confirm('반려하시겠습니까?');">반려</button>
            </form>
          </div>

          <c:if test="${not empty msg}">
            <div class="flash ok" role="status" aria-live="polite">${msg}</div>
          </c:if>
          <c:if test="${not empty error}">
            <div class="flash err" role="alert" aria-live="assertive">${error}</div>
          </c:if>
        </div>
      </div>
    </section>

    <!-- ===== Right: 정보/결재선/참조자 ===== -->
    <aside class="panel">
      <div class="tabs">
        <a class="on" href="javascript:void(0)">문서정보</a>
      </div>
      <div class="bd">
        <div class="info-card" style="margin-bottom:16px;">
          <div class="info-grid">
            <div>문서번호</div>
            <div><span class="badge"><c:out value="${doc.signNo}"/></span></div>

            <div>양식번호</div>
            <div><c:out value="${doc.sformno}"/></div>

            <div>상태</div>
            <div><c:out value="${stateText}"/></div>

            <div>긴급여부</div>
            <div>
              <c:choose>
                <c:when test="${doc.emergency == 1}"><span class="badge red">긴급</span></c:when>
                <c:otherwise>일반</c:otherwise>
              </c:choose>
            </div>

            <div>기안일</div>
            <div>
              <c:choose>
                <c:when test="${not empty doc.draftAt}">
                  <fmt:formatDate value="${doc.draftAt}" pattern="yyyy-MM-dd HH:mm"/>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </div>

            <div>완료일</div>
            <div>
              <c:choose>
                <c:when test="${not empty doc.completeAt}">
                  <fmt:formatDate value="${doc.completeAt}" pattern="yyyy-MM-dd HH:mm"/>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

        <div style="margin-bottom:16px;">
          <div style="font-weight:700; margin:2px 0 8px;">결재선</div>
          <div class="pills">
            <c:choose>
              <c:when test="${empty lines}">
                <div class="muted">결재선 정보가 없습니다.</div>
              </c:when>
              <c:otherwise>
                <c:forEach var="ln" items="${lines}">
                  <div class="pill">
                    <div>
                      <strong><c:out value="${ln.orderSeq}"/>차</strong>
                      &nbsp;<c:out value="${ln.approverName}"/>
                      <span class="meta">/ 부서: <c:out value="${ln.approverDept}"/></span>
                    </div>
                    <div class="meta">
                      <c:choose>
                        <c:when test="${ln.routeStatus == 1}">승인</c:when>
                        <c:when test="${ln.routeStatus == 2}">반려</c:when>
                        <c:when test="${ln.routeStatus == 3}">보류</c:when>
                        <c:otherwise>대기</c:otherwise>
                      </c:choose>
                      <c:if test="${not empty ln.actionAt}">
                        &nbsp;·&nbsp;<fmt:formatDate value="${ln.actionAt}" pattern="yyyy-MM-dd HH:mm"/>
                      </c:if>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <div>
          <div style="font-weight:700; margin:2px 0 8px;">참조자</div>
          <div class="pills">
            <c:choose>
              <c:when test="${empty refs}">
                <div class="muted">참조자가 없습니다.</div>
              </c:when>
              <c:otherwise>
                <c:forEach var="rf" items="${refs}">
                  <div class="pill">
                    <div><c:out value="${rf.approverName}"/></div>
                    <div class="meta">부서: <c:out value="${rf.approverDept}"/></div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </aside>
  </div>
</main>
</body>
</html>
