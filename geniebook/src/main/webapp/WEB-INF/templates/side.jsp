<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-3">
				<div class="left-sidebar">
				<p><p><p><p><p><p>
					<h2>국내외 서적</h2>
					<div class="panel-group category-products" id="accordian">
						<!--category-productsr-->
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian"
										href="#novel"> <span class="badge pull-right"><i
											class="fa fa-plus"></i></span> 소설
									</a>
								</h4>
							</div>
							<div id="novel" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<li><a href="<c:url value="/category/novel/1"/>">나라별 소설 </a></li>
										<li><a href="<c:url value="/category/novel/2"/>">고전/문학 </a></li>
										<li><a href="<c:url value="/category/novel/3"/>">장르소설 </a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian"
										href="#poem"> <span class="badge pull-right"><i
											class="fa fa-plus"></i></span> 시/에세이
									</a>
								</h4>
							</div>
							<div id="poem" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<li><a href="<c:url value="/category/poem/1"/>">한국시 </a></li>
										<li><a href="<c:url value="/category/poem/2"/>">외국시 </a></li>
										<li><a href="<c:url value="/category/poem/3"/>">여행 에세이 </a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian"
										href="#selfDevelopment"> <span class="badge pull-right"><i
											class="fa fa-plus"></i></span> 자기계발
									</a>
								</h4>
							</div>
							<div id="selfDevelopment" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<li><a href="<c:url value="/category/selfDevelopment/1"/>">대화/협상 </a></li>
										<li><a href="<c:url value="/category/selfDevelopment/2"/>">자기능력계발 </a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian"
										href="#liberal"> <span class="badge pull-right"><i
											class="fa fa-plus"></i></span> 인문
									</a>
								</h4>
							</div>
							<div id="liberal" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<li><a href="<c:url value="/category/liberal/1"/>">인문일반 </a></li>
										<li><a href="<c:url value="/category/liberal/2"/>">심리 </a></li>
										<li><a href="<c:url value="/category/liberal/3"/>">철학 </a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordian"
										href="#children"> <span class="badge pull-right"><i
											class="fa fa-plus"></i></span> 어린이
									</a>
								</h4>
							</div>
							<div id="children" class="panel-collapse collapse">
								<div class="panel-body">
									<ul>
										<li><a href="<c:url value="/category/children/1"/>">어린이(공통) </a></li>
										<li><a href="<c:url value="/category/children/2"/>">초등 </a></li>
									</ul>
								</div>
							</div>
						</div>

					</div>
					<!-- /category-products -->
				</div>
			</div>
		</div>
	</div>

</body>
</html>