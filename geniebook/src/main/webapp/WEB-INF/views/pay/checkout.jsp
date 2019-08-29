<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>
	// 비밀번호 패턴 체크 (8자 이상, 문자, 숫자, 특수문자 포함여부 체크) 
	function checkPattern() {

		if (phone_num_check()) {
			//주소 체크
			if (addr_check()) {
				//이메일 체크
				if ($("#email_id").val() == "" || $("#email_dns").val() == "") {
					console.log("id" + $("#email_id").val());
					console.log("dns" + $("#email_dns").val());
					alert('이메일을 확인해주세요');
					return false;
				}

				var email = $("#email_id").val() + "@" + $("#email_dns").val();
				$("#email").val(email);
				console.log($("#email").val());

				if(payment()){
					return true;
				}else{
					return false;
				}
			} else
				return false;
		} else
			return false;
	}

	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				console.log(data.zonecode);
				console.log(fullRoadAddr);

				$("[name=addr_num]").val(data.zonecode);
				$("[name=addr_road]").val(fullRoadAddr);

				/* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
				document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
			}
		}).open();
	}

	function payment() {
		var pay = confirm('구매하시겠습니까?');
		return pay;
	}
</script>
<body onload="email_split();">
	<div class="container">
		<form action="<c:url value="/payment"/>" method="post">
			<div class="breadcrumbs">
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li class="active">Check out</li>
				</ol>
			</div>


			<div class="container">
				<h2>주문 정보</h2>


				<table
					style="width: 100%; padding: 5px 0 5px 0; float: none; margin: 0 auto;">
					<tr height="2" bgcolor="#428bca">
						<td colspan="2"></td>
					</tr>
					<script>
						function name_check() {
							var pattern = /^[가-힣]{2,4}$/;
							// 숫자 
							var pattern1 = /[0-9]/;
							// 문자
							var pattern2 = /[a-zA-Z]/;
							// 특수문자 
							var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;
							/* 공백 */
							var pattern4 = /^\s+|\s+$/g;

							var name = $("#name").val();

							if (pattern.test(name) && !pattern1.test(name)
									&& !pattern2.test(name)
									&& !pattern3.test(name)
									&& !pattern4.test(name)) {
								return true;

							} else {
								alert("이름을 확인해주세요");
								/*location.href = "registerForm_user";*/

								return false;
							}
						}
					</script>
					<tr>
						<th><input type="hidden" name="id" value="${memberVO.id }"></th>
					</tr>
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" id="name"
							value="${memberVO.name }"></td>
					</tr>
					<script>
						function selectEmail() {
							if ($("#email_select option:selected").val() != "") {
								console.log($("#email_select option:selected")
										.val());
								$("#email_dns").val(
										$("#email_select option:selected")
												.val());
								$("#email_dns").attr("readonly", true);
							} else {
								$("#email_dns").removeAttr("readonly");
							}

						}

						function email_split() {
							var email = ("${memberVO.email}").split('@', 2);
							$("#email_id").val(email[0]);
							$("#email_dns").val(email[1]);
						}
					</script>
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type='text' id="email_id">@ <input
							type='text' id="email_dns"> <select id="email_select"
							onchange="selectEmail()">
								<option value="">직접입력</option>
								<option value="daum.net">daum.net</option>
								<option value="empal.com">empal.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="msn.com">msn.com</option>
								<option value="naver.com">naver.com</option>
								<option value="nate.com">nate.com</option>
						</select> <input type="hidden" name="email" id="email"> <br> <br></td>

					</tr>
					<tr>
						<script>
							function addr_check() {
								if ($("#addr_num").val() == ""
										|| $("#addr_road").val() == "") {
									alert("주소를 입력해주세요.");
									return false;
								} else {
									return true;
								}
							}
						</script>
						<th>주소</th>
						<td><br>
							<div class="form-group">
								<input class="form-control" style="width: 40%; display: inline;"
									placeholder="우편번호" name="addr_num" id="addr_num" type="text"
									readonly="readonly" value="${addrVO.addr_num }">
								<button type="button" class="btn btn-default"
									onclick="execPostCode();">
									<i class="fa fa-search"></i> 우편번호 검색
								</button>
							</div>
							<div class="form-group">
								<input class="form-control" style="top: 5px;"
									placeholder="도로명 주소" name="addr_road" id="addr_road"
									type="text" readonly="readonly" value="${addrVO.addr_road }" />
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="상세주소"
									name="addr_detail" id="addr_detail" type="text"
									value="${addrVO.addr_detail }" />
							</div></td>
					<tr height="2" bgcolor="#428bca">
						<td colspan="2"></td>
					</tr>
					<script>
						function house_num_check() {
							// 숫자 
							var pattern1 = /[0-9]/;
							// 문자
							var pattern2 = /[a-zA-Z]/;
							// 특수문자 
							var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;
							/* 공백 */
							var pattern4 = /^\s+|\s+$/g;

							var houseNum = $("#houseNum").val();

							if (pattern1.test(houseNum)
									&& !pattern2.test(houseNum)
									&& !pattern3.test(houseNum)
									&& !pattern4.test(houseNum)) {
								return true;
							} else {
								alert("전화번호를 확인해주세요.");
								return false;
							}
						}

						function phone_num_check() {
							// 숫자 
							var pattern1 = /[0-9]/;
							// 문자
							var pattern2 = /[a-zA-Z]/;
							// 특수문자 
							var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;
							/* 공백 */
							var pattern4 = /^\s+|\s+$/g;

							var phoneNum = $("#phoneNum").val();

							if (pattern1.test(phoneNum)
									&& !pattern2.test(phoneNum)
									&& !pattern3.test(phoneNum)
									&& !pattern4.test(phoneNum)) {
								return true;
							} else {
								alert("핸드폰번호를 확인해주세요.");
								return false;
							}
						}
					</script>

					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td><input type="text" name="phoneNum" id="phoneNum"
							value="${memberVO.phoneNum }" maxlength="11">
							ex)01011112222 ('-' 를 사용하지 마세요.)
					</tr>
					<tr>
						<th><br></th>
					</tr>
					<tr>
						<th>요청사항</th>
						<td colspan="2"><textarea style="" name="content" rows="2"
								cols="65" maxlength="1000" placeholder="1000자 제한"></textarea>
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
											<p>${product[i].price }원</p>
										</td>
										<td class="cart_quantity"><input
											class="cart_quantity_input" type="text"
											id="quantity${status.index}"
											value="${cartItemList[i].quantity }" autocomplete="off"
											readonly="readonly" size="2"></td>
										<td class="cart_total">
											<p class="cart_total_price">
												<input type="text" size="8" id="totalPrice${status.index}"
													readonly="readonly" style="border: 0;"
													value="${cartItemList[i].totalPrice }원">
											</p> <input type="hidden" name="cartId" value="${cartId }">
										</td>

									</tr>
								</c:forEach>
							</c:if>

						</tbody>
					</table>
				</div>
			</section>


			<table align="center">
				<tr align="center">
					<td>
						<h4>
							총액 <span> <input
								style="border: 0; text-align: right; background: white;"
								type="text" id="grandTotal2" value="${grandTotal}" readonly>원
							</span>
						</h4>
					</td>
				</tr>
				<tr>
				<th>
				</th></tr>
				<tr align="center">
					<td align="center"><input type="submit"
						onclick="return checkPattern();" value="결제하기"
						style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">
					</td>
				</tr>
			</table>
		</form>
		<br>
		<br>
	</div>
</body>
<!--/#cart_items-->