<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
//다른 달 데이터 조회
function changeMonth(num) {
	console.log(num);
	var calendar = $('#month').text().trim();
	var calendarSplit = calendar.split('-');
	console.log(calendarSplit);

	var year = parseInt(calendarSplit[0]);
	var month = calendarSplit[1]-1 + parseInt(num);

	if(month>11){
		month = 0;
		year += 1;
	}
	if(month<0){
		month = 11;
		year -= 1;
	}
	if((month+1)<10){
		month = '0'+(month+1);
	} else {
		month = month+1
	}

	$('#month').text('');
	$('#month').html('&nbsp;&nbsp;'+year+'-'+month+'&nbsp;&nbsp;');
	var monthStart = year+"-"+month+"-01";
	console.log(monthStart);
	hrMonthList(monthStart, ${employee.eno});
}
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.8/handlebars.min.js"></script>
<script type="text/x-handlebars-template"  id="monthList-template" >

<tbody class="monthTableOn">
	{{#each .}}
	<tr class="odd monthTableOn" data-hrCode="{{hrcode}}">
		<td class="dtr-control" style="text-align: center;">{{formatDate day}}</td>
		<td style="text-align: center;">{{formatTime onTime}}</td>
		<td class="sorting_1" style="text-align: center;">{{formatTime offTime}}</td>
		<td class="hrTime" style="text-align: center;">{{plusTime hrTime}}</td>
		<td class="state" style="text-align: center;">{{state}}</td>
		<input type="hidden" class="stdTime" value="{{stdTime}}">
		<input type="hidden" class="overTime" value="{{overTime}}">
	</tr>
	{{/each}}
</tbody>
</script>

<script type="text/x-handlebars-template"  id="hrList-pagination-template" >
   <li class="page-item">
      <a class="page-link" href="{{goPage 1}}">
         <i class="fas fa-angle-double-left"></i>
      </a>
   </li>
   <li class="page-item">
      <a class="page-link" href="{{#if prev}}{{goPage prevPageNum}}{{else}}{{goPage 1}}{{/if}}">
         <i class="fas fa-angle-left"></i>
      </a>                  
   </li>
   {{#each pageNum}}
      <li class="paginate_button page-item {{signActive this}} ">
         <a href="{{goPage this}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">{{this}}</a>
      </li>
   {{/each}}
   <li class="page-item">
      <a class="page-link" href="{{#if next}}{{goPage nextPageNum}}{{else}}{{goPage realEndPage}}{{/if}}">
         <i class="fas fa-angle-right"></i>
      </a>                  
   </li>
   <li class="page-item">
      <a class="page-link" href="{{goPage realEndPage}}">
         <i class="fas fa-angle-double-right"></i>
      </a>
   </li>
</script>

<script>

function printHrTable(dataArr,target,templateObject, removeClass){
	var template=Handlebars.compile(templateObject.html());
	var html = template(dataArr);

	removeClass.remove();

	target.append(html);
}

var pagination_func = Handlebars.compile($("#hrList-pagination-template").html());

</script>

<script>
getPage(1);

var currentPage = 1;

function getPage(page){  // 근태리스트에 맞게 수정해야 함
	
	$.ajax({
		url:"<%=request.getContextPath()%>/ehr/main?page="+page,
		method:"get",
		success:function(data){
			//console.log(data);
			let reply_html = reply_list_func(data.replyList);
			$('.replyLi').remove();
		    $('#repliesDiv').after(reply_html);
		    
   			if(page) currentPage = page;
		    
		    let pageMaker = data.pageMaker;
		    
		    let pageNumArray = new Array(pageMaker.endPage-pageMaker.startPage+1);
		    
		    for(let i=pageMaker.startPage;i<pageMaker.endPage+1;i++){
		       pageNumArray[i-pageMaker.startPage]=i;
		    }   
		     
		    pageMaker.pageNum=pageNumArray;  
		    pageMaker.prevPageNum=pageMaker.startPage-1;
		    pageMaker.nextPageNum=pageMaker.endPage+1;
		    
		    let pagination_html = pagination_func(pageMaker);
		    $("#pagination").html(pagination_html);  
		}
	});
}
</script>


<script type="text/javascript">
Handlebars.registerHelper({
	"formatDate" : function(strDate){
		var dateObj = new Date(strDate);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		var day = dateObj.getDay();
		var week = new Array('일', '월', '화', '수', '목', '금', '토');
		return date+"("+ week[dateObj.getDay()] +")";
	},
	"formatTime" : function(strDate){
		var timeString = "";
		if(strDate != null){
			var dateObj = new Date(strDate);

			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();

			var hours = ('0' + dateObj.getHours()).slice(-2);
			var minutes = ('0' + dateObj.getMinutes()).slice(-2);
			var seconds = ('0' + dateObj.getSeconds()).slice(-2);

			timeString = hours + ':' + minutes  + ':' + seconds;
		}
		return timeString;
	},
	"formatDateColor" : function(strDate){
// 		console.log(strDate);
		var color = "";
		var dateObj = new Date(strDate);
		var day = dateObj.getDay();
		if(day==0){
			color = "red";
		} else if(day==6){
			color = "#007bff";
		} else if(strDate == "2022-08-15"){
			color = "red";
		}
		return color;
	},
	"formatTimeColor" : function(state){
		var color = "";
		if(state==2 || state==0){
			color = "red";
		}else if(state==3){
			color = "gray";
		}else{
			color = "black";
		}
		return color;
	},
	"plusTime" : function(time){
		if(time != null){
			time = time+"시간";
		}
		return time;
	}
})
</script>


<script type="text/javascript">
//월간 대쉬보드 계산
function MonthCalc(){
    var mHrTime = 0;
    var mStdTime = 0;
    var mOverTime = 0;
    var mTardy = 0;

    // tr 개수
    var rowCount = $('.monthTableOn tr').length;

    for(var i=0; i < rowCount; i++){
        var hrText = $('.hrTime').eq(i).text();
        if(hrText != " - " ){
            mHrTime += parseInt(hrText.replace("시간",""));
        }

        var stdVal = $('.stdTime').eq(i).val();
        if(stdVal != " - " ){
            mStdTime += parseInt(stdVal.replace("시간",""));
        }

        var overVal = $('.overTime').eq(i).val();
        if(overVal != " - " ){
            mOverTime += parseInt(overVal.replace("시간",""));
        }

        var stateVal = $('.state').eq(i).text();
        if(stateVal === "2"){
            mTardy += 1;  // state가 2면 지각 1건 추가
        }
    }

    $('.mHrTime').text(mHrTime+"시간");
    $('.mStdTime').text(mStdTime+"시간");
    $('.mOverTime').text(mOverTime+"시간");
    $('.mTardy').text(mTardy+"건");
}
</script>

<script>
//월간 근태테이블
function hrMonthList(monthStart, eno){
	if(!monthStart){
		var today = new Date();
		var year = today.getFullYear();
		var month = (today.getMonth()+1).toString().padStart(2, '0');
		monthStart = year + '-' + month + '-01'; 
		<!-- <fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/>' -->
	}

	if(!eno){
		eno = '${employee.eno}';
	}

	var data = {
			'eno' : eno,
			'monthStart' : monthStart
	}
	$.ajax({
		url : '<%=request.getContextPath()%>/ehr/monthHrList',
		data  : JSON.stringify(data),
		contentType:"application/json",
		type : 'POST',
		success: function(res){
			printHrTable(res, $('.monthTable-target'), $('#monthList-template'), $('.monthTableOn'));
			MonthCalc();
		},
		error:function(error){
			console.log(error);
			//AjaxErrorSecurityRedirectHandler(error.status);
		}
	});
}
 
//페이지 로딩 후 강제호출
hrMonthList(null, 24330015); //하드코딩 '${employee.eno}'

</script>