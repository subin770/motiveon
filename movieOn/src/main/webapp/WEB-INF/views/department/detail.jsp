<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<body>
    <section class="content-header">
        <div class="container-fluid">
            <div class="row md-2">
                <div class="col-sm-6">
                    <h1>부서 상세보기</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item" style="color: blue;">부서관리</li>
                        <li class="breadcrumb-item active">상세보기</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>

    <section class="content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card card-outline card-info">
                    <div class="card-header">
                        <h3 class="card-title">상세보기</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-warning" onclick="modify();">수 정</button>
                            <button type="button" class="btn btn-danger" onclick="remove();">삭 제</button>
                            <button type="button" class="btn btn-primary" onclick="CloseWindow();">닫 기</button>
                        </div>
                    </div>
                  <div class="card-body">
    <div class="row">
        <div class="form-group col-sm-4">
            <label>부서코드</label>
            <span class="form-control">${department.dno}</span>
        </div>
        <div class="form-group col-sm-8">
            <label>부서명</label>
            <span class="form-control">${department.name}</span>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-sm-4">
            <label>부서장</label>
            <span class="form-control">${department.manager}</span>
        </div>
        <div class="form-group col-sm-4">
            <label>부서원수</label>
            <span class="form-control">${department.memberCount}</span>
        </div>
        <div class="form-group col-sm-4">
            <label>생성일</label>
            <span class="form-control">
                <fmt:formatDate value="${department.createDate}" pattern="yyyy-MM-dd"/>
            </span>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-sm-4">
            <label>입사율(%)</label>
            <span class="form-control">${department.joinRate}</span>
        </div>
        <div class="form-group col-sm-4">
            <label>퇴사율(%)</label>
            <span class="form-control">${department.leaveRate}</span>
        </div>
        <div class="form-group col-sm-4">
            <label>부서상태</label>
            <span class="form-control">
                <c:choose>
                    <c:when test="${department.enabled == 1}">활성</c:when>
                    <c:otherwise>비활성</c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>
</div>
                </div>
                <!-- end card -->
            </div>
        </div>
    </section>

    <script>
        function modify() {
            location.href = "modify?dno=${department.dno}";
        }

        function remove() {
            location.href = "remove?dno=${department.dno}";
        }
    </script>
</body>