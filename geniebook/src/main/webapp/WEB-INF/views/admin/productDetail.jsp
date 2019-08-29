<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<fmt:formatDate var="pubDate" value="${productVO.pubYear}"
	pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
button {
	border-radius: 10px;
	background: #428bca;
	border: medium none;
	color: #FFFFFF;
	font-family: 'Roboto', sans-serif;
	padding: 6px 25px;
}
</style>

<script type="text/javascript">
	function del_image(obj) {
		$("#uploadFile").val("");
		document.getElementById("image").style.display = "none";
	}

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	function fn_enable(obj) {
		document.getElementById("i_title").disabled = false;
		document.getElementById("i_content").disabled = false;
		document.getElementById("mod_btn").style.display = "none";
		document.getElementById("submit").style.display = "block";
		if ($('#uploadFile').val() != "") {
			document.getElementById("del_btn").style.display = "block";
		}
		document.getElementById("mod_file").style.display = "block";
		//document.getElementById("tr_file_upload").style.display="block";
		//document.getElementById("tr_btn").style.display="none"; */
	}
	function refresh(no){
		if(no > 0){
			alert('완료되었습니다.');
			location.href="productDetail?bookNo=${bookNo}";
		}else if(no == 0){
			alert('취소되었습니다.');
			location.href="productDetail";
		}	
	}
</script>
<meta charset="UTF-8">
</head>
<body onload="refresh(${updateStatus})">
	<div class="container">
		<h2 align="center">
			<b>${productVO.bookName}</b>
		</h2>
		<div class="col-sm-12">
			<table class="table" border="0"
				style="margin-left: auto; margin-right: auto; font-size: 20px;">
				<tr>
					<td rowspan="9"><c:if
							test="${not empty productVO.imageFileName}">
							<img
								src="${contextPath}/download2.do?imageFileName=${productVO.imageFileName}"
								id="image" style="width: 350px; height: auto;" />
						</c:if>
				</tr>
				<tr>
					<th>책 제목</th>
					<td>${productVO.bookName}</td>
					<td></td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>${categories.get(productVO.category)}</td>
				</tr>
				<tr>
					<th>작가</th>
					<td>${productVO.writer}</td>
				</tr>
				<tr>
					<th>출판사</th>
					<td>${productVO.publisher}</td>
				</tr>
				<tr>
					<th>출판 날짜</th>
					<td>${pubDate}</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>${productVO.price}</td>
				</tr>
				<tr>
					<th>재고</th>
					<td>${productVO.stock}</td>
				</tr>
				<tr>
					<th>상세 정보</th>
					<td width="55%">${productVO.description}</td>
				</tr>
				<tr align="center">
					<td colspan="3"><button onclick="history.go(-1)">뒤로가기</button>&nbsp;
						<button
							onclick="location.href='updateProductForm?bookNo=${productVO.bookNo}'">수정하기</button></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>