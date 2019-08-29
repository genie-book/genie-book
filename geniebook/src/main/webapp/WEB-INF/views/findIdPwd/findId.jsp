<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	${message }

	<div style="text-align: left;">
		<form action="<c:url value = "/findId_chk"/>" method="post">
			<table>
				<tr>
					<th><label>이름 </label></th>
					<td><input type="text" name="name" size="26" /></td>

				</tr>
				<tr>
					<th><label>주민번호</label></th>
					<td><input type="text" name="jumin1" id="jumin1" size="10"
						maxlength="6" />-<input type="password" size="10" name="jumin2"
						id="jumin2" maxlength="7">
					<td>
				</tr>

				<tr>
					<th><input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /></th>
				</tr>
				<tr>
					<th></th>
					<td><input type="submit" value="확인"
						style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">

						<input type="reset" class="btn btn-default" value="다시입력"
						style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>