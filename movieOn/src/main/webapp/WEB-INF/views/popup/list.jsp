<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<body class="hold-transition sidebar-mini">
	<div class="wrapper">


		<!-- Main content -->
		<section class="content">
			<div class="card">

				<div class="card-header with-border" style="text-align: right;">
					<h3
						style="text-align: left; padding-left: 20px; margin-top: 10px; font-size: 18px; font-weight: 600;">팝업
						공지</h3>
					<button type="button" class="btn btn-primary" id="registBtn"
						onclick="OpenWindow('regist','등록',700,800);">등 록</button>
			<button type="button" class="btn btn-danger" onclick="deleteSelected()">삭 제</button>
				</div>
				<div class="card-body">
					<table class="table table-bordered table-striped text-center"
						id="popupTable">
						<thead>
							<tr style="font-size: 0.95em;">
								<th><input type="checkbox" id="allCheck"
									onclick="toggleAll(this)"></th>

								<th style="width: 10%;">번 호</th>
								<th style="width: 15%;">제 목</th>

								<th style="width: 40%;">내 용</th>
								<th>공지 마감일</th>
								<th style="width: 10%;">상 태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty popUpList}">
								<tr>
									<td colspan="5">해당내용이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty popUpList}">
								<c:forEach items="${popUpList}" var="popup">
									<tr
										onclick="OpenWindow('detail?popNo=${popup.popNo}','공지 상세',700,800);"
										style="cursor: pointer;">
										<td
										onclick="toggleCheckbox(this, event); event.stopPropagation();"><input type="checkbox" name="popNos"
											value="${popup.popNo}" onclick="event.stopPropagation();">
										</td>

										<td>${popup.popNo}</td>
										<td
											style="text-align: left; max-width: 100px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
											${popup.title}</td>
										<td
											style="text-align: left; max-width: 250px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
											${popup.content}</td>
										<td><fmt:formatDate value="${popup.deadLine}"
												pattern="yyyy-MM-dd" /></td>
										<td><c:choose>
												<c:when test="${popup.enabled == 1}">활성</c:when>
												<c:otherwise>비활성</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="card-footer">
					<!-- pagination.jsp -->
					<div style="display:${not empty popupList ? 'visible':'none' };">
						<%@ include file="/WEB-INF/views/module/pagination.jsp"%>
					</div>
				</div>
			</div>
		</section>
	</div>






	<script>
MemberPictureBackground("<%=request.getContextPath()%>
		");
	</script>

	<script>
		$(".person-info").css({
			"display" : "block",
			"width" : "30px",
			"height" : "30px",
			"border-radius" : "10px"
		});
		$('#noticeTable td').css({
			"padding" : "5px",
			"line-height" : "40px"
		});
	</script>

	<script>
  function toggleAll(source) {
    const checkboxes = document.getElementsByName('popNos');
    for(let i=0; i<checkboxes.length; i++) {
      checkboxes[i].checked = source.checked;
    }
  }
  

  function toggleCheckbox(td) {
    const checkbox = td.querySelector('input[type="checkbox"]');
    if (checkbox) {
      checkbox.checked = !checkbox.checked;
    }
  }
  
  function deleteSelected() {
      const checked = document.querySelectorAll('input[name="popNos"]:checked');
      if (checked.length === 0) {
        alert("삭제할 항목을 선택하세요.");
        return;
      }

      const popNos = Array.from(checked).map(cb => cb.value);

      if (confirm("정말 삭제하시겠습니까?")) {
        // 단일 삭제면 popNos[0]만 전달
        //location.href = 'remove?popNo=' + popNos[0];

        // 다중 삭제 처리 원하면
        location.href = 'removeSelected?popNos=' + popNos.join(',');
      }
    }
</script>

</body>




