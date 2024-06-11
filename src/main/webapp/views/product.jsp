<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Aroma Shop - Category</title>
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
                        <h1>Shop Category</h1>
                        <nav aria-label="breadcrumb" class="banner-breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Shop Category</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- ================ end banner area ================= -->


        <!-- ================ category section start ================= -->		  
        <section class="section-margin--small mb-5">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-lg-4 col-md-5">
                        <div class="sidebar-categories">
                            <div class="head">Browse Categories</div>
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


                        <!--                        <div class="sidebar-filter">
                                                    <div class="top-filter-head">Product Filters</div>
                                                    <div class="common-filter">
                                                        <div class="head">Brands</div>
                                                        <form action="#">
                                                            <ul>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="apple" name="brand"><label for="apple">Apple<span>(29)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="asus" name="brand"><label for="asus">Asus<span>(29)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="gionee" name="brand"><label for="gionee">Gionee<span>(19)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="micromax" name="brand"><label for="micromax">Micromax<span>(19)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="samsung" name="brand"><label for="samsung">Samsung<span>(19)</span></label></li>
                                                            </ul>
                                                        </form>
                                                    </div>
                                                    <div class="common-filter">
                                                        <div class="head">Color</div>
                                                        <form action="#">
                                                            <ul>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="black" name="color"><label for="black">Black<span>(29)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="balckleather" name="color"><label for="balckleather">Black
                                                                        Leather<span>(29)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="blackred" name="color"><label for="blackred">Black
                                                                        with red<span>(19)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="gold" name="color"><label for="gold">Gold<span>(19)</span></label></li>
                                                                <li class="filter-list"><input class="pixel-radio" type="radio" id="spacegrey" name="color"><label for="spacegrey">Spacegrey<span>(19)</span></label></li>
                                                            </ul>
                                                        </form>
                                                    </div>
                                                    <div class="common-filter">
                                                        <div class="head">Price</div>
                                                        <div class="price-range-area">
                                                            <div id="price-range"></div>
                                                            <div class="value-wrapper d-flex">
                                                                <div class="price">Price:</div>
                                                                <span>$</span>
                                                                <div id="lower-value"></div>
                                                                <div class="to">to</div>
                                                                <span>$</span>
                                                                <div id="upper-value"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>-->


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
                                            if(searchText != null && searchText != ""){
                                        %>

                                        value="search?search=${search}&sort=newest"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=newest&grid=${grid}"

                                        <% } %>

                                        <% 
                                            if((request.getAttribute("sort") != null) && request.getAttribute("sort").equals("newest")){ 
                                        %> 
                                        selected 
                                        <% } %>
                                        >Mới nhất</option>

                                    <option  

                                        <%
                                            if(searchText != null && searchText != ""){
                                        %>

                                        value="search?search=${search}&sort=price_asc"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=price_asc&grid=${grid}"

                                        <% } %>

                                        <% 
                                            if((request.getAttribute("sort") != null) && request.getAttribute("sort").equals("price_asc")){ 
                                        %> 
                                        selected 
                                        <% } %>
                                        >Giá tăng dần</option>
                                    <option 

                                        <%
                                            if(searchText != null && searchText != ""){
                                        %>

                                        value="search?search=${search}&sort=price_desc"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=price_desc&grid=${grid}" 

                                        <% } %>

                                        <% 
                                            if((request.getAttribute("sort") != null) && request.getAttribute("sort").equals("price_desc")){ 
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
                                            if(searchText != null && searchText != ""){
                                        %>

                                        value="search?search=${search}&sort=newest"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=${param.sort}&grid=6"

                                        <% } %>

                                        <% 
                                            if((request.getAttribute("grid") != null) && request.getAttribute("grid").equals(6)){ 
                                        %> 
                                        selected 
                                        <% } %>
                                        >6 sản phẩm</option>

                                    <option  

                                        <%
                                            if(searchText != null && searchText != ""){
                                        %>

                                        value="search?search=${search}&sort=price_asc"

                                        <% } else { %>

                                        value="products?categoryid=${param.categoryid}&index=1&sort=${param.sort}&grid=12"

                                        <% } %>

                                        <% 
                                            if((request.getAttribute("grid") != null) && request.getAttribute("grid").equals(12)){ 
                                        %> 
                                        selected 
                                        <% } %>
                                        >12 sản phẩm</option>
                                </select>
                            </div>
                            <div>
                                <form action="search" method="post">
                                    <div class="input-group filter-bar-search">
                                        <input value="${search}" name="search" type="text" placeholder="Search">
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
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card text-center card-product">
                                            <div class="card-product__img">
                                                <img class="card-img" src="${book.getImage()}" alt="${book.getTitle()}">
                                                <ul class="card-product__imgOverlay">
                                                    <li><button><i class="ti-search"></i></button></li>
                                                    <li><button><i class="ti-shopping-cart"></i></button></li>
                                                    <li><button><i class="ti-heart"></i></button></li>
                                                </ul>
                                            </div>

                                            <c:set var="originalPrice" value="${book.getPrice()}" />
                                            <c:set var="discount" value="${book.getDiscount()}" />
                                            <c:set var="discountedPrice" value="${originalPrice - (originalPrice * discount / 100)}" />

                                            <div class="card-body">
                                                <h4 class="card-product__title"><a href="#">${book.getTitle()}</a></h4>

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
                                                        <p class="card-product__pricewithsale">
                                                            <fmt:formatNumber value="${originalPrice}" type="number" minFractionDigits="3" maxFractionDigits="3" /> đ
                                                        </p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
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
                                    
                                                if(searchText != null && searchText != ""){
                                   
                                           %>

                                           href="search?search=${search}&index=${pagetag - 1}&sort=${param.sort}" aria-label="Previous"

                                           <% } else { %>

                                           href="products?categoryid=${param.categoryid}&index=${pagetag - 1}&sort=${param.sort}" aria-label="Previous"

                                           <% } %>

                                           ><span aria-hidden="true">&laquo;</span></a>
                                    </c:if>
                                </li>

                                <%
                                    
                                        if(searchText != null && searchText != ""){
                                   
                                %>
                                <c:forEach begin="1" end="${page}" var="page">
                                    <li class="page-item">
                                        <a class="page-link" href="search?search=${search}&index=${page}&sort=${param.sort}">${page}</a>
                                    </li>
                                </c:forEach>
                                <% } else { %>
                                <c:forEach begin="1" end="${page}" var="page">
                                    <li class="page-item">
                                        <a class="page-link" href="products?categoryid=${param.categoryid}&index=${page}&sort=${param.sort}">${page}</a>
                                    </li>
                                </c:forEach>
                                <% } %>

                                <li class="page-item">
                                    <c:if test="${pagetag < page}">
                                        <a class="page-link" 

                                           <%
                                    
                                                if(searchText != null && searchText != ""){
                                   
                                           %>

                                           href="search?search=${search}&index=${pagetag + 1}&sort=${param.sort}" aria-label="Next"

                                           <% } else { %>

                                           href="products?categoryid=${param.categoryid}&index=${pagetag + 1}&sort=${param.sort}" aria-label="Next"

                                           <% } %>
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

        <!-- ================ top product area start ================= -->	
        <!--        <section class="related-product-area">
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
        <!-- ================ top product area end ================= -->		

        <!-- ================ Subscribe section start ================= -->		  
        <!--        <section class="subscribe-position">
                    <div class="container">
                        <div class="subscribe text-center">
                            <h3 class="subscribe__title">Get Update From Anywhere</h3>
                            <p>Bearing Void gathering light light his eavening unto dont afraid</p>
                            <div id="mc_embed_signup">
                                <form target="_blank" action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01" method="get" class="subscribe-form form-inline mt-5 pt-1">
                                    <div class="form-group ml-sm-auto">
                                        <input class="form-control mb-1" type="email" name="EMAIL" placeholder="Enter your email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Your Email Address '" >
                                        <div class="info"></div>
                                    </div>
                                    <button class="button button-subscribe mr-auto mb-1" type="submit">Subscribe Now</button>
                                    <div style="position: absolute; left: -5000px;">
                                        <input name="b_36c4fd991d266f23781ded980_aefe40901a" tabindex="-1" value="" type="text">
                                    </div>
        
                                </form>
                            </div>
        
                        </div>
                    </div>
                </section>-->
        <!-- ================ Subscribe section end ================= -->		  


        <!--================ Start footer Area  =================-->	
        <jsp:include page="footer.jsp"/>
        <!--================ End footer Area  =================-->



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