<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${message}
	<div style="text-align: left;">

		<form action="<c:url value="/findPwd_chk"/>" method="post">
			<table>
				<tr>
					<th><label>ID </label></th>
					<td><input type="text" name="id" size="27"></td>
				</tr>
				<tr>
					<th><label>질문 </label></th>
					<td><select name='pwHint' size='1' class='select'>
							<option value=''>선택하세요</option>
							<option value='졸업한 초등학교 이름은?'>졸업한 초등학교 이름은?</option>
							<option value='제일 친한 친구의 핸드폰 번호는?'>제일 친한 친구의 핸드폰 번호는?</option>
							<option value='아버지 성함은?'>아버지 성함은?</option>
							<option value='어머니 성함은?'>어머니 성함은?</option>
							<option value='어릴 적 내 별명은?'>어릴 적 내 별명은?</option>
							<option value='가장 아끼는 물건은?'>가장 아끼는 물건은?</option>
							<option value='좋아하는 동물은?'>좋아하는 동물은?</option>
							<option value='좋아하는 색깔은?'>좋아하는 색깔은?</option>
							<option value='좋아하는 음식은?'>좋아하는 음식은?</option>
					</select></td>
				</tr>
				<tr>
					<th><label>답변 </label></th>
					<td><input type='text' name='pwHintAns' size="27"></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /></td>

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