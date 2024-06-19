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
                                <li class="nav-item"><a class="nav-link" href="single-product.html">Product Details</a></li>
                            </ul>
                        </li>
                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                               aria-expanded="false">Blog</a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="blog.html">Blog</a></li>
                                <li class="nav-item"><a class="nav-link" href="single-blog.html">Blog Details</a></li>
                            </ul>
                        </li>
                        
                        <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
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
                                <li class="nav-item"><a class="nav-link" href="checkout.html">Product Checkout</a></li>
                                <li class="nav-item"><a class="nav-link" href="confirmation.html">Confirmation</a></li>
                                <li class="nav-item"><a class="nav-link" href="cartdetails">Cart Detail</a></li>
                            </ul>
                        </li>
                    </ul>                
                                    
                                    
                    <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
                        <%
                            User user = (User) session.getAttribute("user");
                            if(user==null){
                            
                            
                        %>
                                <!-- Nếu user là null -->
                                <li class="nav-item submenu dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                       aria-expanded="false"><i class="bi bi-person-circle"></i>Account</a>
                                    <ul class="dropdown-menu">
                                        <li class="nav-item"><a class="nav-link" href="login.html">Login</a></li>
                                        <li class="nav-item"><a class="nav-link" href="register.html">Register</a></li>
                                    </ul>
                                </li>
                            <%}else{%>
                            
                                <!-- Nếu user không là null -->
                                <li class="nav-item submenu dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                       aria-expanded="false"><i class="bi bi-person-circle"></i>Hello, ${user.fullname}</a>
                                    <ul class="dropdown-menu">
                                        <li class="nav-item"><a class="nav-link" href="profile.html">User Profile</a></li>
                                        <li class="nav-item"><a class="nav-link" href="changepassword">Change Password</a></li>
                                        <li class="nav-item"><a class="nav-link" href="logout.html">Log Out</a></li>
                                    </ul>
                                </li>
                            <%}%>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>
