<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	table.userTable{
		
		width:80%;
		height:80%;	
		text-align: center;
	}
	table.userTable.th,td{
		padding-bottom: 10%;
		padding-top: 10%;
		padding-left: 5%;
		padding-right: 5%;
		border-radius:10px;
		border:3px solid;
		border-color: orange;
		text-align: center;
		font-family: 'Roboto', sans-serif;
		font-weight: bold;
		font-size: 20px;
	}
	
	a:link,a:visited,a:active,a:hover{
		text-decoration: none;
		color:#646464;
	}
</style>
</head>
<body>
	<div class="container" align="center">

		<h2>${memberVO.id }님의 정보</h2>
		<c:if test="${pageContext.request.userPrincipal.name == 'admin'}">
		</c:if>
		<c:if test="${pageContext.request.userPrincipal.name != 'admin'}">
			<a href="${contextPath}/pwdCheck_delete">회원탈퇴</a>
		</c:if>
		<tr>
			<th><br></th>
		</tr>
	<table class="userTable">
		<tr>
			<td><a href="${contextPath}/purchaseHistory/${memberVO.id}" >구매 내역  조회</a></td>
			<td><a href="${contextPath}/pwdCheck" >개인 정보 변경</a></td>
		</tr>
		<tr>
			<td><a href="${contextPath}/Q&A/${memberVO.id}" >문의 내역</a></td>
			<td style="align:center;">적립금<br>${memberVO.point }점</td>
		</tr>
	</table>
	<br>
	</div>

	

</body>
</html>