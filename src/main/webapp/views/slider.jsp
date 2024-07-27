<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Slider Details</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>
        <!--================ End Header Menu Area =================-->



        <!--================Blog Area =================-->
        <section class="blog_area single-post-area py-80px section-margin--small">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 posts-list">
                        <div class="single-post row">
                            <c:if test="${not empty detailSlider}">
                                <c:forEach var="slider" items="${detailSlider}">
                                    <div class="col-lg-12">
                                        <div class="feature-img">
                                            <img class="img-fluid" src="${slider.image}" alt="">
                                        </div>
                                    </div>
                                    <div class="col-lg-9 col-md-9 blog_details">
                                        <h2>${slider.title}</h2>
                                        <p class="excert">${slider.description}</p>
                                    </div>
                                </c:forEach>    
                            </c:if>  
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog_right_sidebar">
                            <aside class="single_sidebar_widget search_widget">
                                <form action="slider" method="POST">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="title" placeholder="Search Title Posts">
                                        <input type="hidden" name="service" value="search">
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="submit">
                                                <i class="lnr lnr-magnifier"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <!-- /input-group -->
                                </form>
                                <!-- /input-group -->
                                <div class="br"></div>
                            </aside>
                            
                            <c:if test="${not empty title}">
                                <h4>Kết Quả Tìm Kiếm : '${title}'</h4>
                                <br>
                            </c:if>
                            
                            <aside class="single_sidebar_widget popular_post_widget">
                                <h3 class="widget_title">List Slider</h3>
                                <c:if test="${not empty listSlider}">
                                    <c:forEach var="slider" items="${listSlider}">
                                        <div class="media post_item">
                                            <img src="${slider.image}" alt="" style="width: 90px;">
                                            <div class="media-body">
                                                <a href="slider?service=backlink&id=${slider.sliderId}">
                                                    <h3>${slider.title}</h3>
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <div class="br"></div>
                            </aside>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================Blog Area =================-->

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