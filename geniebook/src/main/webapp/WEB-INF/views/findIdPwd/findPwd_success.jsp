<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function checkPattern() {
		var str = document.getElementById('password').value;

		// 숫자 
		var pattern1 = /[0-9]/;
		// 문자
		var pattern2 = /[a-zA-Z]/;
		// 특수문자 
		var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;
		/* 공백 */
		var pattern4 = /^\s+|\s+$/g;

		console.log(str);
		console.log("숫자: " + pattern1.test(str));
		console.log("문자: " + pattern2.test(str));
		console.log("특수: " + pattern3.test(str));
		console.log("공백: " + !pattern4.test(str));
		console.log("길이: " + str.length >= 8);

		if (pattern1.test(str) && pattern2.test(str) && pattern3.test(str)
				&& str.length >= 8 && !pattern4.test(str)) {
			console.log("zz");
			return true;

		} else {
			alert("비밀번호는 8자리 이상 문자, 숫자, 특수문자로 구성하여야 합니다.");
			/*location.href = "registerForm_user";*/

			return false;

		}
	}
</script>
</head>
<body>
	${message }
	<form action="<c:url value="/findPwd.do"/>" method="post">
		<table>
			<tr>
				<th><input type="hidden" name=id value="${id }"> <label>새
						비밀번호 </label></th>
				<td><input type="password" id=password name="password"></td>
			</tr>
			<tr>
				<th></th>
				<td><span style="color: red; font-size: 10px;">영문/숫자/특수문자
						포함 8자 이상</span></td>
			</tr>
			<tr>
				<th><label>새 비밀번호 확인</label></th>
				<td><input type="password" id=password2 name="password2">
				</td>
			</tr>
			<tr><th></th><td>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
					</td>
			</tr>
			<tr>
				<th></th>
				<td><input type="submit" onclick="return checkPattern()"
					value="확인"
					style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;" />

					<input type="reset" class="btn btn-default" value="다시입력"
					style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>