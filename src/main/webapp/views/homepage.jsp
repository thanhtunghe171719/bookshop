
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Shop Book - Home</title>
        <link rel="icon" href="./img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="./vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="./vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="./vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.carousel.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="./css/style.css">
        <style>

            .bi.bi-arrow-left-circle {
                position: absolute;
                left: 105%;  /*Adjust this to move it left or right */
                top: 50%;
                transform: translateX(-50%); /* Centers it horizontally */
                font-size: 50px;
                border: none;
                background: none; /* Ensures no background color */
                cursor: pointer;
            }
            .bi.bi-arrow-right-circle {
                position: absolute;
                right: 66%; /* Adjust this to move it left or right */
                top : 50%;
                transform: translateX(-50%); /* Centers it horizontally */
                font-size: 50px;
                border: none;
                background: none; /* Ensures no background color */
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>
        <!--================ End Header Menu Area =================-->

        <main class="site-main">

            <!--================ Hero banner start =================-->
            <c:if test="${not empty listSlider}">
                <c:forEach var="slider" items="${listSlider}" varStatus="loop">
                    <div class="row" id="slide_${loop.index}" <c:if test="${loop.index != 0}">style="display: none;"</c:if>>
                            <div class="col-1">
                                <button class="bi bi-arrow-left-circle" onclick="prevSlide(${loop.index})"></button>
                        </div>
                        <div class="col-10 d-none d-sm-block">
                            <div class="hero-banner__img" style="text-align: center">
                                <a href="slider?service=backlink&id=${slider.sliderId}"><img class="img-fluid" src="${slider.image}" alt="" style="height:400px;width: 1100px"></a>
                            </div>
                        </div>
                        <div class="col-1">
                            <button class="bi bi-arrow-right-circle" onclick="nextSlide(${loop.index})"></button>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <!--================ Hero banner start =================-->

            <!-- ================ Best Selling item  carousel ================= --> 
            <section class="section-margin calc-60px">
                <div class="container">
                    <div class="section-intro pb-60px">
                        <h2><span class="section-intro__style">Danh Mục Sản Phẩm</span></h2>
                    </div>
                    <div class="owl-carousel owl-theme" id="bestSellerCarousel">
                        <c:if test="${not empty listCategory}">
                            <c:forEach var="category" items="${listCategory}">
                                <div class="card text-center card-product">
                                    <div class="card-product__img">
                                        <img class="img-fluid" src="${category.image}" alt="" style="width: 300px;height: 300px">
                                        <a href="#"><ul class="card-product__imgOverlay"></ul></a>
                                    </div>
                                    <div class="card-body">
                                        <h4 class="card-product__title"><a href="products?categoryid=${category.categoryId}">${category.categoryName}</a></h4>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>                    
                    </div>
                </div>
            </section>
            <!-- ================ Best Selling item  carousel end ================= --> 

            <!-- ================ trending product section start ================= -->  
            <section class="section-margin calc-60px">
                <div class="container">
                    <div class="section-intro pb-60px">
                        <h2><span class="section-intro__style">Sản phẩm Thịnh Hành</span></h2>

                        <div style="float : right;top: -30px;">
                            <select id="optionId" name="selectedOption" value="${selectedOption}" class="form-control" onchange="selectOption()">
                                <option value="discount" ${param.selectedOption == 'discount' ? 'selected' : ''}>Giảm Giá Mạnh</option>
                                <option value="sold" ${param.selectedOption == 'sold' ? 'selected' : ''}>Sản Phẩm Bán Chạy</option>
                                <option value="new-product" ${param.selectedOption == 'new-product' ? 'selected' : ''}>Sản Phẩm Mới</option>
                            </select>
                        </div>

                    </div>

                    <div class="row" id="productList">
                        <c:if test="${not empty listBook}">
                            <c:forEach var="book" items="${listBook}"  varStatus="status">
                                <c:set var="index" value="${status.index}" />
                                <div class="col-md-6 col-lg-4 col-xl-3">
                                    <div class="card text-center card-product">
                                        <div class="card-product__img">
                                            <img class="card-img" src="${book.image}" alt="" style="height: 350px; width: 255px">
                                            <ul class="card-product__imgOverlay" style="display: flex">
                                                <li style="margin-left: 33% ;"><a href="productdetail?pid=${book.bookId}"><button><i class="bi bi-card-list"></i></button></a></li>
                                                <form action="cartdetails" method="get">                             
                                                    <input type="hidden" name="service" value="addCart">
                                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                                    <c:set var="userId" value="${user.userId}"></c:set>
                                                    <c:if test="${user.roleId == 4}">
                                                        <li ><button type="button" onclick="addToCart('${userId}', ${book.bookId})"><i class="ti-shopping-cart"></i></button></li>
                                                    </c:if>
                                                </form>
                                            </ul>
                                        </div>
                                        <div class="card-body">
                                            <h4 class="card-product__title"><a href="productdetail?pid=${book.bookId}">${book.title}</a></h4>
                <!--                            <p class="card-product__price" style="color: red">$${book.price*book.discount/100}</p>-->
                                            <p class="card-product__price" style="color: #008000">Còn hàng: ${book.stock}</p>
                                            <p class="card-product__price">
                                                <fmt:formatNumber value="${book.price*(100-book.discount)/100}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                            </p>
                                            <div class="d-flex justify-content-center">
                                                <!--<p class="card-product__price" style="text-decoration: line-through">$${book.price}</p>-->
                                                <p class="card-product__pricewithsale ml-1 mr-1" style="color: #f25529">
                                                    <fmt:formatNumber value="${book.price}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                </p>
                                                <p class="ml-1 mr-1" style="font-size:12px; color: #f25529">-${book.getDiscount()}%</p>
                                            </div>
                                            <c:if test="${not empty sold}">
                                                <p class="card-product__price" style="color: blue">Đã bán: ${sold[index]}</p>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>


                    </div>
                </div>
            </section>
            <!-- ================ trending product section end ================= -->  

            <!-- ================ Blog section start ================= -->  
            <section class="blog">
                <div class="container">
                    <div class="section-intro pb-60px">
                        <h2><span class="section-intro__style">Bài Viết Mới</span></h2>
                    </div>

                    <div class="row">

                        <c:if test="${not empty listPost}">
                            <c:forEach var="post" items="${listPost}">
                                <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                                    <div class="card card-blog">
                                        <div class="card-blog__img">
                                            <img class="card-img rounded-0" src="${post.image}" alt="" style="height: 230px; width: 350px">
                                        </div>
                                        <div class="card-body">

                                            <h4 class="card-blog__title"><a href="postdetail?postId=${post.postId}">${post.title}</a></h4>
                  <!--                          <p>${post.description}...</p>
                                            <a class="card-blog__link" href="#">Read More <i class="ti-arrow-right"></i></a>-->
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>    

                    </div>
                </div>
            </section>
            <!-- ================ Blog section end ================= -->  


        </main>
        <br>

        <!--================ Start footer Area  =================-->	
        <jsp:include page="footer.jsp"/>
        <!--================ End footer Area  =================-->

        <script>
            var currentSlide = 0;
            var totalSlides = ${listSlider.size()};

            function nextSlide(currentIndex) {
                document.getElementById('slide_' + currentIndex).style.display = 'none';
                currentSlide = (currentIndex + 1) % totalSlides;
                document.getElementById('slide_' + currentSlide).style.display = 'flex';
            }

            function prevSlide(currentIndex) {
                document.getElementById('slide_' + currentIndex).style.display = 'none';
                currentSlide = (currentIndex - 1 + totalSlides) % totalSlides;
                document.getElementById('slide_' + currentSlide).style.display = 'flex';
            }

            setInterval(function () {
                nextSlide(currentSlide);
                var selectedValue = document.getElementById('optionId').value;
                console.log(selectedValue);
            }, 5000);

            function addToCart(userId, bookId) {
                if (userId === "") {
                    alert("Vui lòng đăng nhập.");
                    window.location.href = 'login';
                    return;
                }
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        // Handle response from the server if needed
                        alert("Thêm sách vào giỏ hàng thành công.");
                    }
                };
                xhr.open("POST", "cartdetails?service=addCart&bookId=" + bookId, true);
                xhr.send();
            }

            function selectOption() {
                var selectElement = document.getElementById('optionId');
                var selectedValue = selectElement.value;
                var url = 'home?service=listAll&selectedOption=' + selectedValue;
                window.location.href = url;
            }

            function selectOption1() {
                var selectedValue = document.getElementById('optionId').value;
                //su ajax toi con servlet change
                $.ajax({
                    url: '/BookShop/home?service=listAll&selectedOption=' + selectedValue,
                    type: 'POST'

                });
            }
            function selectOption2() {
                var selectedValue = document.getElementById('optionId').value;
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        // Handle response from the server if needed
                        console.log("Status updated successfully.");
                        // Reload the page to reflect changes
                        window.location.reload();
                    }
                };
                xhr.open("GET", "home?service=listAll&selectedOption=" + selectedValue, true);
                xhr.send();
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
    </body>
</html>
