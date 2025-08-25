<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>계정 수정</title>
</head>

<body>
<section class="content container-fluid">
    <div class="card card-outline card-info">
        <div class="card-header">
            <h3 class="card-title">계정 정보 수정</h3>
        </div>
        <div class="card-body">
            <form id="modifyForm" method="post" action="modify">
                <!-- 사번(hidden) -->
                <input type="hidden" name="empNo" value="${account.empNo}" />

                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" class="form-control" value="${account.name}" required>
                </div>

                <div class="form-group">
                    <label for="deptName">소속</label>
                    <input type="text" id="deptName" name="deptName" class="form-control" value="${account.deptName}">
                </div>

                <div class="form-group">
                    <label for="ppsName">직위</label>
                    <input type="text" id="ppsName" name="ppsName" class="form-control" value="${account.ppsName}">
                </div>

                <div class="form-group">
                    <label for="job">직책</label>
                    <input type="text" id="job" name="job" class="form-control" value="${account.job}">
                </div>

                <div class="form-group">
                    <label for="role">권한</label>
                    <input type="text" id="role" name="role" class="form-control" value="${account.role}">
                </div>

                <div class="form-group">
                    <label for="enabled">계정상태</label>
                    <select id="enabled" name="enabled" class="form-control">
                        <option value="1" <c:if test="${account.enabled == 1}">selected</c:if>>정상</option>
                        <option value="0" <c:if test="${account.enabled == 0}">selected</c:if>>퇴사</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="safety">안전여부</label>
                    <select id="safety" name="safety" class="form-control">
                        <option value="안전" <c:if test="${account.safety == '안전'}">selected</c:if>>안전</option>
                        <option value="경고" <c:if test="${account.safety == '경고'}">selected</c:if>>경고</option>
                        <option value="취약" <c:if test="${account.safety == '취약'}">selected</c:if>>취약</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="joinDate">입사일</label>
                    <input type="date" id="joinDate" name="joinDate" class="form-control"
                        value="<fmt:formatDate value='${account.joinDate}' pattern='yyyy-MM-dd'/>">
                </div>

                <div class="form-group">
                    <label for="leaveDate">퇴사일</label>
                    <input type="date" id="leaveDate" name="leaveDate" class="form-control"
                        value="<fmt:formatDate value='${account.leaveDate}' pattern='yyyy-MM-dd'/>">
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">수정</button>
                    <button type="button" class="btn btn-default" onclick="history.back();">취소</button>
                </div>
            </form>
        </div>
    </div>
</section>
</body>