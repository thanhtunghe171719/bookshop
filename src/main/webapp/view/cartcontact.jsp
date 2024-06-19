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

        <!--================ Start Progress Bar ================-->

        <div class="d-flex justify-content-center align-items-center mt-4 mb-4">
            <div class="progresses">
                <div class="steps">
                    <span><i class="fa fa-check"></i></span>
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

        <!--================Checkout Area =================-->
        <section class="checkout_area section-margin--small">
            <div class="container">

                <!-- Hiển thị thông báo lỗi nếu có -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>

                <div class="billing_details">
                    <div class="row">
                        <div class="col-lg-8">
                            <h3>Chi Tiết Liên Hệ</h3>
                            <form class="row contact_form" action="cart" method="post" novalidate="novalidate">
                                <div class="col-md-12 form-group p_star">
                                    <p>Họ và Tên:</p>
                                    <input type="text" class="form-control" id="first" name="name" placeholder="Full Name" value="${user.fullname}" style="color: black" readonly>
                                </div>
                                <div class="col-md-12 form-group">
                                    <p>Địa Chỉ:</p>
                                    <input type="text" class="form-control" id="company" name="address" placeholder="Address" value="${user.address}" style="color: black" readonly>
                                </div>
                                <div class="col-md-12 form-group p_star">
                                    <p>Số Điện Thoại:</p>
                                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone Number" value="${user.phone}" style="color: black" readonly>
                                </div>

                                <div class="col-md-12 form-group mb-0">
                                    <div class="creat_account">
                                        <h3>Lưu ý cho bên giao hàng</h3>
                                    </div>
                                    <textarea class="form-control" name="message" id="message" rows="1" placeholder="message"></textarea>
                                </div>
                            </form>

                        </div>
                        <div class="col-lg-4">
                            <div class="order_box">
                                <form action="cart" method="post">
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
                                                <c:set var="lineSubTotal" value="${book.price * cartItem.quantity}" />
                                                <c:set var="subTotal" value="${subTotal + lineSubTotal}" />

                                                <tr>
                                                    <td>${book.title}</td>
                                                    <td>x${cartItem.quantity}</td>
                                                    <td style="float: right">$${lineSubTotal}</td>
                                                </tr>

                                            </c:forEach>    
                                        </c:if>        


                                        <tr  style="border-bottom: 1px #dee2e6 solid;">
                                            <td colspan="2">Tổng Tiền Đơn Hàng</td>
                                            <td style="float: right">$${subTotal}</td>
                                        </tr>
                                    </table>
                                    <br>
                                    <h3>Chọn Phương Thức Thanh Toán</h3>
                                    <div class="payment_item">
                                        <div class="radion_btn">
                                            <input type="radio" id="f-option5" name="paymentMethod" value="Direct Payment">
                                            <label for="f-option5">Thanh toán khi nhận hàng</label>
                                            <div class="check"></div>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="payment_item active">
                                        <div class="radion_btn">
                                            <input type="radio" id="f-option6" name="paymentMethod" value="Pay with Banking App">
                                            <label for="f-option6">Thanh toán online</label>
                                            <div class="check"></div>
                                        </div>
                                        <p>Sử dụng app ngân hàng</p>
                                    </div>

                                    <input type="hidden" name="subTotal" value="${subTotal}" />

                                    <div class="text-center">
                                        <input type="submit" class="button button-paypal" value="Tiếp tục">
                                    </div>
                                </form>
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