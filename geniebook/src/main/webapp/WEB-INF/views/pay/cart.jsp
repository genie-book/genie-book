<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>
	function delete_cartItem(cartId, bookNo){
		$.ajax({
			type : "post",
			
			url : "${contextPath}/api/cart/delete/"+cartId+"/"+bookNo,
			dataType : "text",
			data : {
				
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(data, textStatus) {}
		}); 
	}
	
	function plus_cartItem(index ,cartId, bookNo){
		
		var grand = parseInt($("#grandTotal1").val());
		$.ajax({	
			type : "post",
			url : "${contextPath}/api/cart/plus/"+cartId+"/"+bookNo,

			dataType: "json",
			data: {},
			async: true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(data){
				$("#totalPrice"+index).val(data.totalPrice+"원");
				$("#quantity"+index).val(data.quantity);
				$("#grandTotal1").val(grand+parseInt(data.price));
				$("#grandTotal2").val(grand+parseInt(data.price));
				if($("#grandTotal1").val() >= 50000){
					$("#qothd").val(0);
				}
				
			}
		});
	}
	
	function minus_cartItem(index, cartId, bookNo){	

		var grand = parseInt($("#grandTotal1").val());
		$.ajax({	
			type : "post",
			url : "${contextPath}/api/cart/minus/"+cartId+"/"+bookNo,

			dataType: "json",
			data: {},
			async: true,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(data){
				console.log(typeof(data.message));
				if(data.message == "true"){
					$("#totalPrice"+index).val(data.totalPrice+"원");
					$("#quantity"+index).val(data.quantity);
					$("#grandTotal1").val(grand-parseInt(data.price));
					$("#grandTotal2").val(grand-parseInt(data.price));
					if($("#grandTotal1").val() <= 50000){
						$("#qothd").val(2500);
						$("#grandTotal2").val(grand-parseInt(data.price)+2500)
					}
				}else{
					alert('최소 수량은 1 입니다');
				}
			}
		});
	}
/* 	 function check(){
		   var fm = document.forms[0];
		   var nn = fm.num.value;
		   if(!isNaN(nn)){
		    if(nn > 50000){
		     return 무료;
		    }else{
		     return 2000;
		    }
		   }
		  } */
</script>
<section id="cart_items">
	<div class="container">
		<div class="breadcrumbs">
			<ol class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li class="active">Shopping Cart</li>
			</ol>
		</div>
		<h2>${id }님의장바구니</h2>
		<div class="table-responsive cart_info">
			<table class="table table-condensed">
				<thead>
					<tr align="center" class="cart_menu">
						<td colspan="2" class="image">Item</td>
						<!-- <td class="description"></td> -->
						<td class="price">Price</td>
						<td class="quantity">Quantity</td>
						<td class="total">Total</td>
						<td></td>
					</tr>
				</thead>
				<tbody onload="total">
					<c:if test="${fn:length(product)-1 > -1}">
						<c:forEach var="i" begin="0" end="${fn:length(product)-1}"
							step="1" varStatus="status">
							<tr align="center">
								<td class="cart_product"><a href=""><c:if
											test="${not empty product[i].imageFileName}">
											<img
												src="${contextPath}/download2.do?imageFileName=${product[i].imageFileName}&category=${product[i].category}"
												id="image" style="width: 100px; height: 150px;" />
										</c:if></a></td>
								<td class="cart_description">
									<h4>
										<a href="">${product[i].bookName }</a>
									</h4>
									<p>${product[i].writer }</p>
								</td>
								<td class="cart_price">
									<p>${product[i].price }원</p>
								</td>
								<td class="cart_quantity"
									style="float: none; width: 12%; margin: 0 auto;">
									<div class="cart_quantity_button">
										<a class="btn btn-danger"
											onclick="minus_cartItem(${status.index}, ${cartItemList[i].cartId}, ${product[i].bookNo});"
											style="background-color: white; margin-bottom: 3px;"><i
											class="fa fa-minus"></i></a> <input style="text-align: center"
											class="cart_quantity_input" type="text"
											id="quantity${status.index}" name="quantity"
											value="${cartItemList[i].quantity }" autocomplete="off"
											readonly="readonly" size="2"> <a
											class="btn btn-danger"
											onclick="plus_cartItem(${status.index},${cartItemList[i].cartId}, ${product[i].bookNo} );"
											style="background-color: white; margin-bottom: 3px;"><i
											class="fa fa-plus"></i></a>
									</div>
								</td>
								<td class="cart_total">
									<p class="cart_total_price">
										<input type="text" size="8" id="totalPrice${status.index}"
											readonly="readonly" style="border: 0; text-align: center;"
											value="${cartItemList[i].totalPrice }원">
									</p>
								</td>
								<td class="cart_delete"><a class="btn btn-danger"
									style="background-color: red; margin-bottom: 15px;" href=""
									onclick="delete_cartItem(${cartItemList[i].cartId}, ${product[i].bookNo} )"><i
										class="fa fa-times"></i></a></td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</section>
<!--/#cart_items-->

<section id="do_action">
	<div class="container">
		<div class="heading"></div>
		<div class="row">

			<div class="col-sm-9" style="float: none; margin: 0 auto;">
				<div class="total_area">
					<ul>
						<h3>전체 합계</h3>
						<br>
						<li>상품 금액 <span><input
								style="border: 0; text-align: right; background: #E6E4DF;"
								type="text" id="grandTotal1" value="${grandTotal}" readonly>원</span>
						</li>
						<!-- <li>Eco Tax <span>$2</span></li> -->
						<li>배송비<span> <input
								style="border: 0; text-align: right; background: #E6E4DF;"
								type="text" id="qothd" value="0" readonly> 원
						</span></li>
						<li>총액 <span><input
								style="border: 0; text-align: right; background: #E6E4DF;"
								type="text" id="grandTotal2" value="${grandTotal}" readonly>원</span>
						</li>
						<h6>
							<span style="color: red">*5만원 이상 구매시 무료배송</span>
						</h6>
						<br>
					</ul>
					<div align="center">
						<a class="btn btn-default update"
							href="<c:url value="/cartRemoveAll?cartId=${cartId}"/>">비우기</a> <a
							class="btn btn-default check_out"
							href="<c:url value="/checkout/${id}/${cartId}"/>">주문하기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--/#do_action-->
