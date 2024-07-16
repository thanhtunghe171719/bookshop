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
                        <div class="s_product_text">
                            <h3>${book.getTitle()}</h3>
                            <h2>${book.getPrice()}</h2>
                            <ul class="list">
                                <li><a class="active" href="#"><span>Thể loại</span>${book.getCategory_id()}</a></li>
                                <li><a href="#"><span>Kho:</span>${book.getStock()}</a></li>
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
                                <a class="button primary-btn" href="cartdetails?service=addCart&bookId=${book.getBook_id()}">Add to Cart</a>               
                            </div>
                            <div class="card_area d-flex align-items-center">
                                <a class="icon_btn" href="#"><i class="lnr lnr lnr-diamond"></i></a>
                                <a class="icon_btn" href="#"><i class="lnr lnr lnr-heart"></i></a>
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
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
                           aria-selected="false">Specification</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
                           aria-selected="false">Comments</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
                           aria-selected="false">Reviews</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">

                    
                    
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
        </section>
        <!--================End Product Description Area =================-->

        <!--================ Start related Product area =================-->  
        <section class="related-product-area section-margin--small mt-0">
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
        </section>
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
    </body>
</html>