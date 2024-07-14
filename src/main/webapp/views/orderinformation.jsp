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
        <title>Aroma Shop</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png" />
        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css" />
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css" />
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="vendors/linericon/style.css" />
        <link
            rel="stylesheet"
            href="vendors/owl-carousel/owl.theme.default.min.css"
            />
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
            <div class="container">
                <div class="row mb-5">
                    <div class="col-md-6 col-xl-4 mb-4 mb-xl-0">
                        <div class="confirmation-card">
                            <h3 class="billing-title">Order Info</h3>
                            <table class="order-rable">
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>Order number</td>
                                        <td>: ${order.getOrderID()} </td>
                                    </tr>
                                    <tr>
                                        <td>Date</td>
                                        <td>: ${order.getOrderDate()}</td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td>: <fmt:formatNumber value="${order.getTotal()}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ</td>
                                    </tr>
                                    <tr>
                                        <td>Status</td>
                                        <td>: ${order.getStatus()}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-4 mb-4 mb-xl-0">
                        <div class="confirmation-card">
                            <h3 class="billing-title">Receiver</h3>
                            <table class="order-rable">
                                <tr>
                                    <td>Name</td>
                                    <td>: 56/8 panthapath</td>
                                </tr>
                                <tr>
                                    <td>Phone</td>
                                    <td>: Dhaka</td>
                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td>: Bangladesh</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-4 mb-4 mb-xl-0">
                        <div class="confirmation-card">
                            <h3 class="billing-title">Shipping Address</h3>
                            <table class="order-rable">
                                <tr>
                                    <td>Street</td>
                                    <td>: 56/8 panthapath</td>
                                </tr>
                                <tr>
                                    <td>City</td>
                                    <td>: Dhaka</td>
                                </tr>
                                <tr>
                                    <td>Country</td>
                                    <td>: Bangladesh</td>
                                </tr>
                                <tr>
                                    <td>Postcode</td>
                                    <td>: 1205</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="order_details_table">
                    <h2>Order Details</h2>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Product</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total</th>
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
                                            <h4>Total</h4>
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
