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
                            <h3>Contact Details</h3>
                            <form class="row contact_form" action="cartcontact" method="post" novalidate="novalidate">
                                <div class="col-md-12 form-group p_star">
                                    <p>Full Name:</p>
                                    <input type="text" class="form-control" id="first" name="name" placeholder="Full Name" value="${user.fullname}" style="color: black">
                                </div>
                                <div class="col-md-12 form-group">
                                    <p>Address:</p>
                                    <input type="text" class="form-control" id="company" name="address" placeholder="Address" value="${user.address}" style="color: black">
                                </div>
                                <div class="col-md-12 form-group p_star">
                                    <p>Phone Number:</p>
                                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone Number" value="${user.phone}" style="color: black">
                                </div>

                                <div class="col-md-12 form-group mb-0">
                                    <div class="creat_account">
                                        <h3>Note to shippers</h3>
                                    </div>
                                    <textarea class="form-control" name="message" id="message" rows="1" placeholder="message"></textarea>
                                </div>
                            </form>
                                
                        </div>
                        <div class="col-lg-4">
                            <div class="order_box">
                                <div style="display: flex">
                                    <h2 style="flex: 1;border: none">Your Order</h2>
                                    <a href="cartdetails"><i class="ti-shopping-cart" style="font-size: 20px;"></i></a>
                                </div>
                                
                                <table class="table">
                                    <tr>
                                        <td>Product</td>
                                        <td></td>
                                        <td style="float: right">Total</td>
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
                                        <td colspan="2">Subtotal</td>
                                        <td style="float: right">$${subTotal}</td>
                                    </tr>
                                </table>
                                <br>
                                <h3>Choose a Payment Method</h3>
                                <div class="payment_item">
                                    <div class="radion_btn">
                                        <input type="radio" id="f-option5" name="selector">
                                        <label for="f-option5">Payment on delivery</label>
                                        <div class="check"></div>
                                    </div>
                                </div>
                                <br>
                                <div class="payment_item active">
                                    <div class="radion_btn">
                                        <input type="radio" id="f-option6" name="selector">
                                        <label for="f-option6">Payment by card </label>
                                        <img src="img/product/card.jpg" alt="" style="width: 105px">
                                        <div class="check"></div>
                                    </div>
                                    <p>Payment via card; you can pay by credit card.</p>
                                </div>
                                <div class="creat_account">
                                    <input type="checkbox" id="f-option4" name="selector">
                                    <label for="f-option4">I have read and confirm all information is correct</label>
                                </div>
                                <div class="text-center">
                                    <a class="button button-paypal" href="#">Proceed to Paypal</a>
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