<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<head>
<meta charset="UTF-8">
<title>글쓰기창</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	 function readURL(input) {
	   if (input.files && input.files[0]) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        $('#preview').attr('src', e.target.result);
	       }
	      reader.readAsDataURL(input.files[0]);
	   }
	}   
	function backToList(obj) {
		obj.action = "${contextPath}/board/listboards?${_csrf.parameterName}=${_csrf.token}";
		obj.submit();
	}

	 var cnt=1;
	function fn_addFile(){
	  $("#d_file").append("<br>"+"<input type='file' name='file"+cnt+"' />");
	  cnt++;
	}
	
</script>
<title>글쓰기창</title>
</head>
<body>

<%-- <th><br> <input type="hidden"
						name="${_csrf.parameterName}" value="${_csrf.token}" /></th>
				</tr> --%>
	<h1 style="text-align: center">Q&A 답글 쓰기</h1>
	<div class="container">
		<form name="replyForm" method="post"
			action="${contextPath}/board/replyBoard?${_csrf.parameterName}=${_csrf.token}&originNo=${originNo}&groupOrd=${groupOrd}&groupLayer=${groupLayer}" enctype="multipart/form-data">
			<!-- " -->
			<table class="table" border="0" align="center">
				<tr>
					<td align="right">작성자</td>
					<td colspan=2 align="left"><label>${memberId}</label>
					<input type="hidden" name="memberId" value="${memberId }">
					<input type="hidden" name="originNo" value="${originNo }">
					<input type="hidden" name="groupOrd" value="${groupOrd }">
					<input type="hidden" name="groupLayer" value="${groupLayer }">
					</td>
				</tr>
				<tr>
					<td align="right">글제목</td>
					<td colspan="2"><input type="text" size="67" maxlength="500"
						name="title" placeholder="제목을 입력해주세요." /></td>
				</tr>
				<tr>
					<td align="right" valign="top"><br>글내용</td>
					<td colspan="2"><textarea name="content" rows="10" cols="65"
							maxlength="4000" placeholder="내용을 입력해주세요."></textarea></td>
				</tr>
				<tr>
					<td align="right">이미지파일 첨부</td>
			  <td><input type="hidden" name="imageFileName" value="" >
			  <input type="file" name="uploadFile"  onchange="readURL(this);" /></td>
			  <td><img  id="preview" src="#"   width=200 height=200/></td>
			  
			  
			  <!-- <td >이미지파일 첨부</td>
				<td > <input type="button" value="파일 추가" onClick="fn_addFile()"/></td> -->
				</tr>
				
				<!-- <tr>
				
				

			</tr>
			
			<tr>
				<td colspan="4"><div id="d_file"></div></td>
			</tr> -->
					
				<tr>
					<td align="right"></td>
					<td colspan="2"><input type="submit" value="글쓰기" 
					style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;"/> <input
						type=button value="목록보기" onClick="backToList(this.form)" 
						style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;"/></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>