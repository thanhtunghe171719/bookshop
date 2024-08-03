<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Products</title>
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
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>

        <!--================ End Header Menu Area =================-->


        <!-- ================ category section start ================= -->		  
        <section class="section-margin--small mb-5">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-lg-4 col-md-5">
                        <div class="sidebar-categories">
                            <div class="head">Thể loại</div>
                            <ul class="main-categories">
                                <li class="common-filter">
                                <li class="filter-list">
                                    <a href="products">Tất cả sản phẩm</a>
                                </li>
                                <c:forEach items="${category}" var="category">
                                    <li class="filter-list">
                                        <a class="${tag == category.categoryId ? "active-category" : ""}" href="products?categoryid=${category.categoryId}">${category.getCategoryName()}</a>
                                    </li>
                                </c:forEach>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-8 col-md-7">
                        <%
                            String searchText = (String) request.getAttribute("search");
                        %>
                        <!-- Start Filter Bar -->
                        <div class="filter-bar d-flex flex-wrap align-items-center">
                            <div class="sorting">
                                <select name="sort" id="sort" onchange="location = this.value;" >                                    
                                    <option  

                                        <%
                                            if (searchText != null && searchText != "") {
                                        %>

                                        value="search?search=${search}&sort=newest"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=newest&grid=${grid}"

                                        <% } %>

                                        <%
                                            if ((request.getAttribute("sort") != null) && request.getAttribute("sort").equals("newest")) {
                                        %> 
                                        selected 
                                        <% } %>
                                        >Mới nhất</option>

                                    <option  

                                        <%
                                            if (searchText != null && searchText != "") {
                                        %>

                                        value="search?search=${search}&sort=price_asc"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=price_asc&grid=${grid}"

                                        <% } %>

                                        <%
                                            if ((request.getAttribute("sort") != null) && request.getAttribute("sort").equals("price_asc")) {
                                        %> 
                                        selected 
                                        <% } %>
                                        >Giá tăng dần</option>
                                    <option 

                                        <%
                                            if (searchText != null && searchText != "") {
                                        %>

                                        value="search?search=${search}&sort=price_desc"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=price_desc&grid=${grid}" 

                                        <% } %>

                                        <%
                                            if ((request.getAttribute("sort") != null) && request.getAttribute("sort").equals("price_desc")) {
                                        %> 
                                        selected 
                                        <% } %>
                                        >Giá giảm dần</option>
                                </select>
                            </div>
                            <div class="sorting mr-auto">
                                <select name="grid" id="grid" onchange="location = this.value;">
                                    <option  

                                        <%
                                            if (searchText != null && searchText != "") {
                                        %>

                                        value="search?search=${search}&sort=newest"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=${param.sort}&grid=6"

                                        <% } %>

                                        <%
                                            if ((request.getAttribute("grid") != null) && request.getAttribute("grid").equals("6")) {
                                        %> 
                                        selected 
                                        <% } %>
                                        >6 sản phẩm</option>

                                    <option  

                                        <%
                                            if (searchText != null && searchText != "") {
                                        %>

                                        value="search?search=${search}&sort=price_asc"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=${param.sort}&grid=12"

                                        <% } %>

                                        <%
                                            if ((request.getAttribute("grid") != null) && request.getAttribute("grid").equals("12")) {
                                        %> 
                                        selected 
                                        <% } %>
                                        >12 sản phẩm</option>
                                </select>
                            </div>
                            <div>
                                <form action="search" method="post">
                                    <div class="input-group filter-bar-search">
                                        <input value="${search}" name="search" type="text" placeholder="Tìm kiếm">
                                        <div class="input-group-append">
                                            <button type="submit"><i class="ti-search"></i></button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- End Filter Bar -->
                        <!-- Start Best Seller -->
                        <section class="lattest-product-area pb-40 category-list">
                            <div class="row">
                                <c:forEach items="${book}" var="book">
                                    <c:if test="${book.getStock() > 0}">
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card text-center card-product">
                                                <div class="card-product__img">
                                                    <img class="card-img" src="${book.getImage()}" alt="${book.getTitle()}">
                                                    <ul class="card-product__imgOverlay" style="display: flex">
                                                        <form action="cartdetails" method="get">                             
                                                            <input type="hidden" name="service" value="addCart">
                                                            <input type="hidden" name="bookId" value="${book.getBook_id()}">
                                                            <c:set var="userId" value="${user.userId}"></c:set>
                                                            <c:if test="${user.roleId == 4}">
                                                                <li style="margin-left: 100px"><button type="button" onclick="addToCart('${userId}', ${book.getBook_id()})"><i class="ti-shopping-cart"></i></button></li>
                                                            </c:if>
                                                        </form>    
                                                    </ul>
                                                </div>

                                                <c:set var="originalPrice" value="${book.getPrice()}" />
                                                <c:set var="discount" value="${book.getDiscount()}" />
                                                <c:set var="discountedPrice" value="${originalPrice - (originalPrice * discount / 100)}" />

                                                <div class="card-body">
                                                    <h4 class="card-product__title"><a href="productdetail?pid=${book.getBook_id()}">${book.getTitle()}</a></h4>

                                                    <p class="card-product__price" style="color: #008000">Còn hàng: ${book.getStock()}</p>

                                                    <c:choose>
                                                        <c:when test="${originalPrice eq discountedPrice}">
                                                            <p class="card-product__price">
                                                                <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                            </p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="card-product__price">
                                                                <fmt:formatNumber value="${discountedPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                            </p>
                                                            <div class="d-flex justify-content-center">
                                                                <p class="card-product__pricewithsale ml-1 mr-1" style="color: #f25529">
                                                                    <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                                </p>
                                                                <p class="ml-1 mr-1" style="font-size:12px; color: #f25529">
                                                                    -${book.getDiscount()}%
                                                                </p>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${book.getStock() <= 0}">
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card text-center card-product">
                                                <div class="card-product__img">
                                                    <img class="card-img" src="${book.getImage()}" alt="${book.getTitle()}">
                                                </div>

                                                <c:set var="originalPrice" value="${book.getPrice()}" />
                                                <c:set var="discount" value="${book.getDiscount()}" />
                                                <c:set var="discountedPrice" value="${originalPrice - (originalPrice * discount / 100)}" />

                                                <div class="card-body">
                                                    <h4 class="card-product__title"><a href="productdetail?pid=${book.getBook_id()}">${book.getTitle()}</a></h4>

                                                    <p class="card-product__price" style="color: #008000">Còn hàng: ${book.getStock()}</p>

                                                    <c:choose>
                                                        <c:when test="${originalPrice eq discountedPrice}">
                                                            <p class="card-product__price">
                                                                <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                            </p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="card-product__price">
                                                                <fmt:formatNumber value="${discountedPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                            </p>
                                                            <div class="d-flex justify-content-center">
                                                                <p class="card-product__pricewithsale ml-1 mr-1" style="color: #f25529">
                                                                    <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                                </p>
                                                                <p class="ml-1 mr-1" style="font-size:12px; color: #f25529">
                                                                    -${book.getDiscount()}%
                                                                </p>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </section>
                        <!-- End Best Seller -->

                        <!-- Start Pagination -->
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item">
                                    <c:if test="${pagetag > 1}">
                                        <a class="page-link"
                                           <%

                                               if (searchText != null && searchText != "") {

                                           %>

                                           href="search?search=${search}&index=${pagetag - 1}&sort=${param.sort}" aria-label="Previous"

                                           <% } else { %>

                                           href="products?categoryid=${param.categoryid}&index=${pagetag - 1}&sort=${param.sort}" aria-label="Previous"

                                           <% } %>

                                           ><span aria-hidden="true">&laquo;</span></a>
                                    </c:if>
                                </li>

                                <%

                                    if (searchText != null && searchText != "") {

                                %>
                                <c:forEach begin="1" end="${page}" var="page">
                                    <li class="page-item">
                                        <a class="page-link" href="search?search=${search}&index=${page}&sort=${param.sort}">${page}</a>
                                    </li>
                                </c:forEach>
                                <% } else { %>
                                <c:forEach begin="1" end="${page}" var="page">
                                    <li class="page-item">
                                        <a class="page-link" href="products?categoryid=${param.categoryid}&index=${page}&sort=${param.sort}&grid=${param.grid}">${page}</a>
                                    </li>
                                </c:forEach>
                                <% } %>

                                <li class="page-item">
                                    <c:if test="${pagetag < page}">
                                        <a class="page-link" 

                                           <%

                                               if (searchText != null && searchText != "") {

                                           %>

                                           href="search?search=${search}&index=${pagetag + 1}&sort=${param.sort}" aria-label="Next"

                                           <% } else { %>

                                           href="products?categoryid=${param.categoryid}&index=${pagetag + 1}&sort=${param.sort}" aria-label="Next"

                                           <% }%>
                                           ><span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </c:if>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- ================ category section end ================= -->		  	  

        <!--================ Start footer Area  =================-->	
        <jsp:include page="footer.jsp"/>
        <!--================ End footer Area  =================-->

        <script>
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
                        alert("Thêm sáng vào giỏ hàng thành công.");
                    }
                };
                xhr.open("POST", "cartdetails?service=addCart&bookId=" + bookId, true);
                xhr.send();
            }
        </script>

        <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
        <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="vendors/skrollr.min.js"></script>
        <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
        <script src="vendors/nouislider/nouislider.min.js"></script>
        <script src="vendors/jquery.ajaxchimp.min.js"></script>
        <script src="vendors/mail-script.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>