<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Calendar Main</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/plugins/fullcalendar/main.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">
	<!-- Flatpickr CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	

<style>
.fc .fc-col-header-cell-c {
	color: #52586B;
}

.fc-day-sun a, .fc-day-sun {
	color: red !important;
}

.fc-day-sat a, .fc-day-sat {
	color: blue !important;
}

.fc-day-mon a, .fc-day-tue a, .fc-day-wed a, .fc-day-thu a, .fc-day-fri a
	{
	color: #52586B !important;
}

.fc-holiday {
	background-color: #f00000 !important;
	color: #ffffff !important;
	font-weight: bold;
}

/* 버튼 스타일 */
#prevBtn, #nextBtn {
    font-size: 28px;
    font-weight: bold;
    color: #52586B;
    background: none;
    border: none;
    cursor: pointer;
    padding: 4px 10px;
    line-height: 1;
}

#customCalendarHeader button {
	background: none;
	border: none;
	font-size: 24px;
	font-weight: bold;
	color: #2C3E50;
	margin: 0 20px;
	cursor: pointer;
}

#customCalendarHeader {
    display: flex;
    justify-content: center;   /* 가로 중앙 정렬 */
    align-items: center;       /* 세로 중앙 정렬 */
    margin-top: 30px;
    margin-bottom: 15px;
    gap: 15px;                  /* 버튼 ↔ 제목 간격 */
}

#customTitle {
    font-size: 28px;
    font-weight: bold;
    color: #52586B;
}
.fc-daygrid-day-frame {
	min-height: 100px;
	padding: 8px;
}

.fc-daygrid-day {
	height: 170px;
}

.fc-scrollgrid-sync-table {
	table-layout: fixed;
}

#calendar, .fc-view-harness {
	min-height: 850px;
}

.fc-daygrid-day-number {
	font-size: 18px;
	font-weight: 600;
}

.fc-col-header-cell-cushion {
	font-size: 18px;
	font-weight: 600;
	color: #52586B;
	text-align: center;
	padding: 8px 0;
}

.fc-day-sun .fc-col-header-cell-cushion {
	color: red !important;
}

.fc-day-sat .fc-col-header-cell-cushion {
	color: blue !important;
}

.fc-event {
	padding: 2px 0 !important;
	font-size: 17px;
	font-weight: 400;
}

.fc-daygrid-event {
	margin: 0 !important;
	border-radius: 0 !important;
}

.fc-event.holiday-event {
	background-color: red !important;
	color: white !important;
	font-weight: 500 !important;
	font-size: 16px !important;
	border-radius: 8px !important;
	border: none !important;
	padding: 4px 8px !important;
	margin: 0 !important;
	box-shadow: none !important;
	outline: none !important;
	overflow: hidden !important;
}

.input-group {
	width: 300px;
	height: 60px;
}

.input-group .form-control {
	height: 42px;
	font-size: 15px;
	padding: 10px 15px;
}

.input-group .input-group-append .btn {
	height: 42px;
	width: 45px;
	padding: 0;
}

.fc-event {
	border-radius: 8px !important; /* ← 라운딩 */
	padding-left: 6px !important; /* ← 왼쪽 여백 */
	font-weight: 400;
}

.fc-event-title {
	padding-left: 6px;
}

.flatpickr-time .flatpickr-am-pm {
  all: unset !important; /* 내부 스타일 싹 지움 */
  font-size: 10px !important;
  font-weight: normal !important;
  padding: 2px 4px !important;
  margin-left: 4px !important;
  line-height: 1 !important;
  color: #333 !important;
  background: none !important;
  border: none !important;
}
/* SweetAlert2 본문 텍스트 스타일 */
.swal2-html-container {
  font-weight: bold !important;
  font-size: 22px !important; /* 크기 조절 */
}

.swal2-bold-button {
  font-weight: bold !important;
  font-size: 16px !important; /* 버튼 글씨 크기 */
  padding: 8px 20px !important;
}
.swal2-delete-button {
  background-color: #e74c3c !important; /* 빨간색 */
  color: white !important;
  font-weight: bold !important;
  font-size: 16px !important;
  padding: 8px 20px !important;
}


