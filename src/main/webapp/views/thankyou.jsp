<%-- 
    Document   : completepayment
    Created on : Jul 19, 2024, 1:22:09 AM
    Author     : skyfc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Checkout</title>
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
                    <span><i class="fa fa-check"></i></span>
                </div>
                <div class="progress-bar-text ml-2 mr-2">Thanh Toán</div>
            </div>    
        </div>
        <!--================ End Progress Bar ================-->

        <!--================Order Details Area =================-->
        <section class="order_details section-margin--small">
            <div class="container">
                <p class="text-center billing-alert">
                    Đơn hàng của bạn đã được ghi lại. Cảm ơn vì đã đặt hàng
                </p>

                <div class="text-center">
                    <a href="home" class="button button-tracking button-review">Trở về trang chủ</a>
                </div>

            </div>
        </section>
        <!--================End Order Details Area =================-->

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
