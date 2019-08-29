var cartApp = angular.module('cartApp', []);

cartApp.controller("cartCtrl", function($scope, $http) {

	$scope.initCartId = function(cartId) {
		$scope.cartId = cartId;
		$scope.refreshCart();
	};

	$scope.refreshCart = function() {
		$http.get('/geniebook/api/cart/' + $scope.cartId).then(
				function successCallback(response) {
					$scope.cart = response.data;
				});

	};

	$scope.clearCart = function() {

		$scope.setCsrfToken();

		$http({
			method : 'DELETE',
			url : '/geniebook/api/cart/' + $scope.cartId
		}).then(function successCallback() {
			$scope.refreshCart();
		}, function errorCallback(response) {
			console.log(response.data);
		});
	};

	$scope.addToCart = function(productId) {

		$scope.setCsrfToken();

		$http.put('/geniebook/api/cart/add/' + productId).then(
				function successCallback() {
					alert("Prodcut successfully added to the cart!");
				}, function errorCallback() {
					alert("Adding to the cart failed!")
				});
	};

	$scope.removeFromCart = function(productId) {

		$scope.setCsrfToken();

		$http({
			method : 'DELETE',
			url : '/geniebook/api/cart/cartItem/' + productId
		}).then(function successCallback() {
			$scope.refreshCart();
		}, function errorCallback(response) {
			console.log(response.data);
		});
	};

	$scope.plusFromCart = function(productId) {
		$scope.setCsrfToken();
		$http.put('/geniebook/api/cart/plus/' + productId).then(
				function successCallback() {
					$scope.refreshCart();
				}, function errorCallback(response) {
					$scope.refreshCart();
				});
	};
	$scope.minusFromCart = function(productId) {
		$scope.setCsrfToken();
		$http.put('/geniebook/api/cart/minus/' + productId).then(
				function successCallback() {
					$scope.refreshCart();
				}, function errorCallback(response) {
					alert("minus Error");
					$scope.refreshCart();
				});
	};
	$scope.calGrandTotal = function(){
		var grandTotal = 0;
		for(var i=0; i<$scope.cart.cartItems.length; i++){
		grandTotal += $scope.cart.cartItems[i].totalPrice;
		}
		return grandTotal;
	};

	$scope.setCsrfToken = function() {
		var csrfToken = $("meta[name='_csrf']").attr("content");
		var csrfHeader = $("meta[name='_csrf_header']").attr("content");
		$http.defaults.headers.common[csrfHeader] = csrfToken;
	}

});