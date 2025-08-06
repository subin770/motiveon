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
.fc-day-mon a, .fc-day-tue a, .fc-day-wed a, .fc-day-thu a, .fc-day-fri a {
    color: #52586B !important;
}
.fc-holiday {
    background-color: #f00000 !important;
    color: #ffffff !important;
    font-weight: bold;
}
#prevBtn, #nextBtn {
    font-size: 28px !important;
    font-weight: bold;
    color: #52586B;
    background: none;
    border: none;
    cursor: pointer;
    padding: 4px 12px;
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
    justify-content: center;
    align-items: center;
    margin-top: 30px;
    margin-bottom: 15px;
}
#customTitle {
    font-size: 30px !important;
    font-weight: 600;
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
.fc-holiday.fc-event {
    background-color: #e74c3c !important;
    color: white !important;
    font-weight: 600 !important;
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
    padding-left: 6px !important;  /* ← 왼쪽 여백 */
    font-weight: 400;
  }

  .fc-event-title {
    padding-left: 6px;
  }
</style>
</head>

<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <div class="content-wrapper" style="margin-left: 0; background-color: #ffffff;">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-1 position-relative">
                    <div class="col-md-12">
                        <h3 class="font-weight-bold" style="padding-left: 20px; margin-top: 10px; font-size: 22px;">내 일정</h3>
                        <div class="input-group" style="max-width: 300px; position: absolute; top: 0; right: 20px; margin-top: 95px;">
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요.">
                            <div class="input-group-append">
                                <button class="btn" style="background-color: #2C3E50; color: white;">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div id="customCalendarHeader">
            <button id="prevBtn">&lt;</button>
            <div id="customTitle">0000.00</div>
            <button id="nextBtn">&gt;</button>
        </div>

        <section class="content">
            <div class="container-fluid">
                <div class="card card-primary">
                    <div class="card-body p-3">
                        <div id="calendar" style="width: 100%; max-width: 1770px; margin: 0 auto; padding: 0 30px;"></div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


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

    eventDidMount: function (info) {
      const catedetail = info.event.extendedProps.catedetail;
      let bgColor = '#8dbad7';
      if (catedetail === '부서일정') bgColor = '#f5a29f';
      else if (catedetail === '개인일정') bgColor = '#bbd89d';
      info.el.style.backgroundColor = bgColor;
      info.el.style.borderColor = bgColor;
      info.el.style.color = '#fff';
    },

    datesSet: function (info) {
      const year = info.view.currentStart.getFullYear();
      const month = ('0' + (info.view.currentStart.getMonth() + 1)).slice(-2);
      customTitle.textContent = year + '.' + month;
    },

    eventClick: function (info) {
      const event = info.event;
      $('#detail-title').text(event.title || '');
      $('#detail-category').text('(' + (event.extendedProps.catedetail || '') + ')');
      $('#detail-date').text(
        moment(event.start).format("YYYY.MM.DD HH:mm") + ' ~ ' +
        moment(event.end).format("YYYY.MM.DD HH:mm")
      );
      $('#detail-content').text(event.extendedProps.content || '');

      $('#btnUpdate').data('ccode', event.extendedProps.ccode);
      $('#btnDelete').data('ccode', event.extendedProps.ccode);

      $('#detailModal').modal('show');
    },

    select: function (info) {
      $('#eventModal .modal-title').text('일정 등록');
      $('#btnSave').show();
      $('#btnModify').hide();

      // 입력값 초기화
      $('#eventTitle').val('');
      $('#eventStart').val(info.startStr);
      $('#eventEnd').val('');
      $('#eventContent').val('');
      $('input[name="eventType"]').prop('checked', false);

      $('#eventModal').modal('show');
    },

    events: {
      url: '<%=request.getContextPath()%>/calendar/list',
      method: 'GET',
      failure: () => alert('일정 데이터를 불러오지 못했습니다.')
    }
  });

  calendar.render();

  // 월간/주간 버튼
  document.getElementById('prevBtn').addEventListener('click', () => calendar.prev());
  document.getElementById('nextBtn').addEventListener('click', () => calendar.next());

  // 등록 버튼
  $('#btnSave').on('click', function () {
    const title = $('#eventTitle').val().trim();
    const start = $('#eventStart').val();
    const end = $('#eventEnd').val();
    const content = $('#eventContent').val().trim();
    const type = $('input[name="eventType"]:checked').val();

    if (!title || !type || !start || !end || !content) {
      alert("모든 항목을 입력해주세요.");
      return;
    }

    $.ajax({
      url: '<%=request.getContextPath()%>/calendar/regist',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ title, start, end, content, catedetail: type }),
      success: function () {
        alert("일정이 등록되었습니다.");
        $('#eventModal').modal('hide');
        calendar.refetchEvents();
      },
      error: function () {
        alert("등록에 실패했습니다.");
      }
    });
  });

  // 상세 → 수정 버튼
  $('#btnUpdate').click(function () {
    const ccode = $(this).data('ccode');
    const title = $('#detail-title').text();
    const category = $('#detail-category').text().replace(/[()]/g, '');
    const dateRange = $('#detail-date').text().split(' ~ ');
    const content = $('#detail-content').text();

    $('#eventTitle').val(title);
    $('#eventStart').val(moment(dateRange[0], 'YYYY.MM.DD HH:mm').format('YYYY-MM-DDTHH:mm'));
    $('#eventEnd').val(moment(dateRange[1], 'YYYY.MM.DD HH:mm').format('YYYY-MM-DDTHH:mm'));
    $('#eventContent').val(content);
    $(`input[name="eventType"][value="${category}"]`).prop('checked', true);

    $('#eventModal .modal-title').text('일정 수정');
    $('#btnSave').hide();
    $('#btnModify').show().data('ccode', ccode);

    $('#detailModal').modal('hide');
    $('#eventModal').modal('show');
  });

  // 수정 완료 버튼
  $('#btnModify').click(function () {
    const ccode = $(this).data('ccode');
    const title = $('#eventTitle').val().trim();
    const start = $('#eventStart').val();
    const end = $('#eventEnd').val();
    const content = $('#eventContent').val().trim();
    const type = $('input[name="eventType"]:checked').val();

    if (!title || !type || !start || !end || !content) {
      alert("모든 항목을 입력해주세요.");
      return;
    }

    $.ajax({
      url: '<%=request.getContextPath()%>/calendar/modify',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ ccode, title, start, end, content, catedetail: type }),
      success: function () {
        alert("일정이 수정되었습니다.");
        $('#eventModal').modal('hide');
        calendar.refetchEvents();
      },
      error: function (xhr) {
          console.log("수정 실패:", xhr.responseText); // ✅ 여기에 추가!
          alert('수정에 실패했습니다.');
      }
    });
  });

  // 삭제 버튼 (추후 구현)
  $('#btnDelete').click(function () {
    const ccode = $(this).data('ccode');
    console.log("삭제할 코드:", ccode);
    // confirm + ajax 구현 필요
  });
});
</script>


<!-- 모달 JSP 포함 -->
<jsp:include page="/WEB-INF/views/calendar/regist.jsp" />
<jsp:include page="/WEB-INF/views/calendar/detail.jsp" />


</body>
</html>