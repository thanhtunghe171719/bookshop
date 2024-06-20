<%-- 
    Document   : cartcontact
    Created on : Jun 12, 2024, 3:03:38 PM
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
        <title>Aroma Shop - Checkout</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">

        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  

        <link rel="stylesheet" href="css/style.css">
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
                        <h1>Cart Contact</h1>
                        <nav aria-label="breadcrumb" class="banner-breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Cart Contact</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- ================ end banner area ================= -->


        <!--================Checkout Area =================-->
        <section class="checkout_area section-margin--small">
            <div class="container">


                <div class="billing_details">
                    <div class="row">
                        <div class="col-lg-8">
                            <h3>Chi Tiết Liên Hệ</h3>
                            <form class="row contact_form" action="cartcontact" method="post" novalidate="novalidate">
                                <div class="col-md-12 form-group p_star">
                                    <p>Họ và Tên:</p>
                                    <input type="text" class="form-control" id="first" name="name" placeholder="Họ và Tên" value="${user.fullname}" style="color: black">
                                </div>
                                <div class="col-md-12 form-group">
                                    <p>Địa Chỉ:</p>
                                    <input type="text" class="form-control" id="company" name="address" placeholder="Địa Chỉ" value="${user.address}" style="color: black">
                                </div>
                                <div class="col-md-12 form-group p_star">
                                    <p>Số Điện Thoại:</p>
                                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Số Điện Thoại" value="${user.phone}" style="color: black">
                                </div>

                                <div class="col-md-12 form-group mb-0">
                                    <div class="creat_account">
                                        <h3>Lưu ý cho bên giao hàng</h3>
                                    </div>
                                    <textarea class="form-control" name="message" id="message" rows="1" placeholder="Lời nhắn"></textarea>
                                </div>
                            </form>
                                
                        </div>
                        <div class="col-lg-4">
                            <div class="order_box">
                                <div style="display: flex">
                                    <h2 style="flex: 1;border: none">Đơn hàng của bạn</h2>
                                    <a href="cartdetails"><i class="ti-shopping-cart" style="font-size: 20px;"></i></a>
                                </div>
                                
                                <table class="table">
                                    <tr>
                                        <td>Sản Phẩm</td>
                                        <td></td>
                                        <td style="float: right">Thành Giá</td>
                                    </tr>
                                    <c:if test="${not empty cartItemBookMap}">
                                        <c:forEach var="entry" items="${cartItemBookMap.entrySet()}">
                                            <c:set var="cartItem" value="${entry.key}" />
                                            <c:set var="book" value="${entry.value}" />
                                            <c:set var="lineSubTotal" value="${(book.price * cartItem.quantity * (100 - book.discount) / 100) * 1000}" />
                                            <c:set var="subTotal" value="${subTotal + lineSubTotal}" />
                                            
                                            <tr>
                                                <td>${book.title}</td>
                                                <td>x${cartItem.quantity}</td>
                                                <td style="float: right">${lineSubTotal}</td>
                                            </tr>
                                            
                                        </c:forEach>    
                                    </c:if>        
                                    
                                    
                                    <tr  style="border-bottom: 1px #dee2e6 solid;">
                                        <td colspan="2" style="color: black">Tổng Tiền Đơn Hàng</td>
                                        <td style="float: right;color: black">${subTotal}</td>
                                    </tr>
                                </table>
                                <br>
                                <h3>Chọn Phương Thức Thanh Toán</h3>
                                <div class="payment_item">
                                    <div class="radion_btn">
                                        <input type="radio" id="f-option5" name="selector">
                                        <label for="f-option5">Thanh toán khi nhận hàng</label>
                                        <div class="check"></div>
                                    </div>
                                </div>
                                <br>
                                <div class="payment_item active">
                                    <div class="radion_btn">
                                        <input type="radio" id="f-option6" name="selector">
                                        <label for="f-option6">Thanh toán bằng thẻ</label>
                                        <div><img src="img/product/card.jpg" alt="" style="left: 66px; top: 30px;width: 105px"></div>
                                        <div class="check"></div>
                                    </div>                                    
                                </div>
                                <br>
                                <div class="creat_account">
                                    <input type="checkbox" id="f-option4" name="selector">Tôi đã đọc và xác nhận mọi thông tin đều chính xác
                                </div>
                                <div class="text-center">
<!--                                    <a class="button button-paypal" href="#">Tiếp Tục</a>-->
                                    <button type="button" class="button button-paypal">Tiếp Tục</button>    
                                    <p id="submitError" class="text-danger"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================End Checkout Area =================-->



        <!--================ Start footer Area  =================-->	
        <jsp:include page="footer.jsp"/>
        <!--================ End footer Area  =================-->

<script>
    document.querySelector('.button-paypal').addEventListener('click', function(event) {
        var fullname = document.getElementById('first').value.trim();
        var address = document.getElementById('company').value.trim();
        var phone = document.getElementById('phone').value.trim();
        var checkbox = document.getElementById('f-option4');
        var paymentMethod1 = document.getElementById('f-option5');
        var paymentMethod2 = document.getElementById('f-option6');

        var errorMessages = '';

        if (fullname === '') {
            errorMessages = 'Vui lòng nhập Họ và Tên.';
        } else if (address === '') {
            errorMessages = 'Vui lòng nhập Địa Chỉ.';
        } else if (phone === '') {
            errorMessages = 'Vui lòng nhập Số Điện Thoại.';
        } else if (!paymentMethod1.checked && !paymentMethod2.checked) {
            errorMessages = 'Vui lòng chọn ít nhất một phương thức thanh toán.';
        } else if (!checkbox.checked) {
            errorMessages = 'Vui lòng đánh dấu vào ô "Tôi đã đọc và xác nhận mọi thông tin đều chính xác".';
        }

        if (errorMessages !== '') {
            event.preventDefault(); // Ngăn chặn hành động mặc định của nút "Tiếp Tục"
            document.getElementById('submitError').innerHTML = errorMessages; // Hiển thị thông báo lỗi
        } else {
            document.getElementById('submitError').innerHTML = ''; // Xóa thông báo lỗi nếu không có lỗi
            // Chuyển hướng người dùng về trang "Home"
            window.location.href = 'home';
        }
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