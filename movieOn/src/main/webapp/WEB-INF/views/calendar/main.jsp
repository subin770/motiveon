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
let calendar; // 전역으로 선언

document.addEventListener('DOMContentLoaded', function () {
    const calendarEl = document.getElementById('calendar');
    const customTitle = document.getElementById('customTitle');

    calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko',
        height: 700,
        initialView: 'dayGridMonth',
        headerToolbar: false,
        selectable: true,
        datesSet: function(info) {
            const currentDate = info.view.currentStart;
            const year = currentDate.getFullYear();
            const month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
            customTitle.textContent = year + '.' + month;
        },
        googleCalendarApiKey: 'AIzaSyAv_MkDhVG3h-GtKkehMI5bBYrOZ7B7ec0',
        eventSources: [{
            googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
            className: 'fc-holiday'
        }],
        select: function(info) {
            $('#eventStart').val(info.startStr);
            $('#eventModal').modal('show');
        },
        
        /* eventClick: function(info) {
            const event = info.event;

            $('#detailTitle').text(event.title || '');
            $('#detailStart').text(moment(event.start).format('YYYY-MM-DD HH:mm'));
            $('#detailEnd').text(moment(event.end).format('YYYY-MM-DD HH:mm'));
            $('#detailContent').text(event.extendedProps.content || '');
            $('#detailType').text(event.extendedProps.type || '');

            $('#detailModal').modal('show');
        }, */
        
        eventMouseEnter: function(info) {
            const tooltip = document.createElement('div');
            tooltip.className = 'fc-tooltip';
            tooltip.innerHTML = `
            	  <strong>일정:</strong> \${info.event.title}<br>
            	  <strong>장소:</strong> \${info.event.extendedProps.location || ''}<br>
            	  <strong>시간:</strong> \${moment(info.event.start).format("HH:mm")}
            	`;        
            	Object.assign(tooltip.style, {
                position: 'absolute',
                top: (info.jsEvent.pageY + 10) + 'px',
                left: (info.jsEvent.pageX + 10) + 'px',
                zIndex: 10001,
                background: '#fff',
                border: '1px solid #ccc',
                padding: '8px',
                borderRadius: '4px',
                boxShadow: '0 2px 6px rgba(0,0,0,0.2)'
            });
            tooltip.id = 'calendarTooltip';
            document.body.appendChild(tooltip);
        },
        eventMouseLeave: function() {
            const tooltip = document.getElementById('calendarTooltip');
            if (tooltip) tooltip.remove();
        },
        events: []
    });

    calendar.render();

    document.getElementById('prevBtn').addEventListener('click', () => calendar.prev());
    document.getElementById('nextBtn').addEventListener('click', () => calendar.next());

    // 등록 버튼 이벤트 여기로 이동
    $('.btn-primary').on('click', function () {
      const title = $('#eventTitle').val().trim();
      const start = $('#eventStart').val();
      const end = $('#eventEnd').val();
      const content = $('#eventContent').val().trim();
      const type = $('input[name="eventType"]:checked').val();

      /* if (!title) {
        alert("제목은 필수입니다.");
        return;
      } */
      
      if (!title) {
    	  Swal.fire({
    	    icon: 'warning',
    	    title: '제목은 필수입니다.',
    	    confirmButtonText: '확인'
    	  });
    	  return; // ← 이거 없으면 계속 AJAX 실행됨!
    	}


      if (!type) {
        alert("분류코드를 설정하세요.");
        return;
      }

      if (!start || !end) {
        alert("날짜는 필수입니다.");
        return;
      }

      if (!content) {
        alert("내용은 필수입니다.");
        return;
      }

      if (new Date(start) > new Date(end)) {
        alert("잘못 선택했습니다.");
        return;
      }

      $.ajax({
        url: '<%=request.getContextPath()%>/calendar/regist',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ title, start, end, content, type }),
        success: function () {
        	  calendar.addEvent({
        	    title: title,
        	    start: start,
        	    end: end,
        	    extendedProps: {
        	      content: content,
        	      type: type
        	    },
        	    backgroundColor: '#007bff',
        	    borderColor: '#007bff'
        	  });

        	  $('#eventModal').modal('hide');
        	  $('#eventTitle').val('');
        	  $('#eventStart').val('');
        	  $('#eventEnd').val('');
        	  $('#eventContent').val('');
        	  $('input[name="eventType"]').prop('checked', false);
        	},
        error: function () {
          alert("등록에 실패했습니다.");
        }
      });
    });
});
</script>
<jsp:include page="/WEB-INF/views/calendar/regist.jsp" />
<jsp:include page="/WEB-INF/views/calendar/detail.jsp" />

</body>
</html>