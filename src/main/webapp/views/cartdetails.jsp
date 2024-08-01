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
        <title>Cart</title>
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
        <script>

        </script>
    </head>

    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>
        <!--================ End Header Menu Area =================-->

        <!--================ Start Progress Bar ================-->

        <div class="d-flex justify-content-center align-items-center mt-4 mb-4">
            <div class="progresses">
                <div class="steps">
                    <span class="font-weight-bold">1</span>
                </div>
                <div class="progress-bar-text ml-2 mr-2">Giỏ hàng</div>
                <span class="line mr-2"></span>

                <div class="steps">
                    <span class="font-weight-bold">2</span>
                </div>
                <div class="progress-bar-text ml-2 mr-2">Xác nhận</div>
                <span class="line mr-2"></span>

                <div class="steps">
                    <span class="font-weight-bold">3</span>
                </div>
                <div class="progress-bar-text ml-2 mr-2">Thanh Toán</div>
            </div>    
        </div>
        <!--================ End Progress Bar ================-->

        <!--================Cart Area =================-->
        <section class="cart_area">
            <div class="container">
                <div class="cart_inner">
                    <h2>Chi Tiết Giỏ Hàng</h2>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sản Phẩm</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col">Số Lượng</th>
                                    <th scope="col">Thành Giá</th>
                                    <th scope="col">Xóa Sản Phẩm</th>
                                </tr>
                            </thead>


                            <c:if test="${not empty cartItemBookMap}">
                                <c:forEach var="entry" items="${cartItemBookMap.entrySet()}">
                                    <c:set var="cartItem" value="${entry.key}" />
                                    <c:set var="book" value="${entry.value}" />
                                    <c:set var="lineSubTotal" value="${(book.price * cartItem.quantity * (100 - book.discount) / 100)}" />
                                    <c:set var="subTotal" value="${subTotal + lineSubTotal}" />
                                    <tr>
                                        <td>
                                            <div class="media">
                                                <div class="d-flex">
                                                    <img src="${book.image}" alt="" style="width: 180px;height: 250px">
                                                </div>
                                                <div class="media-body">
                                                    <p style="width: 200px;">${book.title}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <h5>
                                                <!--${book.price * 1000}-->
                                                <!--<p class="card-product__price">${(book.price * (100 - book.discount) / 100 * 1000)} đ</p>-->
                                                <fmt:formatNumber value="${book.price * (100 - book.discount) / 100}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                            </h5>
                                        </td>
                                        <td>
                                            <div class="product_count">
                                                <input type="text" name="qty" id="qty-${cartItem.cartItemId}" maxlength="12" value="${cartItem.quantity}" title="Quantity:" class="input-text qty" 
                                                       onchange="updateTotalPrice(${cartItem.cartItemId}, ${book.price}, ${book.discount}, ${book.stock})" >
                                                <button class="increase items-count" type="button" onclick="updateQuantity(${cartItem.cartItemId}, ${book.price}, ${book.discount}, ${book.stock}, 'increase')"><i class="lnr lnr-chevron-up"></i></button>
                                                <button class="reduced items-count" type="button" onclick="updateQuantity(${cartItem.cartItemId}, ${book.price}, ${book.discount}, ${book.stock}, 'decrease')"><i class="lnr lnr-chevron-down"></i></button>
                                            </div>
                                        </td>
                                        <td>
                                            <h5 id="total-price-${cartItem.cartItemId}">
                                                <!--<p class="card-product__price">${lineSubTotal} đ</p>-->
                                                <fmt:formatNumber value="${lineSubTotal}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                            </h5>
                                            <input type="hidden" name="lineSubTotal-${cartItem.cartItemId}" value="${lineSubTotal}">
                                        </td>
                                        <td>
                                            <a href="cartdetails?service=delete&cartItemId=${cartItem.cartItemId}" style="font-size: 25px;color: red">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>

                                </c:forEach>
                            </c:if>

                            <c:if test="${empty cartItemBookMap}">
                                <tr>
                                    <td colspan="2"></td>
                                    <td colspan="3">
                                        <h4 class="text-danger">Giỏ hàng hiện tại của bạn đang trống</h4>
                                    </td>
                                </tr>
                            </c:if>

                            <tr class="bottom_button">
                                <td colspan="3"> 
                                    <a class="button" href="cartdetails?service=reloadCart&action=reload"">Cập Nhật Giỏ Hàng</a>
                                </td>
                                <td colspan="2">
                                    <h5 class="text-danger">${errorMessage}</h5>
                                </td>
                                <!--                              <td>
                                                                  <div class="cupon_text d-flex align-items-center">
                                                                      <input type="text" placeholder="Coupon Code">
                                                                      <a class="primary-btn" href="#">Apply</a>
                                                                      <p style="padding-top: 15px;padding-left: 30px">Mã Giảm Thêm : 20%</p>
                                                                  </div>
                                                              </td>-->
                            </tr>

                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <h5>Tổng Giá Trị Giỏ Hàng</h5>
                                </td>
                                <td>
                                    <!--<h5 id="total-all">${subTotal} đ</h5>-->
                                    <h5 id="total-all">
                                        <c:if test="${not empty cartItemBookMap}">
                                            <fmt:formatNumber value="${subTotal}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                        </c:if>
                                    </h5>
                                </td>
                            </tr>

                            <tr class="out_button_area">
                                <td colspan="3"></td>
                                <td colspan="2">
                                    <div class="checkout_btn_inner d-flex align-items-center" style="float: right">
                                        <a class="gray_btn" href="products">Tiếp Tục Mua Sắm</a>
                                        <c:if test="${not empty cartItemBookMap}">
                                            <a class="primary-btn ml-2" href="cartdetails?service=reloadCart&action=checkOut">Mua Hàng</a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>

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

            function updateQuantity(cartItemId, bookPrice, discount, stock, action) {
                // Lấy ra giá trị hiện tại của quantity
                var quantity = parseInt(document.getElementById('qty-' + cartItemId).value);

                // Nếu hành động là tăng quantity
                if (action === 'increase') {
                    if (quantity < stock) {
                        quantity++;
                    } else {
                        quantity = stock;
                        alert("Không thể vượt quá số lượng trong kho là : " + stock);
                    }
                }

                // Nếu hành động là giảm quantity và quantity hiện tại lớn hơn 1
                if (action === 'decrease') {
                    quantity--;
                    if (quantity < 1) {
                        alert("Số lượng không thể nhỏ hơn 1");
                        quantity = 1;
                    }
                }
                // Cập nhật giá trị mới của quantity trên giao diện
                document.getElementById('qty-' + cartItemId).value = quantity;
                // Update the total price based on the new quantity
                var totalPrice = (bookPrice * quantity * (100 - discount) / 100);
                // Cập nhật giá trị tổng giá trị cho sản phẩm
                document.getElementById('total-price-' + cartItemId).innerText = formatNumber(totalPrice, 3, 3) + " đ";

                document.querySelector('input[name="lineSubTotal-' + cartItemId + '"]').value = totalPrice;

                updateSubtotal();

                // Gửi yêu cầu cập nhật quantity lên server bằng AJAX
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        // Xử lý phản hồi từ server nếu cần
                        console.log("Quantity updated successfully.");
                    }
                };
                xhr.open("POST", "cartdetails?service=updateQuantity&cartItemId=" + cartItemId + "&quantity=" + quantity, true);
                xhr.send();
            }

            function updateTotalPrice(cartItemId, bookPrice, discount, stock) {
                var quantity = document.getElementById('qty-' + cartItemId).value.trim();
                if (quantity === "") {
                    quantity = 1;
                    alert("Không được để trống.");
                } else {
                    if (!/^\d+$/.test(quantity)) {
                        quantity = 1;
                        alert("Vui lòng nhập ký tự số hợp lệ.");
                    } else {
                        // Parse quantity to integer
                        quantity = parseInt(quantity);

                        // Validate quantity
                        if (quantity < 1) {
                            quantity = 1; // Set quantity to 1 if it's less than 1
                            alert("Số lượng không thể nhỏ hơn 1.");
                        }
                        if (quantity > stock) {
                            quantity = stock; // Set quantity to stock if it's more than stock
                            alert("Không thể vượt quá số lượng trong kho là : " + stock);
                        }
                    }
                }
                // Update the input value to display the corrected quantity
                document.getElementById('qty-' + cartItemId).value = quantity;

                // Update the total price based on the new quantity
                var totalPrice = (bookPrice * quantity * (100 - discount) / 100);
                document.getElementById('total-price-' + cartItemId).innerText = formatNumber(totalPrice, 3, 3) + " đ";

                document.querySelector('input[name="lineSubTotal-' + cartItemId + '"]').value = totalPrice;

                updateSubtotal();

                // Send AJAX request to update quantity on the server
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        // Handle response from the server if needed
                        console.log("Quantity updated successfully.");
                    }
                };
                xhr.open("POST", "cartdetails?service=updateQuantity&cartItemId=" + cartItemId + "&quantity=" + quantity, true);
                xhr.send();
            }

            function updateSubtotal() {
                var totalAll = 0;
                var totalPriceElements = document.querySelectorAll('[name^="lineSubTotal-"]');

                totalPriceElements.forEach(function (element) {
                    var priceText = element.value; // Sử dụng giá trị của phần tử ẩn
                    console.log('Price text:', priceText); // Debugging line

                    var price = parseFloat(priceText);
                    console.log('Price:', price); // Debugging line

                    if (!isNaN(price)) {
                        totalAll += price;
                    }
                });

                console.log('Total All:', totalAll); // Debugging line
                document.getElementById('total-all').innerText = formatNumber(totalAll, 3, 3) + " đ";
            }

            function formatNumber(value, minFractionDigits, maxFractionDigits) {
                // Chuyển đổi giá trị thành chuỗi số và làm tròn số
                var numString = (parseFloat(value)).toFixed(Math.max(minFractionDigits, maxFractionDigits)).toString();

                // Đảo ngược chuỗi để dễ dàng thêm dấu phẩy
                numString = numString.split('').reverse().join('');

                // Thêm dấu phẩy sau mỗi 3 chữ số
                var formatted = numString.match(/\d{1,3}/g).join(',').split('').reverse().join('');

                return formatted;
            }


//            function formatNumber(value, minFractionDigits, maxFractionDigits) {
//                return parseFloat(value).toFixed(Math.max(minFractionDigits, maxFractionDigits))
//                        .replace(/\d(?=(\d{3})+\.)/g, '$&,')
//                        .replace('.', ',');
//            }
            //function formatCurrency(amount) {
            //    // Làm tròn số và chuyển đổi thành chuỗi
            //    var formattedAmount = Math.round(amount * 1000); // Làm tròn số
            //
            //    // Sử dụng toFixed(2) để làm tròn số đến 2 chữ số thập phân và chuyển đổi thành chuỗi
            //    var stringFormattedAmount = formattedAmount.toFixed(2);
            //
            //    // Sử dụng regex để thêm dấu phân cách hàng nghìn và đơn vị tiền tệ " đ"
            //    stringFormattedAmount = stringFormattedAmount + " đ";
            //
            //    return stringFormattedAmount;
            //}



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
