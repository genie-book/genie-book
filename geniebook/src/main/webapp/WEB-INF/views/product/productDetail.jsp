<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<fmt:formatDate var="pubDate" value="${product.pubYear}"
	pattern="yyyy-MM-dd" />
<%
	request.setCharacterEncoding("UTF-8");
%>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

function getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex
			.exec(location.search);
	return results === null ? "" : decodeURIComponent(results[1].replace(
			/\+/g, " "));
}
function reviewList() {
	var bookNo = getParameterByName('bookNo');
	$.getJSON("${contextPath}/review/all/" + bookNo, function(data) {
		var str = "";

		$(data).each(
				function() {
					var loginId = "${pageContext.request.userPrincipal.name}";
					console.log(data);
					//alert("${memberId}");
					var reviewDate = new Date(this.reviewDate);
					reviewDate = reviewDate.toLocaleDateString("ko-US");
					if(loginId == this.memberId){
						str += "<ul><li id='review"+ this.reviewId +"' data-reviewId='" + this.reviewId + "'>"
								+ "<div class='memberId' >" + this.memberId
								+ "</div>" + "<span class='date'>" + reviewDate
								+ "</span>" + "</div>"
								+ "<div class='content' >" + this.content
								+ "</div>"
								+ "<button type='button' onclick='updatebtn("+ this.reviewId +");' class='btn btn-success' data-toggle='modal' data-target='#updateReviewModal'>수정</button>"
								+ "</li></ul>";
					}else{
						str += "<ul><li id='review"+ this.reviewId +"' data-reviewId='" + this.reviewId + "'>"
							+ "<div class='memberId' >" + this.memberId
							+ "</div>" + "<span class='date'>" + reviewDate
							+ "</span>" + "</div>"
							+ "<div class='content' >" + this.content
							+ "</div>"
							+ "</li></ul>";
					}
					//alert(this.reviewId);
				});

		$('.reviewList').html(str);
	});
}
function insertReview() {
	var bookNo = getParameterByName('bookNo');
	var content = $('#reply').val();
	var memberId = $('#memberId').val();
	//alert(memberId);
	//alert("content : " + content);
	$.ajax({
		type : "post",
		url : "${contextPath}/review",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		headers : {
			"Content-type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : "text",
		data : JSON.stringify({
			memberId : memberId,
			bookNo : bookNo,
			content : content
		}),
		success : function(result) {
			if (result == "insertSuccess") {
				alert('댓글 등록 완료!');
			}
			reviewList();
			$('#reply').val('');
		}
	});
}

function updatebtn(no){
	var reviewId = no;
	$('#update_reviewId').val(reviewId);
} 

function updateReview(){
	var reviewId = $('#update_reviewId').val();
	var updateContent = $('#update_review').val();
	
	$.ajax({
		type : "put",
		url : "${contextPath}/review/" + reviewId,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		headers : {
			"Content-type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data : JSON.stringify({
			reviewId : reviewId,
			content : updateContent
		}),
		dataType : "text",
		success : function(result){
			console.log("result : " + result);
			if(result == "updateSuccess"){
				alert("댓글 수정 완료!");
				$("#updateReviewModal").modal("hide");
				reviewList();
			}
		}
	});
}

function deleteReview(){
	var reviewId = $('#update_reviewId').val();
	
	$.ajax({
		type : "delete",
		url : "${contextPath}/review/" + reviewId,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		headers : {
			"Content-type" : "application/json",
			"X-HTTP-Method-Override" : "DELETE"
		},
		dataType : "text",
		success : function(result){
			console.log("result : " + result);
			if(result == "deleteSuccess"){
				alert("댓글 삭제 완료!");
				$("#updateReviewModal").modal("hide");
				reviewList();
			}
		}
	});
}
	function backToList(obj) {
		obj.action = "${contextPath}/board/listboards";
		obj.submit();
	}

	function go_to_cart(){
		var url = "api/cart/add/${product.bookNo}/"+$("#quantity").val();
		
		if(${pageContext.request.userPrincipal.name == null}){
			alert('로그인이 필요합니다.');
			location.href='login';
		}else{
			location.href=url;
		}
	}
</script>

