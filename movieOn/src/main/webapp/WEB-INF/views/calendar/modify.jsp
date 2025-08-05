<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 일정 수정 모달 -->
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">

      <!-- 모달 헤더 -->
      <div class="modal-header">
        <h5 class="modal-title font-weight-bold">일정 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <!-- 모달 바디 -->
      <div class="modal-body">
        <form id="modifyForm">
          <input type="hidden" name="ccode" id="modify_ccode" value="${calendar.ccode}" />

          <div class="form-group">
            <label>제목</label>
            <input type="text" class="form-control" id="modify_title" name="title" value="${calendar.title}" />
          </div>

          <div class="form-group">
            <label>기간</label>
            <div class="d-flex">
              <input type="datetime-local" class="form-control mr-2" id="modify_sdate" name="sdate"
                     value="${calendar.sdate}">
              <input type="datetime-local" class="form-control" id="modify_edate" name="edate"
                     value="${calendar.edate}">
            </div>
          </div>

          <div class="form-group">
            <label>일정 분류</label>
            <select class="form-control" name="catecode" id="modify_catecode" disabled>
              <option value="1" <c:if test="${calendar.catecode == 1}">selected</c:if>>회사일정</option>
              <option value="2" <c:if test="${calendar.catecode == 2}">selected</c:if>>부서일정</option>
              <option value="3" <c:if test="${calendar.catecode == 3}">selected</c:if>>개인일정</option>
            </select>
          </div>

          <div class="form-group">
            <label>장소</label>
            <input type="text" class="form-control" id="modify_space" name="space" value="${calendar.space}" />
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" id="modify_content" name="content" rows="5">${calendar.content}</textarea>
          </div>
        </form>
      </div>

      <!-- 모달 푸터 -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="submitModify()">완료</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
