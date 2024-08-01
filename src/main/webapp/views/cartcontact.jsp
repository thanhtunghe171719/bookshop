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

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


        <link rel="stylesheet" href="css/style.css">
        <style>
            /* Modal container */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                padding-top: 60px;
            }

            /* Modal content */
            .modal-content {
                background-color: #fefefe;
                margin: 13%;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 700px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
                border-radius: 5px;
            }

            /* Close button */
            .close1,
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close1:hover,
            .close1:focus,
            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            /* Modal header */
            .modal-content h2 {
                margin: 0;
                font-size: 24px;
            }

            /* Address rows */
            .address-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .address-input {
                flex: 1;
                margin-right: 10px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                background-color: #f9f9f9;
            }

            .address-row .btn {
                margin-left: 5px;
            }

            /* Add New Address button */
            #addNewAddressBtn {
                background-color: #5bc0de;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 4px;
            }

            #addNewAddressBtn:hover {
                background-color: #31b0d5;
            }

            /* Save button */
            #saveAddressBtn {
                background-color: #5cb85c;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 4px;
                margin-top: 20px;
            }

            #saveAddressBtn:hover {
                background-color: #4cae4c;
            }

            /* Edit and delete buttons */
            .btn-primary {
                background-color: #0275d8;
                color: white;
                border: none;
                padding: 8px 12px;
                font-size: 14px;
                cursor: pointer;
                border-radius: 4px;
            }

            .btn-primary:hover {
                background-color: #025aa5;
            }

            .btn-danger {
                background-color: #d9534f;
                color: white;
                border: none;
                padding: 8px 12px;
                font-size: 14px;
                cursor: pointer;
                border-radius: 4px;
            }

            .btn-danger:hover {
                background-color: #c9302c;
            }
            /* Ẩn backdrop */
            .modal-backdrop {
                display: none;
            }


        </style>   
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>
        <!--================ End Header Menu Area =================-->


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
                        <div class="col-lg-7">
                            <h3>Chi Tiết Liên Hệ</h3>
                            <!--<form class="row contact_form" action="cart" method="post" novalidate="novalidate">-->
                            <div class="col-md-12 form-group p_star">
                                <p>Họ và Tên:</p>
                                <input type="text" class="form-control" id="first" name="name" placeholder="Full Name" value="${user.fullname}" style="color: black;width: 549px" readonly>
                            </div>

                            <div class="col-md-12 form-group">
                                <p>Địa Chỉ:</p>
                                <div class="col-md-12 row">
                                    <span class="form-control" id="address" style="color: black;width: 500px;background-color: #e9ecef;">${user.address}</span>
                                    <button type="button" class="btn btn-primary" id="editAddressBtn" onclick="editAddress()">Sửa</button>
                                </div>
                            </div>           
                            <!-- pop up edit address -->
                            <div id="addressModal" class="modal">
                                <div class="modal-content">
                                    <span class="close">&times;</span>
                                    <h3 style="font-size: 28px">Sửa Địa Chỉ</h3>
                                    <div style="display:flex; justify-content: space-between; align-items: center;padding-bottom: 20px">
                                        <input type="text" class="address-input" id="add-address" name="address">
                                        <button class="btn btn-info" id="addNewAddressBtn" onclick="addNewAddress()">Thêm Địa Chỉ Mới</button>
                                    </div>

                                    <!-- List of address options -->
                                    <div id="phoneOptions">
                                        <h3 >Địa Chỉ Mặc Định:</h3>
                                        <div class="address-row">
                                            <input type="text" class="address-input" id="address-0" value="${user.address}" readonly>
                                            <div style="display: flex; align-items: center;">
                                                <button class="btn btn-success" onclick="saveAddress(0)">Chọn</button>
                                            </div>
                                        </div>
                                        <h3>Danh Sách Địa Chỉ:</h3>        
                                        <c:forEach var="shipInfo" items="${listShipInfor}">
                                            <c:if test="${not empty shipInfo.address}">
                                                <div class="address-row">
                                                    <input type="text" class="address-input" id="address-${shipInfo.shippingId}" value="${shipInfo.address}" readonly>
                                                    <button class="btn" id="updateBtn-${shipInfo.shippingId}" onclick="updateAddress(${shipInfo.shippingId})" style="display: none">Cập Nhật</button>
                                                    <div style="display: flex; align-items: center;">
                                                        <button class="btn btn-success" onclick="saveAddress(${shipInfo.shippingId})">Chọn</button>
                                                        <button class="btn btn-primary edit-btn" onclick="editAddressInput(${shipInfo.shippingId})"><i class="bi bi-pencil"></i></button>
                                                        <button class="btn btn-danger delete-btn" onclick="deleteItem(${shipInfo.shippingId})"><i class="bi bi-trash"></i></button>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 form-group">
                                <p>Số Điện Thoại:</p>
                                <div class="col-md-12 row">
                                    <span class="form-control" id="phone" style="color: black;width: 500px;background-color: #e9ecef;">${user.phone}</span>
                                    <button type="button" class="btn btn-primary" id="editAddressBtn" onclick="editAddress1()">Sửa</button>
                                </div>
                            </div> 

                            <div id="addressModal1" class="modal">
                                <div class="modal-content">
                                    <span class="close1">&times;</span>
                                    <h3 style="font-size: 28px">Sửa Số Điện Thoại</h3>
                                    <div style="display:flex; justify-content: space-between; align-items: center;padding-bottom: 20px">
                                        <input type="text" class="address-input" id="add-phone" name="address">
                                        <button class="btn btn-info" id="addNewAddressBtn" onclick="addNewAddress1()">Thêm Số Điện Thoại Mới</button>
                                    </div>

                                    <!-- List of address options -->
                                    <div id="addressOptions">
                                        <h3 >Số Điện Thoại Mặc Định:</h3>
                                        <div class="address-row">
                                            <input type="text" class="address-input" id="phone-0" value="${user.phone}" readonly>
                                            <div style="display: flex; align-items: center;">
                                                <button class="btn btn-success" onclick="saveAddress1(0)">Chọn</button>
                                            </div>
                                        </div>
                                        <h3>Danh Sách Số Điện Thoại:</h3>        
                                        <c:forEach var="shipInfo" items="${listShipInfor}">
                                            <c:if test="${not empty shipInfo.phone}">
                                                <div class="address-row">
                                                    <input type="text" class="address-input" id="phone-${shipInfo.shippingId}" value="${shipInfo.phone}" readonly>
                                                    <button class="btn" id="updateBtn1-${shipInfo.shippingId}" onclick="updateAddress1(${shipInfo.shippingId})" style="display: none">Cập Nhật</button>
                                                    <div style="display: flex; align-items: center;">
                                                        <button class="btn btn-success" onclick="saveAddress1(${shipInfo.shippingId})">Chọn</button>
                                                        <button class="btn btn-primary edit-btn" onclick="editAddressInput1(${shipInfo.shippingId})"><i class="bi bi-pencil"></i></button>
                                                        <button class="btn btn-danger delete-btn" onclick="deleteItem1(${shipInfo.shippingId})"><i class="bi bi-trash"></i></button>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>  