<div class="container">
	<div class="row">
		<div class="col-sm-9 padding-right">
			<div class="product-details">
				<!--product-details-->
				<div class="col-sm-5">
					<div class="view-product">
						<c:if test="${not empty product.imageFileName}">
							<img src="${contextPath}/download2.do?imageFileName=${product.imageFileName}"
								id="image" style="width: 280px; height: auto;" />
						</c:if>
					</div>
				</div>

				<div class="col-sm-7">
					<div class="product-information">
						<!--/product-information-->
						<h2>${product.bookName}</h2>
						
						<p>${product.writer}</p>
						<img
							src="<c:url value="/resources/images/product-details/rating.png"/>"
							alt="" /> <span> <span>${product.price}원</span> <label>수량:</label>
							<input type="text" value="1" id="quantity"/>
							<c:if test="${pageContext.request.userPrincipal.name != 'admin'}">
							<button type="button" class="btn btn-fefault cart" onclick="go_to_cart()">
								<i class="fa fa-shopping-cart"></i> 장바구니
							</button>
							</c:if>
						</span>
						<p>
							<b>출판사:</b> ${product.publisher}
						</p>
						<p>
							<b>출간날짜:</b> ${pubDate}
						</p>
					</div>
					<!--/product-information-->
				</div>
			</div>

			<!--/product-details-->
			<div class="category-tab shop-details-tab">
				<!--category-tab-->
				<script type="text/javascript">
					function detail() {
						var detail = document.getElementById("reviews");
						detail.style.display = "none";
					}
					function review() {
						var review = document.getElementById("reviews");
						review.style.display = "block";
					}
				</script>
				<div class="col-sm-12">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#details" onclick="detail();"
							data-toggle="tab">Details</a></li>
						<li><a href="#reviews" data-toggle="tab" onclick="review();">Review</a></li>
					</ul>
				</div>
				<div class="tab-content">
					<div class="tab-pane fade active in" id="details">
						${product.description }</div>

						<div class="tab-pane fade" id="reviews"
							style="margin: 0 auto; display: none;">
							
							
						<!-- 여기부터 댓글주석 -->


							<section class="content container-fluid">
								<div class="col-lg-12">
									<div class="box box-primary">
										<div class="box-header with-border">
											<h3 class="box-title">리뷰 작성</h3>
										</div>
										<div class="box-body">
											<c:if test="${pageContext.request.userPrincipal.name != null }">
												<div class="form-group">
													<label for="memberId">댓글 작성자</label><br> <input type="hidden"
														class="form-control" id="memberId" name="memberId"
														style="border: 0;" value="${pageContext.request.userPrincipal.name}" disabled> 
														<label >${pageContext.request.userPrincipal.name}님</label>
												</div>
												<div class="form-group">
													<label for="content">댓글 내용</label> <input type="text"
														class="form-control" id="reply" name="content"
														placeholder="댓글 내용을 입력해주세요." style="width: 100%;">
												</div>
												<div class="form-group">
													<a class="btn btn-primary" onclick="insertReview();">댓글 저장</a>
												</div>
											</c:if>
											<c:if test="${pageContext.request.userPrincipal.name == null  }">
												<label> <a href="${contextPath }/login">로그인</a> 하셔야 댓글을 작성할 수 있습니다. </label>
											</c:if>
										</div>
										<div class="box-footer">
											<section class="reviewList">
												<script>
													reviewList();
												</script>
											</section>
										</div>
									</div>
								</div>
							</section>
							
							<div class="modal fade" id="updateReviewModal" role="dialog">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">댓글 수정창</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
													<label for="reviewId">댓글 번호</label> <input type="text"
														class="form-control" id="update_reviewId" name="reviewId"
														style="border: 0;" disabled>
											</div>
											<div class="form-group">
													<label for="memberId">댓글 작성자</label> <input type="text"
														class="form-control" id="update_memberId" name="memberId"
														style="border: 0;" value="${pageContext.request.userPrincipal.name}" disabled>
											</div>
											<div class="form-group">
												<label for="content">댓글 내용</label> <input type="text"
														class="form-control" id="update_review" name="content"
														placeholder="댓글 내용을 입력해주세요." style="width: 100%;">
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
											<button type="button" class="btn btn-success" onclick="updateReview();">수정</button>
											<button type="button" class="btn btn-danger" onclick="deleteReview();">삭제</button>
										</div>
									</div>
								</div>
							</div>
							<!-- 여기까지 댓글 주석  -->
							
							
							
						</div>

					</div>
				</div>
				<!--/category-tab-->
			</div>
		</div>
	</div>
</div>