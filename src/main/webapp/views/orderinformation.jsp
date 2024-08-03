<%-- 
    Document   : orderinformation
    Created on : Jul 11, 2024, 3:55:19 PM
    Author     : skyfc
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>My Orders</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png" />
        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css" />
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="vendors/linericon/style.css" />
        <link
            rel="stylesheet"
            href="vendors/owl-carousel/owl.theme.default.min.css"
            />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css" />
        <link rel="stylesheet" href="vendors/nice-select/nice-select.css" />
        <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css" />

        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>
        <!--================ End Header Menu Area =================-->

        <!--================Order Details Area =================-->
        <section class="order_details section-margin--small">
            <div class="container" id="blur">
                <div class="row mb-5">
                    <div class="col-md-6 col-xl-6 mb-4 mb-xl-0">
                        <div class="confirmation-card">
                            <h3 class="billing-title">Thông Tin Đơn Hàng</h3>
                            <table class="order-rable">
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>Mã đơn</td>
                                        <td>: ${order.getOrderID()} </td>
                                    </tr>
                                    <tr>
                                        <td>Ngày đặt</td>
                                        <td>: ${order.getOrderDate()}</td>
                                    </tr>
                                    <tr>
                                        <td>Tổng tiền</td>
                                        <td>: <fmt:formatNumber value="${order.getTotal()}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ</td>
                                    </tr>
                                    <tr>
                                        <td>Trạng thái</td>
                                        <td>: ${order.getStatus()}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-6 mb-4 mb-xl-0">
                        <div class="confirmation-card">
                            <h3 class="billing-title">Người Nhận</h3>
                            <table class="order-rable">
                                <tr>
                                    <td>Tên</td>
                                    <td>: ${user.fullname}</td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td>: ${user.email}</td>
                                </tr>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>Số điện thoại</td>
                                        <td>: ${order.getPhone()}</td>
                                    </tr>
                                    <tr>
                                        <td>Địa chỉ</td>
                                        <td>: ${order.getAddress()}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="order_details_table">
                    <h2>Chi tiết đơn hàng</h2>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col">Tổng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="items" items="${items}">
                                    <tr>
                                        <td>
                                            <p>${items.getTitle()}</p>
                                        </td>
                                        <td>
                                            <h5>x ${items.getQuantity()}</h5>
                                        </td>
                                        <td>
                                            <p><fmt:formatNumber value="${(items.getPrice() - (items.getPrice() * items.getDiscount() / 100)) * items.getQuantity()}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ</p>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>
                                            <h4>Tổng tiền</h4>
                                        </td>
                                        <td>
                                            <h5></h5>
                                        </td>
                                        <td>
                                            <h4><fmt:formatNumber value="${order.getTotal()}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ</h4>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row justify-content-around">
                    <c:forEach var="order" items="${orders}">
                        <c:if test="${order.getStatus() == 'Pending'}">
                            <div class="col-lg-4 mt-3">
                                <div class="col-md-12 form-group">
                                    <a href="#" onclick="toggle()" class="button button-login w-100 text-center">Huỷ đơn hàng</a>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <div id="popup">
                <c:forEach var="order" items="${orders}">
                    <c:if test="${order.getStatus() == 'Pending'}">
                        <h2 class="d-flex justify-content-center">Bạn có muốn huỷ đơn hàng ?</h2>
                        <div class="d-flex justify-content-center">
                            <form action="cancel" method="post">
                                <input type="hidden" id="oid" name="oid" value="${order.getOrderID()}">
                                <a href="#" onclick="toggle()" class="btn btn-light">Đóng</a>
                                <button type="submit" class="btn btn-primary">Huỷ</button>
                            </form>
                        </div>
                    </c:if>
                </c:forEach>
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
        <script type="text/javascript">
                                    function toggle() {
                                        var blur = document.getElementById("blur");
                                        blur.classList.toggle("active");
                                        var popup = document.getElementById("popup");
                                        popup.classList.toggle("active");
                                    }
        </script>
    </body>
</html>