<!--
                            <div class="col-md-12 form-group mb-0">
                                <div class="creat_account">
                                    <h3>Lưu ý cho bên giao hàng</h3>
                                </div>
                                <textarea class="form-control" name="message" id="message" rows="1" placeholder="message"></textarea>
                            </div>
                            </form>-->

                        </div>
                        <div class="col-lg-5">
                            <div class="order_box">
                                <form action="payment" method="post">
                                    <div style="display: flex">
                                        <h2 style="flex: 1;border: none">Đơn hàng của bạn</h2>
                                        <a href="cartdetails"><i class="ti-shopping-cart" style="font-size: 20px;"></i></a>
                                    </div>

                                    <table class="table">
                                        <tr>
                                            <td colspan="2">Sản Phẩm</td>
                                            <td >số lượng</td>
                                            <td style="float: right">Thành Giá</td>
                                        </tr>
                                        <c:if test="${not empty cartItemBookMap}">
                                            <c:forEach var="entry" items="${cartItemBookMap.entrySet()}">
                                                <c:set var="cartItem" value="${entry.key}" />
                                                <c:set var="book" value="${entry.value}" />
                                                <c:set var="lineSubTotal" value="${(book.price * cartItem.quantity * (100 - book.discount) / 100)}" />
                                                <c:set var="subTotal" value="${subTotal + lineSubTotal}" />

                                                <tr>
                                                    <td colspan="2"><p style="width: 160px;">${book.title}</p></td>
                                                    <td>x${cartItem.quantity}</td>
                                                    <td style="float: right">
                                                        <fmt:formatNumber value="${lineSubTotal}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                    </td>
                                                </tr>

                                            </c:forEach>    
                                        </c:if>        


                                        <tr  style="border-bottom: 1px #dee2e6 solid;">
                                            <td colspan="3">Tổng Tiền Đơn Hàng</td>
                                            <td style="float: right">
                                                <fmt:formatNumber value="${subTotal}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                            </td>
                                        </tr>
                                    </table>
                                    <br>
                                    
                                    <!-- Hidden input for address -->
                                    <input type="hidden" id="hiddenAddressInput" name="address" value="${user.address}" />
                                    <input type="hidden" id="hiddenPhoneInput" name="phone" value="${user.phone}" />

                                    <h3>Chọn Phương Thức Thanh Toán</h3>
                                    <div class="payment_item active">
                                        <input type="radio" id="f-option5" name="paymentMethod" value="International card">
                                        <label for="f-option5">Thanh toán bằng thẻ quốc tế</label>
                                        <div class="check"></div>
                                        <p>Sử dụng thẻ quốc tế</p>

                                        <input type="radio" id="f-option6" name="paymentMethod" value="Pay with Banking App">
                                        <label for="f-option6">Thanh toán bằng thẻ/tài khoản</label>
                                        <div class="check"></div>
                                        <p>Sử dụng thẻ/tài khoản nội địa</p>

                                    </div>

                                    <input type="hidden" name="subTotal" value="${subTotal}" />

                                    <div class="text-center">
                                        <input type="submit" class="button button-paypal" value="Tiếp tục">
                                        <p id="submitError" style="color: red"></p>
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

        <script src="js/cart.js"></script>

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
