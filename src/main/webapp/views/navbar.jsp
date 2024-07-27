<%-- 
    Document   : navbar
    Created on : Jun 10, 2024, 4:18:12 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>    
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

    </head>
    <body>
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                
                <!-- side menu logo end -->
                <!-- sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <c:if test="${sessionScope.user.roleId == 1}">
                    <ul>
                        <li>
                            <a href="admin_dashboard" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashboard</span>
                            </a>
                        </li>
                          
                        <li>
                            <a href="order.jsp" class="ttr-material-button">
                                <span class="ttr-icon"
                                      ><i class="fa fa-shopping-cart"></i
                                    ></span>
                                <span class="ttr-label">User</span>
                            </a>
                        </li> 
                        <li>
                            <a href="neworder.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Setting</span>
                            </a>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    </c:if>
                    <c:if test="${sessionScope.user.roleId == 2}">
                    <ul>
                        <li>
                            <a href="dashboard.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashboard</span>
                            </a>
                        </li>
                          
                        <li>
                            <a href="order.jsp" class="ttr-material-button">
                                <span class="ttr-icon"
                                      ><i class="fa fa-shopping-cart"></i
                                    ></span>
                                <span class="ttr-label">User</span>
                            </a>
                        </li> 
                        <li>
                            <a href="neworder.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Setting</span>
                            </a>
                        </li>
                        
                        <li>
                            <a href="accountList.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-user"></i></span>
                                <span class="ttr-label">Account List</span>
                            </a>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    </c:if>
                    <c:if test="${sessionScope.user.roleId == 3}">
                    <ul>
                        <li>
                            <a href="dashboard.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashboard</span>
                            </a>
                        </li>
                          
                        <li>
                            <a href="order.jsp" class="ttr-material-button">
                                <span class="ttr-icon"
                                      ><i class="fa fa-shopping-cart"></i
                                    ></span>
                                <span class="ttr-label">User</span>
                            </a>
                        </li> 
                        <li>
                            <a href="neworder.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Setting</span>
                            </a>
                        </li>
                        
                        <li>
                            <a href="accountList.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-user"></i></span>
                                <span class="ttr-label">Account List</span>
                            </a>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    </c:if>
                    <!-- sidebar menu end -->
                </nav>
                <!-- sidebar menu end -->
            </div>
        </div>
    </body>
</html>