</style>
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<div class="content-wrapper"
			style="margin-left: 0; background-color: #ffffff;">
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-1 position-relative">
						<div class="col-md-12">
							<h3 class="font-weight-bold"
								style="padding-left: 20px; margin-top: 10px; font-size: 22px;">내일정</h3>
							<!-- 검색창 form -->
							<form id="searchForm" method="GET"
								action="${pageContext.request.contextPath}/calendar/search">
								<div class="input-group"
									style="max-width: 300px; position: absolute; top: 0; right: 20px; margin-top: 95px;">
									<input type="text" class="form-control" name="keyword"
										placeholder="검색어를 입력하세요.">
									<div class="input-group-append">
										<button type="submit" class="btn"
											style="background-color: #2C3E50; color: white;">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</form>
							<!-- 검색창 form  -->
						</div>
					</div>
				</div>
			</section>

			<div id="customCalendarHeader">
				<button id="prevBtn">&lt;</button>
				<div id="customTitle"></div>
				<button id="nextBtn">&gt;</button>
			</div>

			<section class="content">
				<div class="container-fluid">
					<div class="card card-primary">
						<div class="card-body p-3">
							<div id="calendar"
								style="width: 100%; max-width: 1770px; margin: 0 auto; padding: 0 30px;"></div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>

	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.8/index.global.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.8/index.global.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@6.1.8/index.global.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.8/index.global.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
	
	


<script>
let calendar;

