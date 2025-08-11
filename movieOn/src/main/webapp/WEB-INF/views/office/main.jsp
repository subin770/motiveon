<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>MY 오피스</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="<%=ctx%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="<%=ctx%>/resources/bootstrap/dist/css/adminlte.min.css">

<style>
/* --- 전체 높이 & 스크롤 --- */
html, body, .wrapper, .content-wrapper {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
}

.content-wrapper {
	display: flex;
	flex-direction: column;
}

.content {
	flex: 1 1 auto;
	display: flex;
}

.content>.container-fluid {
	flex: 1 1 auto;
	display: flex;
	flex-direction: column;
}

.content>.container-fluid>.row {
	flex: 1 1 auto;
}

.content .card, .content .card>.card-body {
	height: 100%;
}

.content .card>.card-body {
	overflow: auto;
}

/* 타이틀 */
.page-title {
	padding-left: 20px;
	margin-top: 10px;
	font-size: 18px;
	font-weight: 600;
}

/* 전체 배경 흰색 */
body, .content-wrapper, .main-header, .main-footer {
	background-color: #ffffff !important;
}

.card, .box, .content {
	background-color: #ffffff !important;
}

/* 좌우 여백 */
.myoffice-container {
	padding-left: 15px;
	padding-right: 15px;
}

/* 좌측 흰띠 제거 */
.content-wrapper {
	margin-left: 0 !important;
}

/* 트리 */
.tree-node.active {
	background: #ffffff;
	border-radius: 6px;
}

.tree-node[data-id="root"] {
	padding: 15px 0 10px 20px;
	margin-left: 10px;
}

/* 패널 비어있을 때 */
#listPanel .empty, #detailPanel .empty {
	color: #9aa0a6;
}

/* 툴바 */
.file-toolbar {
	position: sticky;
	top: 0;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 8px;
	padding: 2px 16px 2px;
	background: #fff;
	border-bottom: 1px solid #e5e7eb;
	z-index: 10;
}

.btn-soft {
	background: #ffffff;
	border: 1px solid #ffffff;
	color: #5f6573;
	border-radius: 6px;
	font-weight: 600;
}

.btn-soft:hover {
	background: #f5f5f5;
	border-color: #f5f5f5;
}

.btn-soft i {
	margin-right: 6px;
}

/* 모달 스타일 */
.modal-sm .modal-content {
	border-radius: 6px;
}

.modal-header, .modal-footer {
	padding: 10px 15px;
}

.modal-body {
	padding: 15px;
}

/* 모달 가로 너비 늘리기 */
#modalNewFolder .modal-dialog {
	max-width: 400px; /* 기본 sm보다 넓게 */
}

/* 글씨 크기 줄이기 */
#modalNewFolder .modal-header {
	display: flex;
	align-items: center;
	padding-top: 8px;
	padding-bottom: 8px;
}

#modalNewFolder .modal-title {
	margin: 0;
	line-height: 1.4;
	font-size: 15px;
}

#modalNewFolder label {
	font-size: 14px;
}

#modalNewFolder .form-control {
	font-size: 13px;
}

