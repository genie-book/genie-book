<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script>
	function pwdCheck() {
		var pwd = "${memberVO.password}";
		
		if (pwd == $("#password").val()) {
			location.href = "deleteMember.do/${memberVO.id}";
		} else {
			console.log("{pwd}: "+pwd);
			console.log("password: "+$("#password").val());
			alert("비밀번호가 일치하지 않습니다.");
		}
	}
</script>
</head>
<body>
	<div class="container">
		<div style="align:center;">
			<div class="col-sm-4 col-sm-offset-1">

				<h2>회원 탈퇴 확인</h2>
				<div class="form-group">
					ID<input type="text" class="form-control" id="id" name="id"
						value="${memberVO.id }" readonly="readonly">
				</div>
				<div class="form-group">
					Password <input type="password" class="form-control" id="password"
						placeholder="Enter password" name="password">
				</div>



				<button type="button" class="btn btn-default" onclick="pwdCheck()">확인</button>

				<button type="button" class="btn btn-default"
					onclick="history.go(-1)">취소</button>

			</div>
		</div>

	</div>
</body>
</html>