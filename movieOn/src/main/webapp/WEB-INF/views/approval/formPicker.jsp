<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결재 양식 선택</title>
<style>
* {
	box-sizing: border-box
}

body {
	margin: 0;
	font-family: "Pretendard", "맑은 고딕", system-ui, -apple-system, Segoe UI,
		Roboto, sans-serif;
	color: #52586B
}

.wrap {
	width: 680px;
	margin: 0 auto;
	padding: 16px
}

.h3 {
	margin: 6px 0 12px;
	font-size: 18px;
	font-weight: 800
}

.box {
	border: 1px solid #e1e5ef;
	height: 460px;
	overflow: auto;
	padding: 12px;
	background: #fff;
	border-radius: 4px
}

.folder {
	font-weight: 800;
	margin: 12px 0 6px;
	display: flex;
	align-items: center;
	gap: 6px
}

ul.tree {
	list-style: none;
	padding-left: 18px;
	margin: 0
}

.tree li {
	margin: 6px 0
}

.tree label {
	cursor: pointer
}

.footer {
	display: flex;
	gap: 10px;
	justify-content: flex-end;
	margin-top: 12px
}

.btn {
	min-width: 92px;
	height: 40px;
	border: none;
	border-radius: 4px;
	font-weight: 700;
	cursor: pointer
}

.btn-cancel {
	background: #D75340;
	color: #fff
}

.btn-ok {
	background: #487FC3;
	color: #fff
}

.badge {
	display: inline-block;
	padding: 2px 8px;
	border-radius: 999px;
	background: #eef2ff;
	font-size: 12px
}

.muted {
	color: #8b90a0
}
</style>
<script>
  // /approval/compose의 절대경로 (컨텍스트 포함)
  const composeUrl = '<c:url value="/approval/compose"/>';
  function selectForm() {
    const picked = document.querySelector('input[name="formNo"]:checked');
    if (!picked) { alert('양식을 선택해 주세요.'); return; }
    const formNo = picked.value;
    if (window.opener && !window.opener.closed) {
      window.opener.location.href = composeUrl + '?sformno=' + encodeURIComponent(formNo);
    }
    window.close();
  }
</script>

</head>
<body>
	<div class="context-wrap">
		<div class="h3">
			결재 양식 선택 
		</div>

		<!-- 1. 결재 양식 목록(클래스별) / 2. 결재 양식 선택(radio) -->
		<div class="box">
			<c:choose>
				<c:when test="${not empty classes}">
					<c:forEach var="cls" items="${classes}">
						<div class="folder">
							📁
							<c:out value="${cls.CLASSNAME}" />
						</div>
						<ul class="tree">
							<!-- formsAll 에서 같은 CLASSID만 출력 -->
							<c:set var="hasForm" value="false" />
							<c:forEach var="f" items="${formsAll}">
								<c:if test="${f.CLASSID == cls.CLASSID}">
									<c:set var="hasForm" value="true" />
									<li><label> <input type="radio" name="formNo"
											value="${f.SFORMNO}"> <span><c:out
													value="${f.FORMNAME}" /></span>
									</label></li>
								</c:if>
							</c:forEach>
							<c:if test="${!hasForm}">
								<li class="muted">등록된 양식이 없습니다.</li>
							</c:if>
						</ul>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<!-- 클래스 정보가 없으면 전체 목록을 평면으로 표시 -->
					<div class="muted" style="margin-bottom: 8px">클래스 정보가 없어 전체
						목록을 표시합니다.</div>
					<ul class="tree">
						<c:forEach var="f" items="${formsAll}">
							<li><label> <input type="radio" name="formNo"
									value="${f.SFORMNO}"> <span><c:out
											value="${f.FORMNAME}" /></span> <span class="badge">CLASS
										${f.CLASSID}</span>
							</label></li>
						</c:forEach>
						<c:if test="${empty formsAll}">
							<li class="muted">표시할 양식이 없습니다.</li>
						</c:if>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- 3. 취소 / 4. 선택 -->
		<div class="footer">
			<button type="button" class="btn btn-cancel" onclick="cancelPicker()">취소</button>
			<button type="button" class="btn btn-ok" onclick="selectForm()">선택</button>
		</div>
	</div>
	
	
</body>
</html>
