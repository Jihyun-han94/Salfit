<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="form-title text-center">
        </div>
		<%-- <p style="color:red;">${param.error}</p> --%>
		<div class="d-flex flex-column text-center">
		<form action="${login}" method="POST">
			<input type="hidden" name="pid" value="${item.getId()}">
			<div class="form-group">
				<label for="id_email">이메일</label>
				<input id="id_email" type="email" name="email"  >
			</div>
			<div class="form-group">
				<label for="id_password">비밀번호 : </label>
				<input id="id_password" type="password" name="password" placeholder="password" required>
				<button type="submit" class="btn btn-info btn-block btn-round">확인</button>
			</div>
		</form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
</div>