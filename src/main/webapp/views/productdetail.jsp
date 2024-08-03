<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Product Details</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
            .out-of-stock {
                color: red;
                font-weight: bold;
                margin-top: 10px;
            }
            .price-section {
                display: flex;
                align-items: baseline;
                gap: 10px;
            }

            .current-price {
                color: #ff4136;
                font-size: 24px;
                font-weight: bold;
            }

            .old-price {
                color: #888;
                font-size: 18px;
            }

            .discount-percentage {
                background-color: #ff4136;
                color: white;
                padding: 2px 5px;
                border-radius: 3px;
                font-size: 14px;
            }
            .back-to-products {
                margin-bottom: 20px;
            }

            .btn-back {
                display: inline-flex;
                align-items: center;
                padding: 10px 15px;
                background-color: #f8f9fa;
                color: #333;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .btn-back:hover {
                background-color: #e2e6ea;
                color: #333;
            }

            .btn-back i {
                margin-right: 8px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="product_image_area">
            <c:set var="book" value="${book}"/>
            <div class="container">
                <div class="back-to-products">
                    <a href="products" class="btn btn-back">
                        <i class="fa fa-arrow-left"></i> Quay lại danh sách sản phẩm
                    </a>
                </div>
                <div class="row s_product_inner">
                    <div class="col-lg-6">
                        <div class="owl-carousel owl-theme s_Product_carousel">
                            <div class="single-prd-item">
                                <img class="img-fluid" src="${book.getImage()}" alt="${book.getTitle()}">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 offset-lg-1">
                        <c:set var="originalPrice" value="${book.getPrice()}" />
                        <c:set var="discount" value="${book.getDiscount()}" />
                        <c:set var="discountedPrice" value="${originalPrice - (originalPrice * discount / 100)}" />
                        <div class="s_product_text">
                            <h3>${book.getTitle()}</h3>
                            <div class="price-section">
                                <c:choose>
                                    <c:when test="${originalPrice eq discountedPrice}">
                                        <h2 class="current-price">
                                            <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                        </h2>
                                    </c:when>
                                    <c:otherwise>
                                        <h2 class="current-price">
                                            <fmt:formatNumber value="${discountedPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                        </h2>
                                        <span class="old-price">
                                            <del><fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ</del>
                                        </span>
                                        <span class="discount-percentage">
                                            -${book.getDiscount()}%
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <ul class="list">
                                <li><a><span>Còn hàng: </span>${book.getStock()}</a></li>
                            </ul>
                            <div class="product_count">
                                <c:choose>
                                    <c:when test="${book.getStock() > 0}">
                                        <label for="qty">Số lượng:</label>
                                        <input type="text" name="qty" id="sst" size="2" maxlength="12" value="1" title="Quantity:" class="input-text qty" onchange="updateTotalPrice(${book.stock})">
                                        <button class="increase items-count" type="button" onclick="updateQuantity(${book.stock}, 'increase')" style="    left: 125px;
                                                bottom: 15px; width: 20px;"><i class="lnr lnr-chevron-up"></i></button>
                                        <button class="reduced items-count" type="button" onclick="updateQuantity(${book.stock}, 'decrease')"style="    left: 125px;
                                                bottom: 1px; width: 20px;"><i class="lnr lnr-chevron-down"></i></button>
                                            <c:set var="userId" value="${user.userId}"></c:set>

                                            <c:set var="roleId" value="${user.roleId}"></c:set>
                                            
                                        <div class="button primary-btn" id="addToCartBtn" onclick="addToCart('${userId}', '${roleId}', ${book.getBook_id()})" >Thêm vào giỏ hàng</div>
                                            
                                            </c:when>

                                    <c:otherwise>
                                        <p class="out-of-stock">Sản phẩm đã hết hàng</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--================End Single Product Area =================-->

        <!--================Product Description Area =================-->
        <section class="product_description_area">
            <c:set var="book" value="${book}"/>
            <div class="container">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Mô tả</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Thông tin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">Đánh giá</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <p>${book.getSummary()}</p>
                    </div>
                    <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="table-responsive">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td><h5>Mã hàng</h5></td>
                                        <td><h5>${book.getBook_id()}</h5></td>
                                    </tr>
                                    <tr>
                                        <td><h5>Nhà xuất bản</h5></td>
                                        <td><h5>${book.getPublishing_house()}</h5></td>
                                    </tr>
                                    <tr>
                                        <td><h5>Tác giả</h5></td>
                                        <td><h5>${book.getAuthor()}</h5></td>
                                    </tr>
                                    <tr>
                                        <td><h5>Năm Xuất Bản</h5></td>
                                        <td><h5>${book.getPublished_year()}</h5></td>
                                    </tr>
                                    <tr>
                                        <td><h5>Trọng lượng(gr)</h5></td>
                                        <td><h5>${book.getWeight()}</h5></td>
                                    </tr>
                                    <tr>
                                        <td><h5>Kích Thước(cm)</h5></td>
                                        <td><h5>${book.getSize()}</h5></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="review_list">
                                    <c:if test="${not empty feedbacks}">
                                        <c:forEach var="feedback" items="${feedbacks}">
                                            <div class="review_item">
                                                <div class="media">
                                                    <div class="d-flex">
                                                        <img width="50px" style="border-radius: 50%" src="${feedback.user.image}" alt="User Avatar">
                                                    </div>
                                                    <div class="media-body">
                                                        <h4>${feedback.user.fullname}</h4>
                                                        <div class="star-rating">
                                                            <c:forEach begin="1" end="${feedback.rating}">
                                                                <i class="fa fa-star"></i>
                                                            </c:forEach>
                                                        </div>
                                                        <p>${feedback.comment}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty feedbacks}">
                                        <p>No feedback available.</p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        </section>
        <!--================End Product Description Area =================-->

        <jsp:include page="footer.jsp"/>


        <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
        <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="vendors/skrollr.min.js"></script>
        <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
        <script src="vendors/jquery.ajaxchimp.min.js"></script>
        <script src="vendors/mail-script.js"></script>
        <script src="js/main.js"></script>
        <script>
                                            function updateQuantity(stock, action) {
                                                // Lấy ra giá trị hiện tại của quantity
                                                var quantity = parseInt(document.getElementById('sst').value);

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
                                                else if (action === 'decrease' && quantity > 1) {
                                                    quantity--;
                                                } else if (action === 'decrease' && quantity < 1) {
                                                    alert("Số lượng không thể nhỏ hơn 1");
                                                }
                                                document.getElementById('sst').value = quantity;
                                            }
                                            // Hàm tăng số lượng
                                            function updateTotalPrice(stock) {
                                                var quantity = document.getElementById('sst').value.trim();
                                                if (quantity === "") {
                                                    quantity = 1;
                                                    alert("Không được để trống.");
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
                                                    if (isNaN(quantity)) {
                                                        quantity = 1; // Set quantity to 1 if it's NaN
                                                        alert("Vui lòng nhập số hợp lệ.");
                                                    }
                                                }
                                                document.getElementById('sst').value = quantity;
                                            }
                                            function addToCart(userId, roleId, bookId) {
                                                if (userId === "") {
                                                    alert("Vui lòng đăng nhập.");
                                                    window.location.href = 'login';
                                                    return;
                                                }
                                                if (roleId !== "4") {
                                                    alert("Vui lòng đăng nhập tài khoản khách hàng.");
                                                    return;
                                                }
                                                var stock = ${book.getStock()};
                                                if (stock <= 0) {
                                                    alert("Sản phẩm đã hết hàng.");
                                                    return;
                                                }

                                                var quantity = document.getElementById('sst').value;
                                                var xhr = new XMLHttpRequest();
                                                xhr.onreadystatechange = function () {
                                                    if (this.readyState === 4 && this.status === 200) {
                                                        // Handle response from the server if needed
                                                        alert("Thêm sách vào giỏ hàng thành công.");
                                                    }
                                                };
                                                xhr.open("POST", "cartdetails?service=addCart&bookId=" + bookId + '&quantity=' + quantity, true);
                                                xhr.send();
                                            }
        </script>

    </body>
</html>