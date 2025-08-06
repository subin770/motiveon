<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 일정 상세 모달 -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
	aria-labelledby="detailModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 500px;" role="document">

		<div class="modal-content">

			<!-- 모달 헤더 -->
			<div class="modal-header">
				<h5 class="modal-title font-weight-bold">일정 상세</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="닫기">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<!-- 모달 바디 -->
			<div class="modal-body">

				<!-- 일정 제목 + 분류 -->
				<p class="font-weight-bold" style="font-size: 18px;">
					<b id="detail-title"></b> <span id="detail-category"></span> <b
						id="detail-title"></b> <small style="color: #7f8c8d;"> <span
						id="detail-category"></span>
					</small>

				</p>

				<!-- 일정 기간 -->
				<p class="text-muted mb-4" style="font-size: 14px;">
					<span id="detail-date">2025.08.07 15:05 ~ 2025.08.27 17:09</span>
				</p>

				<!-- 내용 영역 -->
				<div class="border rounded p-3"
					style="min-height: 150px; background-color: #fff;">
					<span id="detail-content">일정 내용 표시 영역</span>
				</div>
			</div>

			<!-- 모달 푸터 -->
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-primary" id="btnUpdate">수정</button>
				<button type="button" class="btn btn-danger" id="btnDelete">삭제</button>
			</div>

		</div>
	</div>
</div>