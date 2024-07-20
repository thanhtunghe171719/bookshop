<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.*"%>
<header class="header_area">
    <div class="main_menu">
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container">
                <a class="navbar-brand logo_h" href="home"><img src="img/Fevicon.png" alt=""></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                    <ul class="nav navbar-nav menu_nav ml-auto mr-auto">                
                        <li class="nav-item"><a class="nav-link" href="home">Home</a></li>                 
                        <li class="nav-item submenu dropdown">
                            <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="products">Shop Category</a></li>
                            </ul>
                        </li>
                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false">Blog</a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="blog">Blog List</a></li>
                            </ul>
                        </li>
                        <c:if test="${sessionScope.user.roleId != 1 && sessionScope.user.roleId != 2 && sessionScope.user.roleId != 3}">
                            <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>          
                            </c:if>
                            <c:if test="${sessionScope.user.roleId ==1}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Manage</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="#">User</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">Categories</a></li>
                                </ul>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.roleId ==2}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Manage</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="marketing-product">Product</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">Slider</a></li>
                                    <li class="nav-item"><a class="nav-link" href="managerpost">Post</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">Customer</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">Feedback</a></li>
                                </ul>
                            </li> 
                        </c:if>
                        <c:if test="${sessionScope.user.roleId ==3}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Manage</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="#">Order</a></li>
                                </ul>
                            </li>
                        </c:if>
                    </ul> 
                    </ul>

                    <ul class="nav-shop"> 
                        <div>
                            <form action="search" method="post">
                                <div class="input-group filter-bar-search">
                                    <input value="${search}" name="search" type="text" placeholder="Search product">
                                    <div class="input-group-append">
                                        <button type="submit"><i class="ti-search"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </ul>

                    <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
                        <li class="nav-item  submenu dropdown">
                            <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false"><i class="ti-shopping-cart"></i></a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="cartdetails">Cart Detail</a></li>
                            </ul>
                        </li>
                    </ul>                


                    <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
                        <%
                            User user = (User) session.getAttribute("user");
                            if (user == null) {

                        %>
                        <!-- Nếu user là null -->
                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false"><i class="bi bi-person-circle"></i>Account</a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="login">Login</a></li>
                                <li class="nav-item"><a class="nav-link" href="register">Register</a></li>
                            </ul>
                        </li>
                        <%} else {%>

                        <!-- Nếu user không là null -->
                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false"><i class="bi bi-person-circle"></i>  Hello, ${user.fullname}</a>
                               <c:if test="${sessionScope.user.roleId == 1}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="admin_dashboard">Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Log Out</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 2}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="marketing_dashboard">Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Log Out</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 3}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="sale_dashboard">Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Log Out</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 4}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="editprofile">User Profile</a></li>
                                <li class="nav-item"><a class="nav-link" href="changepassword">Change Password</a></li>
                                <li class="nav-item"><a class="nav-link" href="myorders">My Orders</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Log Out</a></li>
                            </ul>
                               </c:if>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>
