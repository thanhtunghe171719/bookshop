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
        <title>Aroma Shop - Product Details</title>
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
        <!--================Single Product Area =================-->
        <div class="product_image_area">
            <c:set var="book" value="${book}"/>
            <div class="container">
                <div class="row s_product_inner">
                    <div class="col-lg-6">
                        <div class="owl-carousel owl-theme s_Product_carousel">
                            <div class="single-prd-item">
                                <img class="img-fluid" src="${book.getImage()}" alt="${book.getTitle()}">
                            </div>
                            <!-- <div class="single-prd-item">
                                    <img class="img-fluid" src="img/category/s-p1.jpg" alt="">
                            </div>
                            <div class="single-prd-item">
                                    <img class="img-fluid" src="img/category/s-p1.jpg" alt="">
                            </div> -->
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
                                <button onclick="var result = document.getElementById('sst');
                                        var sst = result.value;
                                        if (!isNaN(sst))
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
            <c:set var="book" value="${book}"/>
            <div class="container">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Description</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Specification</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">Reviews</a>
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

        <!--================ Start related Product area =================-->  
        <!--        <section class="related-product-area section-margin--small mt-0">
                    <div class="container">
                        <div class="section-intro pb-60px">
                            <p>Popular Item in the market</p>
                            <h2>Top <span class="section-intro__style">Product</span></h2>
                        </div>
                        <div class="row mt-30">
                            <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
                                <div class="single-search-product-wrapper">
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-1.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-2.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-3.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
        
                            <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
                                <div class="single-search-product-wrapper">
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-4.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-5.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-6.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
        
                            <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
                                <div class="single-search-product-wrapper">
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-7.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-8.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-9.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
        
                            <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
                                <div class="single-search-product-wrapper">
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-1.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-2.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                    <div class="single-search-product d-flex">
                                        <a href="#"><img src="img/product/product-sm-3.png" alt=""></a>
                                        <div class="desc">
                                            <a href="#" class="title">Gray Coffee Cup</a>
                                            <div class="price">$170.00</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>-->
        <!--================ end related Product area =================-->  	
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