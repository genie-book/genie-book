<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="container">
		<h2>${memberVO.id }님의 정보</h2>
		<div class="col-sm-8">
		<table class="table" border="0"
								style="margin-left: auto; margin-right: auto; font-size: 20px;">
		<tr>
			<th>ID</th><td>${memberVO.id }</td>
		</tr>
		<tr>
			<th>이름</th><td>${memberVO.name }</td>
		</tr>
		<tr>
			<th>휴대폰 번호</th><td>${memberVO.phoneNum }</td>
		</tr>
		<tr>
			<th>주소</th><td><pre>${addrVO.addr_num }, ${addrVO.addr_road }, ${addrVO.addr_detail }</pre></td>
		</tr>
		<tr>
			<th>총 누적 금액</th><td> ${memberVO.acc_Price }원</td>
		</tr>
		<tr>
			<th>구매 내역</th><td> 
							<button type="button" onclick="location.href='<c:url value='/purchaseHistory/${memberVO.id}'/>';" style="background: #428bca;
						 border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">보기</button>
					</td>
		</tr>
		<tr>
			<th>적립금</th><td> ${memberVO.point }점</td>
		</tr>
		<tr>
			<th>메일</th>
			<td>
				<c:choose>
					<c:when test="${memberVO.receive_email eq 1}">
						<button type="button" id = mailSending onclick="location.href='mailSending/${memberVO.id }'" style="background: #428bca;
							 border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">전송</button>
					</c:when>
					<c:otherwise>
						<button type="button" style="background: #428bca; border: medium none; border-radius: 0;
						 color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;" disabled="disabled">전송</button> 메일 수신을 거부한 사용자
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>문의내역</th>
			<td><button type="button" id = memberDetail onclick="location.href='<c:url value='/Q&A/${memberVO.id}'/>';" style="background: #428bca;
						 border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">보기</button>
			</td>
		</tr>
		</table>
		</div>
	</div>
</body>
</html>