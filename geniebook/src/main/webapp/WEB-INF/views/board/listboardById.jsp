<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function boardForm() {
		location.href = "${contextPath}/board/boardForm";
	}
	//이전 버튼 이벤트

	function fn_prev(page, range, rangeSize) {

		var page = ((range - 2) * rangeSize) + 1;

		var range = range - 1;

		var url = "${pageContext.request.contextPath}/Q&A";

		url = url + "?page=" + page;

		url = url + "&range=" + range;

		location.href = url;

	}

	//페이지 번호 클릭

	function fn_pagination(page, range, rangeSize) {

		var url = "${pageContext.request.contextPath}/Q&A";

		url = url + "?page=" + page;

		url = url + "&range=" + range;

		location.href = url;

	}

	//다음 버튼 이벤트

	function fn_next(page, range, rangeSize) {

		var page = parseInt((range * rangeSize)) + 1;

		var range = parseInt(range) + 1;

		var url = "${pageContext.request.contextPath}/Q&A";

		url = url + "?page=" + page;

		url = url + "&range=" + range;

		location.href = url;

	}
</script>
<title>Q&A list</title>
</head>
<body>
	<h2 style="text-align: center">Q&A</h2>
	<div class="container">
		<div class="product-details">
			<!--product-details-->
			<div class="view-product">
				<table class="table" border="0"
					style="margin-left: auto; margin-right: auto;">
					<tr
						style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 20px 25px;">
						
						<th width="15%">작성자</th>
						<th>제목</th>
						<th width="10%">작성일</th>
						<th width="8%">조회수</th>
					</tr>
					<c:forEach var="row" items="${boardlist}">
						<tr>
						
							<td>${row.memberId}</td>
							<td><a
								href="${contextPath }/board/viewBoard?boardId=${row.boardId}">${row.title}</a></td>
							<td><fmt:formatDate value="${row.boardDate}"
									pattern="yyyy-MM-dd" /></td>
							<td>${row.viewCnt}</td>
						</tr>
					</c:forEach>

				</table>

				<!-- pagination{s} -->

				<div id="paginationBox" class="text-center">

					<ul class="pagination">

						<c:if test="${pagination.prev}">

							<li class="page-item"><a class="page-link" href="#"
								onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Previous</a></li>

						</c:if>



						<c:forEach begin="${pagination.startPage}"
							end="${pagination.endPage}" var="idx">
<%-- ${pagination.page == idx ? 'active' : ''} --%>
							<li
								class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a
								class="page-link" href="#"
								onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')">
									${idx} </a></li>

						</c:forEach>



						<c:if test="${pagination.next}">

							<li class="page-item"><a class="page-link" href="#"
								onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Next</a></li>

						</c:if>

					</ul>

				</div>

				<!-- pagination{e} -->

			</div>
		</div>
	</div>
</body>
</html>