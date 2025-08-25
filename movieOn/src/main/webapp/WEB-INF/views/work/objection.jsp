<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>

<!-- 이의신청 모달 -->
<div class="modal fade" id="objectionModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">이의신청</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <textarea id="objectionReason" class="form-control" rows="4" placeholder="이의 사유를 입력하세요"></textarea>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-info" id="btnSaveObjection">등록</button>
      </div>
    </div>
  </div>
</div>

<script>
$(function(){
    var wcode = "${work.wcode}";

    $("#btnSaveObjection").click(function(){
        var reason = $("#objectionReason").val();
        if(!reason) {
            alert("사유를 입력하세요.");
            return;
        }
        $.post("<%=ctx%>/work/objection", { wcode: wcode, reason: reason }, function(){
            alert("이의신청이 등록되었습니다.");
            $("#objectionModal").modal("hide");
            window.close();
        }).fail(function(){
            alert("이의신청 처리 중 오류 발생");
        });
    });
});
</script>
