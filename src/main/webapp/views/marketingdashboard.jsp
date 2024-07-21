    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Marketing Dashboard</title>
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
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link
            rel="shortcut icon"
            type="image/x-icon"
            href="assets/images/favicon.png"
            />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <!--[if lt IE 9]>
          <script src="assets/js/html5shiv.min.js"></script>
          <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css" />
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/vendors/calendar/fullcalendar.css"
            />

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css" />

        <!-- SHORTCODES ============================================= -->
        <link
            rel="stylesheet"
            type="text/css"
            href="assets/css/shortcodes/shortcodes.css"
            />

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css" />
        <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css" />
        <link
            class="skin"
            rel="stylesheet"
            type="text/css"
            href="assets/css/color/color-1.css"
            />
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <main class="ttr-wrapper">
            
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Dashboard</h4>           
                </div>	
                <!-- Card -->
                <form action="marketing_dashboard" method="post">
                <c:set var="totalPosts" value="${totalPosts}"/>
                <c:set var="totalBooks" value="${totalBooks}"/>
                <c:set var="totalCustomers" value="${totalCustomers}"/>
                <c:set var="totalSliders" value="${totalSliders}"/>
                <div class="row">
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg1">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                  Total Posts
                                </h4>
                                <span class="wc-des">
                                    All Blog Count
                                </span>
                                <span class="wc-stats">
                                   <span class="counter">
                                      ${totalPosts}
                                   </span>
                                   
                                </span>		      
                                <span class="wc-progress-bx">
                                   
                                </span>
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg2">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Slider
                                </h4>
                                <span class="wc-des">
                                    All Slider Count
                                </span>
                                <span class="wc-stats counter">
                                    ${totalSliders} 
                                </span>		
                                
                                </span>
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg3">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                   Books
                                </h4>
                                <span class="wc-des">
                                    All Books Count 
                                </span>
                                <span class="wc-stats counter">
                                     ${totalBooks} 
                                </span>		
                               
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg4">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Customers 
                                </h4>
                                <span class="wc-des">
                                    All Customer Count
                                </span>
                                <span class="wc-stats counter">
                                    ${totalCustomers}
                                </span>		
                                
                            </div>				      
                        </div>
                    </div>
                </div>
                </form>
                                <div class="row">
                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Customer</h4>
                            </div>
                            <div class="widget-inner">
                                <canvas id="chart3" width="100" height="45"></canvas>
                            </div>
                        </div>
                    </div>
                                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Post</h4>
                            </div>
                            <div class="widget-inner">
                                <canvas id="chart4" width="100" height="45"></canvas>
                            </div>
                        </div>
                    </div>
        </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/vendors/chart/chart.min.js"></script>
        <script src="assets/js/admin.js"></script>
        <script src='assets/vendors/calendar/moment.min.js'></script>
        <script src='assets/vendors/calendar/fullcalendar.js'></script>

    </body>
</html>
