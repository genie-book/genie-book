<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<body onload="email_split();">
	<div class="container">
		
			<div class="breadcrumbs">
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li class="active">Check history</li>
				</ol>
			</div>


			<div class="container">
				<h2>주문 정보</h2>


				<table
					style="width: 100%; padding: 5px 0 5px 0; float: none; margin: 0 auto;">
					<tr height="2" bgcolor="#428bca">
						<td colspan="2"></td>
					</tr>
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>ID</th><td><input type="text" name="id" readonly="readonly" value="${history.id }"></td>
					</tr>
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" id="name"
							value="${history.name }" readonly="readonly"></td>
					</tr>
					<script>
						function email_split() {
							var email = ("${history.email}").split('@', 2);
							$("#email_id").val(email[0]);
							$("#email_dns").val(email[1]);
						}
					</script>
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type='text' id="email_id" readonly="readonly">@ <input
							type='text' id="email_dns" readonly="readonly"> 

					</tr>
					<tr>
						<th>주소</th>
						<td><br>
							<div class="form-group">
								<input class="form-control" style="width: 40%; display: inline;"
									placeholder="우편번호" name="addr_num" id="addr_num" type="text"
									readonly="readonly" value="${history.addr_num }">
							</div>
							<div class="form-group">
								<input class="form-control" style="top: 5px;"
									placeholder="도로명 주소" name="addr_road" id="addr_road"
									type="text" readonly="readonly" value="${history.addr_road }" />
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="상세주소"
									name="addr_detail" id="addr_detail" type="text"
									value="${history.addr_detail }" readonly="readonly" />
							</div></td>
					<tr height="2" bgcolor="#428bca">
						<td colspan="2"></td>
					</tr>
	
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td><input type="text" name="phoneNum" id="phoneNum"
							value="${history.phoneNum }" maxlength="11" readonly="readonly">
							ex)01011112222 ('-' 를 사용하지 마세요.)
					</tr>
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>요청사항</th>
						<td colspan="2"><textarea style="" name="content" rows="2"
								cols="65" maxlength="1000" placeholder="1000자 제한" readonly="readonly">${history.content}</textarea>
					</tr>
					<tr>
						<th><br> <input type="hidden"
							name="${_csrf.parameterName}" value="${_csrf.token}" /></th>
					</tr>
					<tr height="2" bgcolor="#428bca">
						<td colspan="2"></td>

					</tr>
				</table>
			</div>
			<br>
			<h2>주문상품 및 결제정보</h2>
			<section id="cart_items">
				<div class="table-responsive cart_info">
					<table class="table table-condensed">
						<thead>
							<tr class="cart_menu">
								<td class="image">Item</td>
								<td class="description"></td>
								<td class="price">Price</td>
								<td class="quantity">Quantity</td>
								<td class="total">Total</td>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(product)-1 > -1}">
								<c:forEach var="i" begin="0" end="${fn:length(product)-1}"
									step="1" varStatus="status">
									<tr>
										<td class="cart_product"><a href=""><c:if
													test="${not empty product[i].imageFileName}">
													<img
														src="${contextPath}/download2.do?imageFileName=${product[i].imageFileName}&category=${product[i].category}"
														id="image" style="width: 90px; height: 150px;" />
												</c:if></a></td>
										<td class="cart_description">
											<h4>
												&nbsp;&nbsp;&nbsp;<a href="">${product[i].bookName }</a>
											</h4>
											<p>&nbsp;&nbsp;&nbsp;&nbsp;${product[i].writer }</p>
										</td>
										<td class="cart_price">
											<p>${historyList[i].price }원</p>
										</td>
										<td class="cart_quantity"><input
											class="cart_quantity_input" type="text"
											id="quantity${status.index}"
											value="${historyList[i].quantity }" autocomplete="off"
											readonly="readonly" size="2"></td>
										<td class="cart_total">
											<p class="cart_total_price">
												<input type="text" size="8" id="totalPrice${status.index}"
													readonly="readonly" style="border: 0;"
													value="${historyList[i].price * historyList[i].quantity }원">
											</p>
										</td>

									</tr>
								</c:forEach>
							</c:if>

						</tbody>
					</table>
				</div>
			</section>


			<table align="center">
				<tr>
					<td>
						<h4>
							총액 <span> <input
								style="border: 0; text-align: right; background: white;"
								type="text" id="grandTotal2" value="${history.grandTotal}" readonly>원
							</span>
						</h4>
					</td>
				</tr>
				<tr>
				<th>
				</th>
				</tr>
				<tr style="margin:0 auto; align:center;">
				<td align="center">
					<button type="button"
						onclick="history.go(-1);" style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">
						뒤로</button>
				<td>
				</tr>
			</table>

		<br>
		<br>
	</div>
</body>
<!--/#cart_items-->