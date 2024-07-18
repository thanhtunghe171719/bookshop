<%-- 
    Document   : cartcompletion
    Created on : Jun 11, 2024, 9:36:17 AM
    Author     : skyfc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Checkout</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">

        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>

        <!--================ End Header Menu Area =================-->

        <!-- ================ start banner area ================= -->	
        <section class="blog-banner-area" id="blog">
            <div class="container h-100">
                <div class="blog-banner">
                    <div class="text-center">
                        <h1>Shop Single</h1>
                        <nav aria-label="breadcrumb" class="banner-breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Shop Single</li>
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
                    <span><i class="fa fa-check"></i></span>
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

        <!--================ Start Cart Completion Area ================-->

        <div class="cart-completion-area">
            <div class="container">
                <div class="d-flex flex-wrap align-items-center justify-content-center mx-2">
                    <div>
                        <img src="https://api.vietqr.io/image/970436-1018334044-BZXjBUb.jpg?accountName=NGUYEN%20DINH%20DUC&amount=${amount}&addInfo=2223" width="340px" height="440px">
                    </div>
                    <div class="checkout-guide d-block ml-5">
                        <h6>Thực hiện theo bước sau để thanh toán:</h6>
                        <div>
                            <span><strong>Bước 1:</strong></span>
                            Mở ứng dụng 
                            <strong>Ngân hàng</strong>
                            để thanh toán
                        </div>
                        <div>
                            <span><strong>Bước 2:</strong></span>
                            Chọn chức năng
                            <strong>Quét mã QR</strong>
                            và quét mã QR tại hướng dẫn này
                        </div>
                        <div>
                            <span><strong>Bước 3:</strong></span>
                            Hoàn thành các bước thanh toán và nhấn vào nút
                            <strong>Đã thanh toán</strong>
                            bên dưới
                        </div>
                        <div>
                            <span><strong>Bước 4:</strong></span>
                            Đợi nhân viên liên hệ lại với bạn
                        </div>
                    </div>
                </div>

                    
                    <div class="form-group text-center text-sm-right mt-3">
                        <a style="color: #FFF" href="thankyou" class="button button--active button-review">Đã thanh toán</a>
                    </div>
            </div>
        </div>

        <!--================ Start footer Area  =================-->	
        <jsp:include page="footer.jsp"/>
        <!--================ End footer Area  =================-->
    </body>
</html>
