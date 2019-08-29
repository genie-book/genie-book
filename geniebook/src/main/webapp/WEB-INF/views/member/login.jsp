<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
a:link, a:active, a:hover {
	text-decoration: none;
}
</style>
<section id="form">
	<div class="container">
		<div class="row">
			<div class="col-sm-4 col-sm-offset-1"
				style="float: none; margin: 0 auto;">
				<div class="login-form">
					<h2 align="center">로그인</h2>
					${message }



					<form action="<c:url value="/login"/>" method="post">
						<div class="form-group">
							<label for="ID">ID:</label> <input type="text"
								class="form-control" id="username" placeholder="Enter ID"
								name="username">

							<c:if test="${not empty errorMsg}">
								<div style="color: #ff0000; font-size: 10px;">
									<h5 align="center">${errorMsg}</h5>
								</div>
							</c:if>
						</div>
						<div class="form-group">
							<label for="Password">Password:</label> <input type="password"
								class="form-control" id="password" placeholder="Enter password"
								name="password">
						</div>
						<div align="center">
							<a href=""
								onclick="window.open('${contextPath}/findIdPwd','','left='+(screen.availWidth-300)/2+',top='+(screen.availHeight-150)/2+',width=300px, height=150px')">아이디
								또는 비밀번호 찾기</a> <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />

							<button type="submit" class="btn btn-primary">로그인</button>

							<button type="button" class="btn btn-default"
								onclick="location.href='registerForm_member'">회원 가입</button>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>
</section>