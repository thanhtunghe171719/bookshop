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
                        <li class="nav-item"><a class="nav-link" href="home">Trang chủ</a></li>                 
                        <li class="nav-item submenu dropdown">
                            <a href="products" class="nav-link dropdown-toggle"  role="button" aria-haspopup="true"
                               aria-expanded="false">Cửa hàng</a>
                            
                        </li>
                        <li class="nav-item submenu dropdown">
                            <a href="blog" class="nav-link dropdown-toggle"  role="button" aria-haspopup="true"
                               aria-expanded="false">Blog</a>
                        </li>
                        <c:if test="${sessionScope.user.roleId != 1 && sessionScope.user.roleId != 2 && sessionScope.user.roleId != 3 && sessionScope.user.roleId != 5&& sessionScope.user.roleId != 6}">
                            <li class="nav-item"><a class="nav-link" id="contactLink">Liên hệ</a></li>          
                            </c:if>
                            <c:if test="${sessionScope.user.roleId ==1}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Quản lý</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="userList">Người dùng</a></li>
<!--                                    <li class="nav-item"><a class="nav-link" href="settingadmin">Cài đặt</a></li>-->
                                </ul>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.roleId ==2}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Quản lý</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="marketing-product">Sản phẩm</a></li>
                                    <li class="nav-item"><a class="nav-link" href="marketingslider">Slider</a></li>
                                    <li class="nav-item"><a class="nav-link" href="managerpost">Bài đăng</a></li>
                                    <li class="nav-item"><a class="nav-link" href="customers">Khách hàng</a></li>
                                    <li class="nav-item"><a class="nav-link" href="manage-feedback">Đánh giá</a></li>
                                </ul>
                            </li> 
                        </c:if>
                        <c:if test="${sessionScope.user.roleId ==3}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Quản lý</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="manage-order-sale">Đơn hàng</a></li>
                                </ul>
                            </li>
                        </c:if>
                            <c:if test="${sessionScope.user.roleId ==5}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Quản lý</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="manage-sale">Đơn hàng</a></li>
                                </ul>
                            </li>
                        </c:if>
                            <c:if test="${sessionScope.user.roleId ==6}">
                            <li class="nav-item submenu dropdown">
                                <a href="products" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                   aria-expanded="false">Quản lý</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="manage-shipper">Đơn hàng</a></li>
                                </ul>
                            </li>
                        </c:if>
                    </ul> 
                    </ul>

                    <ul class="nav-shop"> 
                        <div>
                            <form action="search" method="post">
                                <div class="input-group filter-bar-search">
                                    <input value="${search}" name="search" type="text" placeholder="Tìm kiếm sản phẩm">
                                    <div class="input-group-append">
                                        <button type="submit"><i class="ti-search"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </ul>
                                    
                    <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
                        <li class="nav-item  submenu dropdown">
                            <a href="cartdetails" class="nav-link dropdown-toggle" role="button" aria-haspopup="true"
                               aria-expanded="false"><i class="ti-shopping-cart"></i></a>
                            
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
                               aria-expanded="false"><i class="bi bi-person-circle"></i>tài khoản</a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="login">đăng nhập</a></li>
                                <li class="nav-item"><a class="nav-link" href="register">đăng ký</a></li>
                            </ul>
                        </li>
                        <%} else {%>

                        <!-- Nếu user không là null -->
                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false"><i class="bi bi-person-circle"></i>  xin chào, ${user.fullname}</a>
                               <c:if test="${sessionScope.user.roleId == 1}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="changepassword">đổi mật khẩu</a></li>
                                <li class="nav-item"><a class="nav-link" href="admin_dashboard">Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 2}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="changepassword">đổi mật khẩu</a></li>
                                <li class="nav-item"><a class="nav-link" href="marketing_dashboard">Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 3}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="changepassword">đổi mật khẩu</a></li>
                                <li class="nav-item"><a class="nav-link" href="sale_dashboard">Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 4}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="editprofile">Hồ sơ</a></li>
                                <li class="nav-item"><a class="nav-link" href="changepassword">đổi mật khẩu</a></li>
                                <li class="nav-item"><a class="nav-link" href="history-order">Lịch sử đặt hàng</a></li>
                                <li class="nav-item"><a class="nav-link" href="myorders">đơn hàng của tôi</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 5}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="changepassword">đổi mật khẩu</a></li>
                                <li class="nav-item"><a class="nav-link" href="sale_dashboard">Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
                            </ul>
                               </c:if>
                               <c:if test="${sessionScope.user.roleId == 6}">
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="changepassword">đổi mật khẩu</a></li>
                                <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
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
