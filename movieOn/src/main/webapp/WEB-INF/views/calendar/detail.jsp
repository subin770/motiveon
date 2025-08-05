<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상세 모달 -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      
      <!-- 모달 헤더 -->
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">일정 상세</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <!-- 모달 바디 -->
      <div class="modal-body">
        <div class="form-group">
          <label>일정명</label>
          <p class="form-control-plaintext font-weight-bold">${calendar.title}</p>
        </div>

        <div class="form-group">
          <label>일정 분류</label>
          <p class="form-control-plaintext">
            <c:choose>
              <c:when test="${calendar.catecode == 'COM'}">회사일정</c:when>
              <c:when test="${calendar.catecode == 'DEPT'}">부서일정</c:when>
              <c:otherwise>개인일정</c:otherwise>
            </c:choose>
          </p>
        </div>

        <div class="form-group">
          <label>일시</label>
          <p class="form-control-plaintext">
            ${calendar.sdate} ~ ${calendar.edate}
            <c:if test="${calendar.allday == 'Y'}"> (종일)</c:if>
          </p>
        </div>

        <div class="form-group">
          <label>내용</label>
          <div class="border rounded p-2" style="min-height: 100px;">
            <c:out value="${calendar.content}" />
          </div>
        </div>
      </div>
      
      <!-- 모달 푸터 -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="location.href='<c:url value='/calendar/modifyForm?ccode=${calendar.ccode}' />'">수정</button>
        <button type="button" class="btn btn-danger" onclick="deleteCalendar('${calendar.ccode}')">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 삭제 스크립트 -->
<script>
  function deleteCalendar(ccode) {
    if (confirm("정말 삭제하시겠습니까?")) {
      location.href = "<c:url value='/calendar/delete?ccode=' />" + ccode;
    }
  }

  // 페이지 진입 시 자동 모달 표시
  $(document).ready(function() {
    $('#detailModal').modal('show');
  });
</script>
