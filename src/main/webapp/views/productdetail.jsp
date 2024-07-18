<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    </head>
    <body>
        
        <jsp:include page="header.jsp"/>
        <c:set var="book" value="${book}"/>
        <c:set var="c" value="${category}"/>

        <!--================Single Product Area =================-->
        <div class="product_image_area">
            <div class="container">
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
                            <h2>
                                <c:choose>
                                    <c:when test="${originalPrice eq discountedPrice}">
                                        <p class="card-productdetail__price">
                                            <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="card-productdetail__price">
                                            <fmt:formatNumber value="${discountedPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </h2>
                            <ul class="list">
                                <li><a href="#"><span>Kho: </span>${book.getStock()}</a></li>
                            </ul>
                            <div class="product_count">
                                <label for="qty">Số lượng:</label>
                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if (!isNaN(sst))
                          result.value++;
                      return false;"
                                        class="increase items-count" type="button"><i class="ti-angle-left"></i></button>
                                <input type="text" name="qty" id="sst" size="2" maxlength="12" value="1" title="Quantity:" class="input-text qty">
                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if (!isNaN(sst) & amp; & amp; sst > 0) result.value--; return false;"
                                        class="reduced items-count" type="button"><i class="ti-angle-right"></i></button>
                                                                                 <!--<a class="button primary-btn" href="cartdetails?service=addCart&bookId=${book.getBook_id()}">Add to Cart</a>--> 
                                <c:set var="userId" value="${user.userId}"></c:set>
                                <a class="button primary-btn" id="addToCartBtn" onclick="addToCart('${userId}',${book.getBook_id()})">Thêm vào giỏ hàng</a>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--================End Single Product Area =================-->

        <!--================Product Description Area =================-->
        <section class="product_description_area">
            <div class="container">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Mô tả</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
                           aria-selected="false">Chi tiết sản phẩm</a>
                    </li>
                    <!--				<li class="nav-item">
                                                            <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
                                                             aria-selected="false">Comments</a>
                                                    </li>
                                                    <li class="nav-item">
                                                            <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
                                                             aria-selected="false">Reviews</a>
                                                    </li>-->
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
                                        <td>
                                            <h5>Mã hàng</h5>
                                        </td>
                                        <td>
                                            <h5>${book.getBook_id()}</h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h5>Nhà xuất bản</h5>
                                        </td>
                                        <td>
                                            <h5>${book.getPublishing_house()}</h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h5>Tác giả</h5>
                                        </td>
                                        <td>
                                            <h5>${book.getAuthor()}</h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h5>Năm Xuất Bản</h5>
                                        </td>
                                        <td>
                                            <h5>${book.getPublished_year()}</h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h5>Trọng lượng(gr)</h5>
                                        </td>
                                        <td>
                                            <h5>${book.getWeight()}</h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h5>Kích Thước(cm)</h5>
                                        </td>
                                        <td>
                                            <h5>${book.getSize()}</h5>
                                        </td>
                                    </tr>
                                    <!--                                    <tr>
                                                                            <td>
                                                                                <h5>Số trang</h5>
                                                                            </td>
                                                                            <td>
                                                                                <h5>Without touch of hand</h5>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <h5>Hình thức</h5>
                                                                            </td>
                                                                            <td>
                                                                                <h5>60pcs</h5>
                                                                            </td>
                                                                        </tr>-->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>


        </section>
        
        <jsp:include page="footer.jsp"/>
        <!--================ end related Product area =================-->  	


        <script>
            // Hàm tăng số lượng
            function increaseQty() {
                var result = document.getElementById('sst');
                var sst = result.value;
                if (!isNaN(sst) && sst < 99) {
                    result.value++;
                }
                return false;
            }

            // Hàm giảm số lượng
            function decreaseQty() {
                var result = document.getElementById('sst');
                var sst = result.value;
                if (isNaN(sst) || sst < 1) {
                    result.value = 1; // Nếu nhập sai hoặc nhỏ hơn 1 thì đặt lại thành 1
                } else if (sst > 99) {
                    result.value = 99; // Nếu nhập lớn hơn 99 thì đặt lại thành 99
                }
            }
        </script>
        <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
        <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="vendors/skrollr.min.js"></script>
        <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
        <script src="vendors/jquery.ajaxchimp.min.js"></script>
        <script src="vendors/mail-script.js"></script>
        <script src="js/main.js"></script>
<script>
            function addToCart(userId, bookId) {
                if (userId === "") {
                    alert("Vui lòng đăng nhập.");
                    window.location.href = 'login';
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