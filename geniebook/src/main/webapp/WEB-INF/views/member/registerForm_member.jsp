<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
	//아이디 영어 숫자만 가능
	function checkIdPattern() {
		/* 패턴검사 */
		var pattern1 = /^[A-Za-z0-9]{4,10}$/;

		var pattern2 = /[a-zA-Z]/;
		var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;
		var pattern4 = /^\s+|\s+$/g;
		var str = $("#id").val();

		if (pattern2.test(str)) {
			if (pattern4.test(str) || pattern3.test(str)) {
				alert("아이디는 문자,숫자로 조합하여야 합니다.");
				return false;
			}
			console.log("아이디 패턴 통과");
			return true;
		} else if (pattern2.test(str)) {
			if (pattern4.test(str) || pattern3.test(str)) {
				alert("아이디는 문자,숫자로 조합하여야 합니다.");
				return false;
			}
			console.log("아이디 패턴 통과");
			return true;
		} else {
			alert("아이디는 문자,숫자로 조합하여야 합니다.");
			return false;
		}
	}

	// 비밀번호 패턴 체크 (8자 이상, 문자, 숫자, 특수문자 포함여부 체크) 
	function checkPattern() {

		if (name_check()) {
			//아이디 중복
			if (!$("#id_check").val()) {
				console.log($("#id_check").val());
				alert('아이디 중복검사를 해주세요');
				return false;
			}
			if (house_num_check()) {
				if (phone_num_check()) {
					//주소 체크
					if (addr_check()) {
						//주민체크
						if (jumin_check()) {

							//이메일 체크
							if ($("#email_id").val() == ""
									|| $("#email_dns").val() == "") {
								console.log("id" + $("#email_id").val());
								console.log("dns" + $("#email_dns").val());
								alert('이메일을 확인해주세요');
								return false;
							}

							var email = $("#email_id").val() + "@"
									+ $("#email_dns").val();
							$("#email").val(email);
							console.log($("#email").val());

							//비밀번호 체크
							var str = $("#password").val();
							// 숫자 
							var pattern1 = /[0-9]/;
							// 문자
							var pattern2 = /[a-zA-Z]/;
							// 특수문자 
							var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;
							/* 공백 */
							var pattern4 = /^\s+|\s+$/g;

							if (pattern1.test(str) && pattern2.test(str)
									&& pattern3.test(str) && str.length >= 8
									&& !pattern4.test(str)) {

								return true;

							} else {
								alert("비밀번호는 8자리 이상 문자, 숫자, 특수문자로 구성하여야 합니다.");
								/*location.href = "registerForm_user";*/

								return false;

							}
						} else
							return false;
					} else
						return false;
				} else
					return false;
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

	function fn_overlapped() {

		if (checkIdPattern()) {
			/* 중복검사 */
			var _id = $("#id").val();
			if (_id == '') {
				alert("ID를 입력하세요");
				return;
			}
			$.ajax({
				type : "post",
				async : false,
				url : "${contextPath}/registerMember/overlapped.do",
				dataType : "text",
				data : {
					id : _id
				},
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(data, textStatus) {
					if (data == 'false') {
						alert("사용할 수 있는 ID입니다.");
						$("#id_check").val(1);
						$("#username").val(_id);

					} else {
						alert("사용할 수 없는 ID입니다.");
					}
				},
				error : function(data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete : function(data, textStatus) {
					//alert("작업을완료 했습니다");
				}
			}); //end ajax	
		}
	}
</script>
</head>
<body>

	${message}
	<div class="container">
		<center><h2>회원 가입</h2></center>

		<form action="<c:url value="/registerMember"/>" method="post">
			<table width="940" style="padding: 5px 0 5px 0; margin: 0 auto;">
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
								&& !pattern2.test(name) && !pattern3.test(name)
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
					<th><br></th>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" id="name"
						value="${memberVO.name }"></td>
				</tr>
				<tr>
					<th><br></th>
				</tr>
				<script>
					function jumin_check() {
						// 숫자 
						var pattern1 = /[0-9]/;
						// 문자
						var pattern2 = /[a-zA-Z]/;
						// 특수문자 
						var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;
						/* 공백 */
						var pattern4 = /^\s+|\s+$/g;

						var jumin1 = $("#jumin_1").val();
						var jumin2 = $("#jumin_2").val();
						var jumin = jumin1 + "-" + jumin2;
						if (pattern1.test(jumin1) && !pattern2.test(jumin1)
								&& !pattern3.test(jumin1)
								&& !pattern4.test(jumin1) && jumin1.length == 6) {
							if (pattern1.test(jumin2) && !pattern2.test(jumin2)
									&& !pattern3.test(jumin2)
									&& !pattern4.test(jumin2)
									&& jumin2.length == 7) {

								$("#jumin").val(jumin);
								return true;
							} else {
								alert("주민 번호를 확인해주세요");
								return false;
							}
						} else {
							alert("주민 번호를 확인해주세요");
							/*location.href = "registerForm_user";*/

							return false;

						}
					}
				</script>
				<tr>
					<th>주민등록번호</th>
					<td><input type="text" id="jumin_1" maxlength="6"> - <input
						type="password" id=jumin_2 maxlength="7"> <input
						type="hidden" name="jumin" id="jumin"></td>
				</tr>
				<tr>
					<th><br></th>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" id="id" size="20"
						value="${memberVO.id }" /> <input type="hidden" id="id_check" />
						<input type="hidden" name="username" id="username">
						<button type="button" class="btn btn-default" id="btnOverlapped"
							onClick="fn_overlapped();" value=0>
							<i class="fa fa-search"></i>중복체크
						</button></td>
				</tr>
				<tr>
					<th><br></th>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id=password name="password">
						영문/숫자/특수문자 포함 8자 이상</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id=password2 name="password2"></td>
				</tr>
				<tr>
					<th><br></th>
				</tr>
				<tr>
					<th>비밀번호 힌트/답변</th>
					<td><select name='pwHint' size='1' class='select'>
							<option value=''>선택하세요</option>
							<option value='졸업한 초등학교 이름은?'>졸업한 초등학교 이름은?</option>
							<option value='제일 친한 친구의 핸드폰 번호는?'>제일 친한 친구의 핸드폰 번호는?</option>
							<option value='아버지 성함은?'>아버지 성함은?</option>
							<option value='어머니 성함은?'>어머니 성함은?</option>
							<option value='어릴 적 내 별명은?'>어릴 적 내 별명은?</option>
							<option value='가장 아끼는 물건은?'>가장 아끼는 물건은?</option>
							<option value='좋아하는 동물은?'>좋아하는 동물은?</option>
							<option value='좋아하는 색깔은?'>좋아하는 색깔은?</option>
							<option value='좋아하는 음식은?'>좋아하는 음식은?</option>
					</select>
				</tr>
				<tr>

					<th>답변</th>
					<td><input type='text' name='pwHintAns'
						value="${memberVO.pwHintAns }"></td>
				</tr>
				<tr>
					<th><br></th>
				</tr>
				<tr>
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
					</script>
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
				<tr height="2" bgcolor="#428bca">
					<td colspan="2">
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
								placeholder="도로명 주소" name="addr_road" id="addr_road" type="text"
								readonly="readonly" value="${addrVO.addr_road }" />
						</div>
						<div class="form-group">
							<input class="form-control" placeholder="상세주소" name="addr_detail"
								id="addr_detail" type="text" value="${addrVO.addr_detail }" />
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

						if (pattern1.test(houseNum) && !pattern2.test(houseNum)
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

						if (pattern1.test(phoneNum) && !pattern2.test(phoneNum)
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
					<th>전화번호</th>
					<td><br> <input type="text" name="houseNum" id="houseNum"
						value="${memberVO.houseNum }" maxlength="10"> ex)027601111
						('-' 를 사용하지 마세요.)
				</tr>
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
					<th><br></th>
				</tr>
				<tr>
					<th>메일/sns 정보 수신</th>
					<td class="s"><input type="radio" name="receive_email" value=1
						checked> 수신 <input type="radio" name="receive_email"
						value=0> 수신거부</td>
				</tr>


				<tr>
					<th><br> <input type="hidden"
						name="${_csrf.parameterName}" value="${_csrf.token}" /></th>
				</tr>


				<tr height="2" bgcolor="#428bca">
					<td colspan="2"></td>

				</tr>
				<tr>
					<th><br></th>
				</tr>
				<tr>


					<td colspan="2" align="center"><input type="submit"
						onclick="return checkPattern()" value="회원가입"
						style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">

						<input type="reset" class="btn btn-default" value="다시입력"
						style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;" />
				</tr>
				<tr>
					<th><br></th>
				</tr>
			</table>

		</form>
		<!-- 		<button type="button" class="btn btn-default" onclick="history.go(-1)"
			style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">뒤로</button>
		<button type="button" class="btn btn-default"
			onclick="return checkPattern()"
			style="background: #428bca; border: medium none; border-radius: 0; color: #FFFFFF; font-family: 'Roboto', sans-serif; padding: 6px 25px;">asd</button>
	</div> -->
</body>
</html>
<!--/form-->