#modalNewFolder .btn {
	font-size: 12px;
	padding: 4px 10px; /* 버튼 높이도 조금 줄임 */
}
</style>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<div class="content-wrapper">

			<!-- 상단 타이틀 -->
			<section class="content-header">
				<div class="container-fluid myoffice-container">
					<h3 class="page-title">MY 오피스</h3>
				</div>
			</section>

			<section class="content">
				<div class="container-fluid myoffice-container">

					<!-- 툴바 -->
					<div class="file-toolbar">
						<button id="btnNewFolder" class="btn btn-sm btn-soft"
							type="button">
							<i class="fas fa-folder-plus"></i> 새 폴더
						</button>
						<button id="btnNewFile" class="btn btn-sm btn-soft" type="button">
							<i class="far fa-file-alt"></i> 파일 작성
						</button>
						<button id="btnTrash" class="btn btn-sm btn-soft" type="button">
							<i class="fas fa-trash-alt"></i> 휴지통
						</button>
					</div>

					<!-- 메인 3분할 -->
					<div class="row">
						<!-- 좌: 트리 -->
						<div class="col-12 col-lg-3">
							<div class="card">
								<div class="card-body p-2" id="treePanel">
									<!-- filled by JS -->
								</div>
							</div>
						</div>

						<!-- 중: 목록 -->
						<div class="col-12 col-lg-6">
							<div class="card">
								<div class="card-body" id="listPanel">
									<!-- filled by JS -->
								</div>
							</div>
						</div>

						<!-- 우: 상세 -->
						<div class="col-12 col-lg-3">
							<div class="card">
								<div class="card-body" id="detailPanel">
									<!-- filled by JS -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

		</div>
	</div>

	<!-- 새 폴더 생성 모달 -->
	<div class="modal fade" id="modalNewFolder" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title font-weight-bold">새 폴더 생성</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="닫기">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="newFolderName" class="font-weight-bold">폴더 이름</label>
						<input type="text" id="newFolderName" class="form-control"
							placeholder="내용을 입력해주세요.">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-sm"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary btn-sm"
						id="createFolderBtn">생성</button>
				</div>
			</div>
		</div>
	</div>

	<script src="<%=ctx%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	<script
		src="<%=ctx%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="<%=ctx%>/resources/bootstrap/dist/js/adminlte.min.js"></script>

	<script>
		// 초기 상태: 루트만 표시, 목록/상세는 비어있음
		var currentFolderId = 'root';

		$(function() {
			loadTree();
			showEmptyList();
			showEmptyDetail();
		});

		// 좌측 트리(루트만)
		function loadTree() {
			var html = ''
        + '<div class="tree-node d-flex align-items-center active"'
        + ' data-id="root" style="cursor:default;">'
        + '  <i class="fas fa-desktop mr-2"></i><span>MY 오피스</span>'
        + '</div>';
			$('#treePanel').html(html);
		}

		// 가운데: 빈 상태
		function showEmptyList() {
			$('#listPanel').html(
        '<div class="empty">폴더가 없습니다. 우측 상단의 <b>새 폴더</b>로 추가하세요.</div>'
      );
		}

		// 오른쪽: 빈 상태
		function showEmptyDetail() {
			$('#detailPanel').html(
        '<div class="empty">항목을 선택하면 상세정보가 표시됩니다.</div>'
      );
		}

		// 새 폴더 버튼 클릭 → 모달 열기
		$('#btnNewFolder').on('click', function () {
		  $('#newFolderName').val('');
		  $('#modalNewFolder').modal('show');
		  setTimeout(()=> $('#newFolderName').trigger('focus'), 200);
		});

		// 생성 버튼 클릭
		$('#createFolderBtn').on('click', function () {
  const name = $('#newFolderName').val().trim();
  if (!name) {
    $('#newFolderName').focus();
    return;
  }

  $.ajax({
    url: '<%=ctx%>/office/folder/create',
    type: 'POST',
    contentType: 'application/json',
    data: JSON.stringify({ folderName: name }),
    success: function (res) {
      if (res === 'OK') {
        $('#modalNewFolder').modal('hide');
        loadTree(); // DB 다시 조회해서 트리 갱신
      } else {
        alert('폴더 생성 실패');
      }
    },
    error: function () {
      alert('서버 오류');
    }
  });
});


		// 엔터 입력 시 생성
		$('#newFolderName').on('keydown', function (e) {
		  if (e.key === 'Enter') $('#createFolderBtn').click();
		});

		// 나머지 버튼 클릭 로그
		$('#btnNewFile').on('click', () => console.log('파일 작성 클릭'));
		$('#btnTrash').on('click', () => console.log('휴지통 클릭'));
	</script>
</body>
</html>
