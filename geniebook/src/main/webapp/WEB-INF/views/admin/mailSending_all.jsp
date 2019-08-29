<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="container">
<h4>회원 모두에게 메일 보내기</h4>
    <form action="mailSending_all.do" method="post">
      <div>
        <input type="text" name="toMail" size="120" value="전 회원"
        style="width: 100%" readonly="readonly"
        class="form-control">
      </div>
      <div align="center">
        <!-- 제목 -->
        <input type="text" name="mailTitle" size="120"
        style="width: 100%" placeholder="제목을 입력해주세요"
        class="form-control">
      </div>
        <p>
          <div align="center">
          <!-- 내용 -->
            <textarea name="mailContent" cols="120" rows="12"
            style="width: 100%; resize: none" placeholder="내용"
            class="form-control"></textarea>
          </div>
        <p>
      <div align="center">
      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="submit" value="메일 보내기" class="btn btn-warning" style="background-color:#428bca; border-color:#428bca;">
      </div>
    </form>
    </div>
</body>
</html>