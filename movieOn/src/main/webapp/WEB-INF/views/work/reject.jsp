<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>

<!-- 반려 모달 -->
<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">반려 사유 입력</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <textarea id="rejectReason" class="form-control" rows="4" placeholder="반려 사유를 입력하세요"></textarea>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-warning" id="btnSaveReject">반려</button>
      </div>
    </div>
  </div>
</div>

<script>
$(function(){
    var wcode = "${work.wcode}";

    $("#btnSaveReject").click(function(){
        var reason = $("#rejectReason").val();
        if(!reason) {
            alert("사유를 입력하세요.");
            return;
        }
        $.post("<%=ctx%>/work/reject", { wcode: wcode, reason: reason }, function(){
            alert("반려 처리되었습니다.");
            $("#rejectModal").modal("hide");
            window.close();
        }).fail(function(){
            alert("반려 처리 중 오류 발생");
        });
    });
});
</script>
