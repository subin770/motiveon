<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<!-- Main content -->
		<section class="content">
			<div class="card">

				<div class="card-header with-border" style="text-align: right;">
					<h3
						style="text-align: left; padding-left: 20px; margin-top: 10px; font-size: 18px; font-weight: 600;">조직도
						관리</h3>
					<button type="button" class="btn btn-primary"
						onclick="OpenWindow('regist','부서 추가',700,800);">부서 추가</button>
					<button type="button" class="btn btn-danger"
						onclick="deleteSelected()">삭제</button>
				</div>

				<div class="card-body">
					<table class="table table-bordered table-striped text-center"
						id="departmentTable">
						<thead>
							<tr>
								<th><input type="checkbox" id="allCheck"
									onclick="toggleAll(this)"></th>
								<th>부서코드</th>
								<th>부서명</th>
								<th>부서장</th>
								<th>부서원수</th>
								<th>입사율(%)</th>
								<th>퇴사율(%)</th>
								<th>부서상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty departmentList}">
								<tr>
									<td colspan="8">해당 내용이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty departmentList}">
								<c:forEach items="${departmentList}" var="dept">
									<tr
										onclick="OpenWindow('detail?dno=${dept.dno}','부서 상세',700,800);"
										style="cursor: pointer;">
										<td
											onclick="toggleCheckbox(this, event); event.stopPropagation();">
											<input type="checkbox" name="deptNos" value="${dept.dno}"
											onclick="event.stopPropagation();">
										</td>
										<td>${dept.dno}</td>
										<td>${dept.name}</td>
										<td><c:choose>
												<c:when test="${not empty dept.managerName}">
            										${dept.managerName} (${dept.managerPosition})
        										</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose></td>
										<td>${dept.memberCount}</td>
										<td>${dept.joinRate}</td>
										<td>${dept.leaveRate}</td>
										<td><c:choose>
												<c:when test="${dept.enabled == 1}">활성</c:when>
												<c:otherwise>비활성</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
						
					</table>
				</div>

				<div class="card-footer text-center">
					<%@ include file="/WEB-INF/views/module/pagination.jsp"%>
				</div>

			</div>
		</section>
	</div>

	<script>
function toggleAll(source) {
    const checkboxes = document.getElementsByName('deptNos');
    for(let i=0; i<checkboxes.length; i++) {
      checkboxes[i].checked = source.checked;
    }
}

function toggleCheckbox(td) {
    const checkbox = td.querySelector('input[type="checkbox"]');
    if (checkbox) checkbox.checked = !checkbox.checked;
}

function deleteSelected() {
	  const checked = document.querySelectorAll('input[name="deptNos"]:checked');
	  if (checked.length === 0) {
	    alert("삭제할 항목을 선택하세요.");
	    return;
	  }
	  
	  const deptNos = Array.from(checked).map(cb => cb.value);
	  
	  if (confirm("정말 삭제하시겠습니까?")) {
	    // 단일 삭제면 deptNos[0]만 전달
	    //location.href = 'remove?deptNos=' + popNos[0];
	    
	    // 다중 삭제 처리 원하면
	    location.href = 'removeSelected?deptNos=' + deptNos.join(',');
	  }
}
</script>
</body>