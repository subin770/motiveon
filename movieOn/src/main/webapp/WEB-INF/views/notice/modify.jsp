<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice/modify_css.css" />

 <div class="container">
    <h2>글 수정</h2>

    <div class="button-group-top">
      <button type="submit" form="modifyForm" class="submit-btn">수정</button>
      <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
    </div>

    <div class="form-box">
      <form id="modifyForm" method="post" action="<%=request.getContextPath() %>/notice/modifyPost" enctype="multipart/form-data">
        <input type="hidden" name="nno" value="${notice.nno}" />
        <input type="hidden" name="eno" value="${notice.eno}" />
        <input type="hidden" name="dno" value="${notice.dno}" />

        <div class="form-row" style="display: flex; align-items: center;">
          <label style="margin-right: 0px;">제목</label>
          <input type="text" name="title" value="${notice.title}" required style="flex: 1; margin-right: 10px;">
          <label style="display: flex; align-items: center;">
            <input type="checkbox" name="fixed" value="1" ${notice.fixed == 1 ? 'checked' : ''} style="margin-right: 5px;" />
            상단고정
          </label>
        </div>

        <div class="form-row">
          <label>작성자</label>
          <input type="text" value="${notice.ename}" readonly />
        </div>

        <div class="form-row">
          <label>내용</label>
          <textarea name="content" required>${notice.content}</textarea>
        </div>

        <div class="form-row">
          <label>첨부파일</label>
          <input type="file" name="uploadFile" />
        </div>

        <c:if test="${not empty notice.filename}">
          <div class="file-box">
            <img src="${pageContext.request.contextPath}/resources/icons/file.png" alt="첨부" />
            <span>${notice.filename}</span>
          </div>
        </c:if>

      </form>
    </div>
  </div>

