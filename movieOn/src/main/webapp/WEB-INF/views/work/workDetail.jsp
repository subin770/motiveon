<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h3 class="card-title mb-0">업무 상세</h3>
    <div>
      <!-- 승인 -->
      <form action="${cpath}/work/approve" method="post" class="d-inline">
        <input type="hidden" name="wcode" value="${work.wcode}">
        <button class="btn btn-success btn-sm">승인</button>
      </form>
      <!-- 이의신청 모달 오픈 -->
      <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#objModal">이의신청</button>
      <a href="${cpath}/work/my" class="btn btn-secondary btn-sm">목록</a>
    </div>
  </div>

  <div class="card-body">
    <dl class="row">
      <dt class="col-sm-2">제목</dt>
      <dd class="col-sm-10">${work.wtitle}</dd>

      <dt class="col-sm-2">담당자</dt>
      <dd class="col-sm-10">${work.eno}</dd>

      <dt class="col-sm-2">기한</dt>
      <dd class="col-sm-10">
        <fmt:formatDate value="${work.wend}" pattern="yyyy-MM-dd"/>
      </dd>

      <dt class="col-sm-2">상태</dt>
      <dd class="col-sm-10">${work.wstatus}</dd>

      <dt class="col-sm-2">내용</dt>
      <dd class="col-sm-10">
        <!-- Summernote HTML 렌더링 -->
        <c:out value="${work.wcontent}" escapeXml="false"/>
      </dd>
    </dl>
  </div>
</div>

<!-- 이의신청 모달 -->
<div class="modal fade" id="objModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="${cpath}/work/objection" method="post">
        <input type="hidden" name="wcode" value="${work.wcode}">
        <div class="modal-header">
          <h5 class="modal-title">이의신청</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label>이의유형</label>
            <select name="type" class="form-control">
              <option>업무관련</option>
              <option>일정관련</option>
              <option>기타</option>
            </select>
          </div>
          <div class="form-group">
            <label>내용</label>
            <textarea name="content" class="form-control" rows="5" required></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-danger">이의신청</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
      </form>
    </div>
  </div>
</div>
