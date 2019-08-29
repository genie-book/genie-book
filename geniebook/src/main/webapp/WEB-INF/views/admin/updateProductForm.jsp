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
button, .button {
	border-radius: 10px;
	background: #428bca;
	border: medium none;
	color: #FFFFFF;
	font-family: 'Roboto', sans-serif;
	padding: 6px 25px;
}
</style>
<script type="text/javascript"
	src="${contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#imageFile').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
			document.getElementById("imageFile").style.display = "block";
		}
	}
	function fn_enable(obj) {
		document.getElementById("i_title").disabled = false;
		document.getElementById("i_content").disabled = false;
		document.getElementById("mod_btn").style.display = "none";
		document.getElementById("submit").style.display = "block";
		if ($('#imageFile').val() != "") {
			document.getElementById("del_btn").style.display = "block";
		}
		document.getElementById("mod_file").style.display = "block";
		//document.getElementById("tr_file_upload").style.display="block";
		//document.getElementById("tr_btn").style.display="none"; */
	}
	function del_image(obj) {
		$("#imageFileName").val("");
		document.getElementById("imageFile").style.display = "none";
	}
	/* 	$(document).ready(function() {
	 $(updateForm.category.option).each(function() {
	 if ($(obj).val() == "${productVO.category}") {
	 $(obj).attr("selected", "selected"); // attr적용안될경우 prop으로 
	 }
	 });
	 }); */
</script>
<meta charset="UTF-8">
</head>
<body>
	<div class="container">
		<h2 align="center">
			<b>${productVO.bookName}</b>
		</h2>
		<div class="col-sm-12">
			<form
				action="${contextPath}/admin/updateProduct?${_csrf.parameterName}=${_csrf.token}&bookNo=${productVO.bookNo}"
				enctype="multipart/form-data" method="post" id="updateForm">
				<table class="table" border="0"
					style="margin-left: auto; margin-right: auto; font-size: 20px;">
					<tr>
						<td rowspan="9"><input type="hidden" name="imageFileName"
							id="imageFileName" value="${productVO.imageFileName}" /> <c:choose>
								<c:when test="${not empty productVO.imageFileName}">
									<img
										src="${contextPath}/download2.do?imageFileName=${productVO.imageFileName}"
										id="imageFile" style="width: 350px; height: auto;" />
								</c:when>
								<c:otherwise>
									<img height="300" id="imageFile" src="#"
										style="width: 350px; height: auto;" />
								</c:otherwise>
							</c:choose>
							<p>
								<input type="button" value="이미지 삭제" id="del_btn"
									onClick="del_image(this.form)">
							<p>
								<input type="file" name="mod_file " id="mod_file"
									onchange="readURL(this);">
					</tr>
					<tr>
						<th>책 제목</th>
						<td><input type="text" name="bookName" id="bookName"
							style="width: 500px;" value="${productVO.bookName}"></td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td><select name="category" id="category"
							style="width: 500px;">
								<optgroup label="소설">
									<option value="novel1">나라별 소설</option>
									<option value="novel2">고전/문학</option>
									<option value="novel3">장르소설</option>
								</optgroup>
								<optgroup label="시/에세이">
									<option value="poem1">한국시</option>
									<option value="poem2">외국시</option>
									<option value="poem3">여행 에세이</option>
								</optgroup>
								<optgroup label="자기계발">
									<option value="selfDevelopment1">대화/협상</option>
									<option value="selfDevelopment2">자기능력계발</option>
								</optgroup>
								<optgroup label="인문">
									<option value="liberal1">인문일반</option>
									<option value="liberal2">심리</option>
									<option value="liberal3">철학</option>
								</optgroup>
								<optgroup label="어린이">
									<option value="child1">어린이(공통)</option>
									<option value="child2">초등</option>
								</optgroup>
						</select></td>
					</tr>
					<tr>
						<th>작가</th>
						<td><input type="text" name="writer" id="writer"
							style="width: 500px;" value="${productVO.writer}"></td>
					</tr>
					<tr>
						<th>출판사</th>
						<td><input type="text" name="publisher" id="publisher"
							style="width: 500px;" value="${productVO.publisher}"></td>
					</tr>
					<tr>
						<th>출판 날짜</th>
						<td><input type="date" name="pubYear" id="pubYear"
							value="${pubDate}"></td>
					</tr>
					<tr>
						<th>가격</th>
						<td><input type="number" name="price" id="price"
							value="${productVO.price}"></td>
					</tr>
					<tr>
						<th>재고</th>
						<td><input type="number" name="stock" id="stock"
							value="${productVO.stock}"></td>
					<tr>
						<th>상세 정보</th>
						<td width="55%"><textarea name="description" id="description"
								rows="10">${productVO.description}</textarea></td>
					</tr>
					<tr align="center">
						<td colspan="3"><input type="reset" value="초기화"
							class="button" />&nbsp; <input type="submit" value="수정하기"
							class="button"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>