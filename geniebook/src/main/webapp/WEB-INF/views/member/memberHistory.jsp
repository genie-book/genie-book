<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<body>
	<div class="container">
		<table class="table" border="0"
			style="margin-left: auto; margin-right: auto;">

			<tr
				style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">
				<th>날짜</th>
				<th>ID</th>
				<th>제품명</th>
				<th>총 가격</th>
				<th></th>
			</tr>
			<c:if test="${fn:length(historyList)-1 >= 0}">
			<c:forEach var="i" begin="0" end="${fn:length(historyList)-1}"
							step="1" varStatus="status">

				<c:choose>
					<c:when test="${status.index > 0}">
						<c:choose>
						<c:when
							test="${historyList[i].purchase_date == historyList[i-1].purchase_date}">
							
						</c:when>
						<c:otherwise>
							<tr>
								<td><fmt:formatDate value="${historyList[i].purchase_date}"	pattern="yyyy-MM-dd" /></td>
								<td>${historyList[i].id}</td>
								<td>${productName[i]}...</td>
								<td>${historyList[i].grandTotal }원</td>
								<td>
									<form action="<c:url value="/historyDetail"/>" method="post" accept-charset="utf-8">
										<input type="hidden" name="id" value="${historyList[i].id}">
										<input type="hidden" name="purchase_date" value="${historyList[i].purchase_date}">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="submit" value="상세 보기">
									</form>
								</td>
							</tr>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<tr>
								<td><fmt:formatDate value="${historyList[i].purchase_date}"	pattern="yyyy-MM-dd" /></td>
								<td>${historyList[i].id}</td>
								<td>${productName[i]}...</td>
								<td>${historyList[i].grandTotal }원</td>
								<td><form action="<c:url value="/historyDetail"/>" method="post" accept-charset="utf-8">
										<input type="hidden" name="id" value="${historyList[i].id}">
										<input type="hidden" name="purchase_date" value="${historyList[i].purchase_date}">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="submit" value="상세 보기">
									</form></td>
							</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</c:if>
		</table>
	</div>
</body>
