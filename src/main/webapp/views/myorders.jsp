<%-- 
    Document   : myorders
    Created on : Jul 11, 2024, 10:47:55 AM
    Author     : skyfc
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
        <title>My Orders</title>
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

        <!--================Orders Area =================-->

        <section class="cart_area">
            <div class="container">
                <!-- Start Filter Bar -->
                <div class="filter-bar d-flex flex-wrap align-items-center justify-content-around mt-4 mb-4 pt-3 pb-3">
                    <a href="myorders?index=1" class="nav-item">Tất cả</a>

                    <a href="myorders?index=1&status=Pending" class="nav-item">Đang chờ</a>

                    <a href="myorders?index=1&status=Processing" class="nav-item">Đang xử lý</a>

                    <a href="myorders?index=1&status=Shipped" class="nav-item">Chờ giao hàng</a>

                    <a href="myorders?index=1&status=Delivered" class="nav-item">Hoàn thành</a>

                    <a href="myorders?index=1&status=Canceled" class="nav-item">Đã Huỷ</a>
                </div>
                <!-- End Filter Bar -->
                <div class="cart_inner">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Mã đơn</th>
                                    <th scope="col">Ngày mua</th>
                                    <th scope="col">Sản phẩm</th>                                  
                                    <th scope="col">Tổng tiền</th>
                                    <th scope="col">Trạng thái</th>
                                    <th scope="col">Trống</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="orders" items="${orders}">
                                    <tr>
                                        <td>
                                            <p>${orders.getOrderID()}</p>
                                        </td>
                                        <td>
                                            <p>${orders.getOrderDate()}</p>
                                        </td>
                                        <td>
                                            <!-- Hiển thị từng mục hàng cho đơn hàng -->
                                            <table>
                                                <c:forEach var="item" items="${orders.getOrderItems()}">
                                                    <tr>
                                                        <td style="border-top: none">
                                                            <p>${item.getTitle()}</p>
                                                        </td>
                                                        <td style="border-top: none">
                                                            <p>x${item.getQuantity()}</p>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </td>
                                        <td>
                                            <p>
                                                <fmt:formatNumber value="${orders.getTotal()}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                            </p>
                                        </td>
                                        <td>
                                            <p>${orders.getStatus()}</p>
                                        </td>
                                        <td>
                                            <form action="orderinformation" method="post">
                                                <input type="hidden" id="oid" name="oid" value="${orders.getOrderID()}">
                                                <button type="submit" style="border-style: none; background: none">Chi tiết</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                            <c:if test="${pagetag > 1}">
                                <a class="page-link" href="myorders?index=${pagetag - 1}<c:if test='${param.status != null}'>&status=${param.status}</c:if>" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a>
                            </c:if>
                        </li>

                        <c:forEach begin="1" end="${page}" var="page">
                            <li class="page-item <c:if test='${pagetag == page}'>active</c:if>">
                                <a class="page-link" href="myorders?index=${page}<c:if test='${param.status != null}'>&status=${param.status}</c:if>">${page}</a>
                                </li>
                        </c:forEach>

                        <li class="page-item">
                            <c:if test="${pagetag < page}">
                                <a class="page-link" href="myorders?index=${pagetag + 1}<c:if test='${param.status != null}'>&status=${param.status}</c:if>" aria-label="Next" ><span aria-hidden="true">&raquo;</span></a>
                            </c:if>
                        </li>
                    </ul>
                </nav>
            </div>
        </section>
        <!--================End Orders Area =================-->


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
                    }
                }

                // Nếu hành động là giảm quantity và quantity hiện tại lớn hơn 1
                else if (action === 'decrease' && quantity > 1) {
                    quantity--;
                }

                // Cập nhật giá trị mới của quantity trên giao diện
                document.getElementById('qty-' + cartItemId).value = quantity;
                // Update the total price based on the new quantity
                var totalPrice = (bookPrice * quantity * (100 - discount) / 100);
                // Cập nhật giá trị tổng giá trị cho sản phẩm
                document.getElementById('total-price-' + cartItemId).innerText = formatNumber(totalPrice, 3, 3) + " đ";
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

            function updateTotalPrice(cartItemId, bookPrice, discount, quantity, stock) {
                // Parse quantity to integer
                quantity = parseInt(quantity);
                // Validate quantity
                if (isNaN(quantity) || quantity < 1) {
                    quantity = 1; // Set quantity to 1 if it's NaN or less than 1
                }
                if (quantity > stock) {
                    quantity = stock; // Set quantity to stock if it's more than stock
                }
                // Update the input value to display the corrected quantity
                document.getElementById('qty-' + cartItemId).value = quantity;
                // Update the total price based on the new quantity
                var totalPrice = (bookPrice * quantity * (100 - discount) / 100);
                document.getElementById('total-price-' + cartItemId).innerText = formatNumber(totalPrice, 3, 3) + " đ";
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
                var totalPriceElements = document.querySelectorAll('[id^="total-price-"]');
                totalPriceElements.forEach(function (element) {
                    var priceText = element.innerText.replace(" đ", "").replace(/\./g, '').replace(',', '.');
                    var price = parseFloat(priceText);
                    totalAll += price;
                });
                document.getElementById('total-all').innerText = formatNumber(totalAll, 3, 3) + " đ";
            }

            function formatNumber(value, minFractionDigits, maxFractionDigits) {
                return parseFloat(value).toFixed(Math.max(minFractionDigits, maxFractionDigits))
                        .replace(/\d(?=(\d{3})+\.)/g, '$&,')
                        .replace('.', ',');
            }
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

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Get the current URL parameters
                const params = new URLSearchParams(window.location.search);
                const status = params.get('status');

                // Get all <a> elements within the filter bar
                const links = document.querySelectorAll('.filter-bar .nav-item');

                // Loop through all links and add the class to the selected one
                links.forEach(link => {
                    // Extract the status from the href attribute
                    const href = new URL(link.href);
                    const linkStatus = href.searchParams.get('status');

                    if (status === linkStatus) {
                        link.classList.add('active-category');
                    }
                });
            });
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
