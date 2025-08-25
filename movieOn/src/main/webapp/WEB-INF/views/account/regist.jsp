<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<!-- summernote -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.css">
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

	<!-- 계정등록 박스 -->
	<div id="popupContainer" style="width:100%; max-width:700px; max-height:800px; margin:0 auto; display:flex; flex-direction:column; justify-content:space-between;">

		<!-- 헤더 -->
		<div style="background-color:#4a5568; color:white; padding:10px; display:flex; justify-content:space-between; align-items:center;">
			<h5 style="margin:0;">계정등록</h5>
		</div>

		<!-- 바디 -->
		<div style="padding:20px;">
			<form name="registForm" id="registForm" method="post" action="regist">
				<table class="table table-bordered" style="margin-bottom:0;">
    <tbody>
        <tr>
            <td style="width:25%; background:#f7f7f7;">소속</td>
            <td>
                <div class="form-inline">
                    <select name="dno" id="dno" class="form-control mr-1">
                        <option value="330">경영지원팀</option>
                        <option value="430">인사관리팀</option>
                        <option value="530">영업팀</option>
                        <option value="630">마케팅팀</option>
                        <option value="730">디자인팀</option>
                        <option value="830">총무팀</option>
                        <option value="930">생산팀</option>
                        <option value="130">기술기획팀</option>
                        <option value="230">품질관리팀</option>
                    </select>
                </div>
            </td>
            <td style="width:25%; background:#f7f7f7;">사번</td>
            <td>
                <div class="input-group">
                    <input type="text" name="empNo" id="empNo" class="form-control" readonly>
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button" id="generateEmpNoBtn">생성</button>
                    </div>
                </div>
            </td>
        </tr>

        <tr>
            <td style="background:#f7f7f7;">이름</td>
            <td><input type="text" name="name" placeholder="이름을 입력하세요." class="form-control notNull" title="이름"></td>
            <td style="background:#f7f7f7;">직위</td>
            <td>
                <div class="form-inline">
                    <select name="ppsCode" class="form-control mr-1">
                        <option value="PPS001">사원</option>
                        <option value="PPS002">대리</option>
                        <option value="PPS003">과장</option>
                        <option value="PPS004">차장</option>
                        <option value="PPS005">부장</option>
                        <option value="PPS006">이사</option>
                        <option value="PPS007">상무</option>
                        <option value="PPS008">전무</option>
                        <option value="PPS009">부사장</option>
                        <option value="PPS010">사장</option>
                    </select>
                </div>
            </td>
        </tr>

        <tr>
            <td style="background:#f7f7f7;">직책</td>
            <td colspan="3">
                <input type="text" name="job" placeholder="직책을 입력하세요." class="form-control">
            </td>
        </tr>

        <tr>
            <td style="background:#f7f7f7;">입사일</td>
            <td><input type="date" name="joinDate" class="form-control"></td>
            <td style="background:#f7f7f7;">권한</td>
            <td>
                <select name="role" class="form-control">
                    <option value="ROLE_USER">사용자</option>
                    <option value="ROLE_ADMIN">관리자</option>
                </select>
            </td>
        </tr>

        <tr>
            <td style="background:#f7f7f7;">연락처</td>
            <td colspan="3">
                <input type="text" name="phone" placeholder="연락처를 입력하세요." class="form-control notNull" title="연락처"
                maxlength="11" oninput="this.value=this.value.replace(/[^0-9]/g,'');">
            </td>
        </tr>
    </tbody>
</table>
			</form>
		</div>

		<!-- 푸터 -->
		<div style="padding:10px; text-align:center; background:#f9f9f9; border-top:1px solid #ddd; border-bottom-left-radius:6px; border-bottom-right-radius:6px;">
			<button type="button" class="btn btn-danger" onclick="CloseWindow();">취소</button>
			<button type="button" class="btn btn-primary" onclick="regist_go();">등록</button>
		</div>
	</div>

<script>
$(document).ready(function() {
    $("#generateEmpNoBtn").click(function() {
        var deptNo = $("#dno").val();
        if(!deptNo) { alert("부서를 선택하세요."); return; }

        var year = new Date().getFullYear().toString().slice(-2);
        var seq = Math.floor(Math.random() * 999) + 1;
        var seqStr = ("000" + seq).slice(-3);

        var empNo = year + deptNo + seqStr;
        $("#empNo").val(empNo);
    });
});

function regist_go(){
    var form = document.forms.registForm;
    var inputNotNull = document.querySelectorAll(".notNull");

    for(var input of inputNotNull){
        if(!input.value){
            alert(input.getAttribute("title") + "은 필수입니다.");
            input.focus();
            return;
        }
    }

    form.submit();
}
</script>

</body>