<%-- 
    Document   : resetpassword
    Created on : Jun 11, 2024, 11:28:12 AM
    Author     : TDG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Cart</title>
	<link rel="icon" href="./img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="./vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="./vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="./vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="./vendors/linericon/style.css">
  <link rel="stylesheet" href="./vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="./vendors/owl-carousel/owl.carousel.min.css">
  <link rel="stylesheet" href="./vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="./vendors/nouislider/nouislider.min.css">
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  

  <link rel="stylesheet" href="./css/style.css">
</head>
<body>
    <!--================ Start Header Menu Area =================-->
    <jsp:include page="header.jsp"/>
    <!--================ End Header Menu Area =================-->

	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Cart Detail</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Cart Details</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  

  <!--================Cart Area =================-->
  <section class="cart_area">
      <div class="container">
          <div class="cart_inner">
              <div class="table-responsive">
                  <table class="table">
                      <thead>
                          <tr>
                              <th scope="col">Product</th>
                              <th scope="col">Price</th>
                              <th scope="col">Quantity</th>
                              <th scope="col">Total</th>
                              <th scope="col">Delete</th>
                          </tr>
                      </thead>
                      <tbody>
                          
                      <c:if test="${not empty cartItemBookMap}">
                          <c:forEach var="entry" items="${cartItemBookMap.entrySet()}">
                              <c:set var="cartItem" value="${entry.key}" />
                              <c:set var="book" value="${entry.value}" />
                              <c:set var="lineSubTotal" value="${book.price * cartItem.quantity}" />
                              <c:set var="subTotal" value="${subTotal + lineSubTotal}" />
                              <tr>
                                    <td>
                                        <div class="media">
                                            <div class="d-flex">
                                                <img src="${book.image}" alt="" style="width: 150px;">
                                            </div>
                                            <div class="media-body">
                                                <p>${book.title}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <h5>$${book.price}</h5>
                                    </td>
                                    <td>
                                        <div class="product_count">
                                            <input type="text" name="qty" id="qty-${cartItem.cartItemId}" maxlength="12" value="${cartItem.quantity}" title="Quantity:" class="input-text qty" 
                                                   oninput="updateTotalPrice(${cartItem.cartItemId}, ${book.price}, this.value)" >
                                            <button class="increase items-count" type="button" onclick="updateQuantity(${cartItem.cartItemId}, ${book.price}, 'increase')"><i class="lnr lnr-chevron-up"></i></button>
                                            <button class="reduced items-count" type="button" onclick="updateQuantity(${cartItem.cartItemId}, ${book.price}, 'decrease')"><i class="lnr lnr-chevron-down"></i></button>
                                        </div>
                                    </td>
                                    <td>
                                        <h5 id="total-price-${cartItem.cartItemId}">$${book.price * cartItem.quantity}</h5>
                                    </td>
                                    <td>
                                        <a href="#">Delete</a>
                                    </td>
                                </tr>
                                
                          </c:forEach>
                      </c:if>
                         
                          <tr class="bottom_button">
                              <td colspan="4"> 
                                  <a class="button" href="cartdetails">Update Cart</a>
                              </td>
                              <td>
                                  <div class="cupon_text d-flex align-items-center">
                                      <input type="text" placeholder="Coupon Code">
                                      <a class="primary-btn" href="#">Apply</a>
                                      <p style="padding-top: 15px;padding-left: 30px">Mã Giảm Thêm : 20%</p>
                                  </div>
                              </td>
                          </tr>
                          
                          <tr>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td>
                                  <h5>Subtotal</h5>
                              </td>
                              <td>
                                  <h5 id="total-all">${subTotal}</h5>
                              </td>
                          </tr>
                          
                          <tr class="out_button_area">
                              <td colspan="3"></td>
                              <td colspan="2">
                                  <div class="checkout_btn_inner d-flex align-items-center" style="float: right">
                                      <a class="gray_btn" href="product">Continue Shopping</a>
                                      <a class="primary-btn ml-2" href="cartcontact">Proceed to checkout</a>
                                  </div>
                              </td>
                          </tr>
                      </tbody>        
                  </table>
              </div>
              
                              
                                    
          </div>
      </div>
  </section>
  <!--================End Cart Area =================-->



    <!--================ Start footer Area  =================-->	
    <jsp:include page="footer.jsp"/>
    <!--================ End footer Area  =================-->

    <script>

function updateQuantity(cartItemId, bookPrice, action) {
    // Lấy ra giá trị hiện tại của quantity
    var quantity = parseInt(document.getElementById('qty-' + cartItemId).value);

    // Nếu hành động là tăng quantity
    if (action === 'increase') {
        quantity++;
    } 
    // Nếu hành động là giảm quantity và quantity hiện tại lớn hơn 1
    else if (action === 'decrease' && quantity > 1) {
        quantity--;
    }

    // Cập nhật giá trị mới của quantity trên giao diện
    document.getElementById('qty-' + cartItemId).value = quantity;
    // Cập nhật giá trị tổng giá trị cho sản phẩm
    document.getElementById('total-price-' + cartItemId).innerText = '$' + (quantity * bookPrice).toFixed(2);
    
    // Gửi yêu cầu cập nhật quantity lên server bằng AJAX
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            // Xử lý phản hồi từ server nếu cần
            console.log("Quantity updated successfully.");
        }
    };
    xhr.open("POST", "cartdetails?service=updateQuantity&cartItemId=" + cartItemId + "&quantity=" + quantity, true);
    xhr.send();
}

function updateTotalPrice(cartItemId, bookPrice, quantity) {
    // Parse quantity to integer
    quantity = parseInt(quantity);

    // Validate quantity
    if (isNaN(quantity) || quantity < 1) {
        quantity = 1; // Set quantity to 1 if it's NaN or less than 1
    }

    // Update the input value to display the corrected quantity
    document.getElementById('qty-' + cartItemId).value = quantity;

    // Update the total price based on the new quantity
    var totalPrice = quantity * bookPrice;
    document.getElementById('total-price-' + cartItemId).innerText = '$' + totalPrice.toFixed(2);

    // Send AJAX request to update quantity on the server
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            // Handle response from the server if needed
            console.log("Quantity updated successfully.");
        }
    };
    xhr.open("POST", "cartdetails?service=updateQuantity&cartItemId=" + cartItemId + "&quantity=" + quantity, true);
    xhr.send();
}





    </script>
    
    


  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/skrollr.min.js"></script>
  <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="vendors/jquery.ajaxchimp.min.js"></script>
  <script src="vendors/mail-script.js"></script>
  <script src="js/main.js"></script>
</body>
</html>