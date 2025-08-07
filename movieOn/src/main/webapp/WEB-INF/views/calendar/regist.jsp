<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 일정 등록 모달 -->
<div class="modal fade" id="eventModal" tabindex="-1" role="dialog"
	aria-labelledby="eventModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document" style="max-width: 600px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title font-weight-bold" id="eventModalLabel">일정
					등록</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<!-- 일정명 -->
				<div class="form-group row">
					<label class="col-sm-3 col-form-label">일정명</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="eventTitle"
							placeholder="일정명을 입력하세요.">
					</div>
				</div>

				<!-- 일정 분류 -->
				<div class="form-group row">
					<label class="col-3 col-form-label">일정분류</label>
					<div class="col-9 d-flex align-items-center">
						<div class="form-check form-check-inline mb-0">
							<input class="form-check-input" type="radio" name="eventType"
								id="type1" value="C"> <label class="form-check-label"
								for="type1">회사일정</label>
						</div>
						<div class="form-check form-check-inline mb-0">
							<input class="form-check-input" type="radio" name="eventType"
								id="type2" value="D"> <label class="form-check-label"
								for="type2">부서일정</label>
						</div>
						<div class="form-check form-check-inline mb-0">
							<input class="form-check-input" type="radio" name="eventType"
								id="type3" value="P"> <label class="form-check-label"
								for="type3">개인일정</label>
						</div>
					</div>
				</div>

<!-- 일시 -->
<div class="form-group row">
  <label class="col-sm-3 col-form-label">일시</label>
  <div class="col-sm-9 d-flex">
    <input type="text" id="eventStart" class="form-control mr-3" style="width: 48%;" required>
    <input type="text" id="eventEnd" class="form-control" style="width: 48%;" required>
  </div>
</div>


				<!-- 내용 -->
				<div class="form-group row">
					<label class="col-sm-3 col-form-label">내용</label>
					<div class="col-sm-9">
						<textarea class="form-control" id="eventContent" rows="4"
							placeholder="일정 상세 내용을 작성하세요."></textarea>
					</div>
				</div>
			</div>

			<!-- 등록/취소 버튼 -->
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="btnSave">등록</button>
				<button type="button" class="btn btn-primary" id="btnModify"
					style="display: none;">완료</button>
			</div>

		</div>
	</div>
</div>