document.addEventListener('DOMContentLoaded', function () {
  const calendarEl = document.getElementById('calendar');
  const customTitle = document.getElementById('customTitle');

  calendar = new FullCalendar.Calendar(calendarEl, {
    locale: 'ko',
    height: 700,
    initialView: 'dayGridMonth',
    headerToolbar: false,
    selectable: true,
    eventDisplay: 'block',
    displayEventTime: false,

    // 사용자 일정 + 구글 공휴일 
    eventSources: [
      {
        // 사용자 일정 - Ajax
        events: function (fetchInfo, successCallback, failureCallback) {
          $.ajax({
            url: '<%=request.getContextPath()%>/calendar/list',
            method: 'GET',
            success: function (response) {
              const events = response.map(e => ({
                title: e.title,
                start: new Date(e.start),
                end: new Date(e.end),
                extendedProps: {
                  ccode: e.ccode,
                  catecode: e.catecode,
                  catedetail: e.catedetail,
                  content: e.content
                }
              }));
              successCallback(events);
            },
            error: function () {
              alert('일정 데이터를 불러오지 못했습니다.');
              failureCallback();
            }
          });
        }
      },
      {
        // 구글 공휴일 캘린더
        googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
        className: 'holiday-event',
        color: 'red',
        textColor: 'white'
      }
    ],

    // 구글 캘린더 API 키
    googleCalendarApiKey: 'AIzaSyAv_MkDhVG3h-GtKkehMI5bBYrOZ7B7ec0',

    // 이벤트 색상 및 조건 처리
    eventDidMount: function (info) {
      const isHoliday = info.event.source && info.event.source.className &&
                        info.event.source.className.includes('holiday-event');

      if (!isHoliday) {
        const catedetail = info.event.extendedProps.catedetail;
        let bgColor = '#8dbad7';
        if (catedetail === '부서일정') bgColor = '#f5a29f';
        else if (catedetail === '개인일정') bgColor = '#bbd89d';

        info.el.style.backgroundColor = bgColor;
        info.el.style.borderColor = bgColor;
        info.el.style.color = '#fff';
      }
    },

    datesSet: function (info) {
      const year = info.view.currentStart.getFullYear();
      const month = ('0' + (info.view.currentStart.getMonth() + 1)).slice(-2);
      customTitle.textContent = year + '.' + month;
    },

    eventClick: function (info) {
      const event = info.event;
      const catedetail = event.extendedProps.catedetail;
      const start = event.start;
      const end = event.end;

      $('#detail-title').text(event.title || '');
      $('#detail-category').text('(' + (catedetail || '') + ')');
      $('#detail-date').text(
    		  moment(start).format("YYYY.MM.DD HH:mm") +
    		  (end ? ' ~ ' + moment(end).format("YYYY.MM.DD HH:mm") : '')
    		);

      $('#detail-content').text(event.extendedProps.content || '');

      $('#btnUpdate').data('ccode', event.extendedProps.ccode);
      $('#btnDelete').data('ccode', event.extendedProps.ccode);
      $('#btnUpdate').data('catecode', event.extendedProps.catecode);

      $('#detailModal').modal('show');
    },

    select: function (info) {
      $('#eventModal .modal-title').text('일정 등록');
      $('#btnSave').show();
      $('#btnModify').hide();

      $('#eventTitle').val('');
      $('#eventStart').val(moment(info.startStr).format('YYYY-MM-DD HH:mm'));
      $('#eventEnd').val('');
      $('#eventContent').val('');
      $('input[name="eventType"]').prop('checked', false);

      $('#eventModal').modal('show');
    }
  });

  calendar.render();

  document.getElementById('prevBtn').addEventListener('click', () => calendar.prev());
  document.getElementById('nextBtn').addEventListener('click', () => calendar.next());
//카테고리 코드 → 한글 변환 함수
  function toKoreanCategory(code) {
    switch (code) {
      case 'C': return '회사일정';
      case 'D': return '부서일정';
      case 'P': return '개인일정';
      default: return code;
    }
  }

//등록
  $('#btnSave').on('click', function () {
    const title = $('#eventTitle').val().trim();
    const startRaw = $('#eventStart').val();
    const endRaw = $('#eventEnd').val();
    const start = moment(startRaw, "YYYY-MM-DD HH:mm").format("YYYY-MM-DD HH:mm");
    const end = moment(endRaw, "YYYY-MM-DD HH:mm").format("YYYY-MM-DD HH:mm");

    const content = $('#eventContent').val().trim();
    const type = $('input[name="eventType"]:checked').val();

    // SweetAlert 경고창 공통 함수
    function showAlert(message) {
      Swal.fire({
        icon: 'warning',
        text: message,
        confirmButtonText: '확인',
        confirmButtonColor: '#3A8DFE', // 등록 버튼 색상
        customClass: {
          confirmButton: 'swal2-bold-button'
        }
      });
    }

    // 유효성 검사
    if (!title) {
      showAlert('제목은 필수입니다.');
      return;
    }
    if (!type) {
      showAlert('분류코드를 선택하세요.');
      return;
    }
    if (!endRaw) {
      showAlert('종료 날짜를 선택하세요.');
      return;
    }
    if (moment(end).isSameOrBefore(start)) {
      showAlert('종료 시간을 시작 시간보다 나중으로 선택하세요.');
      return;
    }
    if (!content) {
      showAlert('내용을 입력하세요.');
      return;
    }

    // 통과 시 AJAX 등록
    $.ajax({
      url: '<%=request.getContextPath()%>/calendar/regist',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({
        title,
        start,
        end,
        content,
        catecode: type,                    // DB 저장용
        catedetail: toKoreanCategory(type) // 화면 표시용
      }),
      success: function () {
        Swal.fire({
          icon: 'success',
          text: '일정이 등록되었습니다.',
          confirmButtonText: '확인',
          confirmButtonColor: '#3A8DFE',
          customClass: {
            confirmButton: 'swal2-bold-button'
          }
        }).then(() => {
          $('#eventModal').modal('hide');
          calendar.refetchEvents();
        });
      },
      error: function () {
        Swal.fire({
          icon: 'error',
          text: '등록 중 에러가 발생했습니다.',
          confirmButtonText: '확인',
          confirmButtonColor: '#3A8DFE',
          customClass: {
            confirmButton: 'swal2-bold-button'
          }
        });
      }
    });
  });



  // 수정 준비
  $('#btnUpdate').click(function () {
    const ccode = $(this).data('ccode');
    const catecode = $(this).data('catecode');

    const title = $('#detail-title').text();
    const dateRange = $('#detail-date').text().split(' ~ ');
    const content = $('#detail-content').text();

    $('#eventTitle').val(title);
    $('#eventStart').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
    $('#eventEnd').val(moment(event.end).format('YYYY-MM-DD HH:mm'));

    $('#eventContent').val(content);

    $('input[name="eventType"]').prop('checked', false);
    $(`input[name="eventType"][value="${catecode}"]`).prop('checked', true);

    $('#eventModal .modal-title').text('일정 수정');
    $('#btnSave').hide();
    $('#btnModify').show().data('ccode', ccode);

    $('#detailModal').modal('hide');
    $('#eventModal').modal('show');
  });

  
  
//수정 완료
  $('#btnModify').click(function () {
    const ccode = $(this).data('ccode');
    const title = $('#eventTitle').val().trim();
    const start = $('#eventStart').val();
    const end = $('#eventEnd').val();
    const content = $('#eventContent').val().trim();
    const catecode = $('input[name="eventType"]:checked').val();
    const catedetail = $('input[name="eventType"]:checked').next('label').text();

    // 유효성 검사
    if (!title) {
      Swal.fire({
        html: "제목은 필수입니다.",
        icon: "warning",
        confirmButtonText: "확인",
        confirmButtonColor: '#3A8DFE',
        customClass: {
          htmlContainer: 'swal2-html-container',
          confirmButton: 'swal2-bold-button'
        }
      });
      return;
    }
    if (!catecode) {
      Swal.fire({
        html: "분류코드를 선택하세요.",
        icon: "warning",
        confirmButtonText: "확인",
        confirmButtonColor: '#3A8DFE',
        customClass: {
          htmlContainer: 'swal2-html-container',
          confirmButton: 'swal2-bold-button'
        }
      });
      return;
    }
    if (!start || !end) {
      Swal.fire({
        html: "시작일과 종료일을 선택하세요.",
        icon: "warning",
        confirmButtonText: "확인",
        confirmButtonColor: '#3A8DFE',
        customClass: {
          htmlContainer: 'swal2-html-container',
          confirmButton: 'swal2-bold-button'
        }
      });
      return;
    }
    if (new Date(start) >= new Date(end)) {
      Swal.fire({
        html: "종료일은 시작일보다 나중이어야 합니다.",
        icon: "warning",
        confirmButtonText: "확인",
        confirmButtonColor: '#3A8DFE',
        customClass: {
          htmlContainer: 'swal2-html-container',
          confirmButton: 'swal2-bold-button'
        }
      });
      return;
    }
    if (!content) {
      Swal.fire({
        html: "내용을 입력하세요.",
        icon: "warning",
        confirmButtonText: "확인",
        confirmButtonColor: '#3A8DFE',
        customClass: {
          htmlContainer: 'swal2-html-container',
          confirmButton: 'swal2-bold-button'
        }
      });
      return;
    }

    // 수정 처리
    $.ajax({
      url: '<%=request.getContextPath()%>/calendar/modify',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ ccode, title, start, end, content, catecode, catedetail }),
      success: function () {
        Swal.fire({
          html: "일정이 수정되었습니다.",
          icon: "success",
          confirmButtonText: "확인",
          confirmButtonColor: '#3A8DFE',
          customClass: {
            htmlContainer: 'swal2-html-container',
            confirmButton: 'swal2-bold-button'
          }
        }).then(() => {
          $('#eventModal').modal('hide');
          calendar.refetchEvents();
        });
      },
      error: function (xhr) {
        console.log("수정 실패:", xhr.responseText);
        Swal.fire({
          html: "수정에 실패했습니다.<br>관리자에게 문의하세요.",
          icon: "error",
          confirmButtonText: "확인",
          confirmButtonColor: '#3A8DFE',
          customClass: {
            htmlContainer: 'swal2-html-container',
            confirmButton: 'swal2-bold-button'
          }
        });
      }
    });
  });


  
  
  // 삭제
  $("#btnDelete").on("click", function () {
    const ccode = $(this).data("ccode");

    Swal.fire({
        html: "정말 삭제하시겠습니까?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "삭제",
        cancelButtonText: "취소",
        customClass: {
          htmlContainer: 'swal2-html-container', // 메시지 스타일
          confirmButton: 'swal2-delete-button',  // 삭제 버튼 스타일
          cancelButton: 'swal2-bold-button'      // 취소 버튼 스타일
        }
      }).then((result) => {
      if (result.isConfirmed) {
        $.ajax({
          type: "POST",
          url: "/motiveOn/calendar/delete",
          contentType: "application/json",
          data: JSON.stringify({ ccode: ccode }),
          success: function (res) {
        	  if (res === "success") {
                  Swal.fire({
                    html: "삭제되었습니다",
                    icon: "success",
                    confirmButtonText: "확인",
                    confirmButtonColor: '#3A8DFE',
                    customClass: {
                      htmlContainer: 'swal2-html-container',
                      confirmButton: 'swal2-bold-button'
                    }
                  });
              $("#detailModal").modal("hide");
              calendar.refetchEvents();
            }
          },
          error: function () {
            Swal.fire("삭제 실패", "관리자에게 문의하세요", "error");
          }
        });
      }
    });
  });

});



</script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
	  const options = {
			  enableTime: true,
			  dateFormat: "Y-m-d H:i", // T 빼고 공백으로 변경
			  time_24hr: true,
			  locale: "ko"
			};

    flatpickr("#eventStart", options);
    flatpickr("#eventEnd", options);
  });
</script>


	<!-- 모달 JSP 포함 -->
	<jsp:include page="/WEB-INF/views/calendar/regist.jsp" />
	<jsp:include page="/WEB-INF/views/calendar/detail.jsp" />
</body>
</html>