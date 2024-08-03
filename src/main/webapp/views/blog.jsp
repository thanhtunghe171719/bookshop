<%@page import="models.Post"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Blog</title>

        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="./vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="./vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="./vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="./css/style.css">

        <style>
            .form-select {
                background-color: #384aeb;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 2px;
                width: 100px;
                font-size: 16px;
                font-style: normal;
                vertical-align: middle;
                transition: background-color 0.3s ease;
            }
            .form-select:hover,
            .form-select:focus {
                background-color: #0056b3;
                color: white;
            }
            .blog_area {
                margin-top: 50px;
            }
            .blog_post img {
                width: 100%;
                height: auto;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <!--================Blog Area =================-->
        <div class="container mt-5">
            <section class="blog_area">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="d-flex justify-content-start mb-3">
                                <select class="form-select" id="sortDropdown" onchange="sortPosts()">
                                    <option value="default">Sắp xếp theo ngày đăng</option>
                                    <option value="asc">Tăng</option>
                                    <option value="desc">Giảm</option>
                                </select>
                            </div>

                            <div class="blog_left_sidebar">
                                <%
                                    List<Post> posts = (List<Post>) request.getAttribute("posts");
                                    if (posts != null && !posts.isEmpty()) {
                                        for (Post post : posts) {
                                            if (!post.isHidden()) {
                                %>
                                <article class="row blog_item">
                                    <div class="col-md-3">
                                        <div class="blog_info text-right">
                                            <ul class="blog_meta list">
                                                <li>
                                                    <a href="#"><%= post.getAuthorName()%>
                                                        <i class="lnr lnr-user"></i>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#"><%= post.getCreatedAt()%>
                                                        <i class="lnr lnr-calendar-full"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="blog_post">
                                            <img src="<%= post.getImage()%>" alt="<%= post.getTitle()%>">
                                            <div class="blog_details">
                                                <h2 class="post-title" data-postId="<%= post.getPostId()%>"><%= post.getTitle()%></h2>
                                                <p><%= post.getDescription().length() > 150 ? post.getDescription().substring(0, 150) + "..." : post.getDescription()%></p>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                                <%
                                            }
                                        }
                                    } else {
                                %>
                                <p>No posts found.</p>
                                <%
                                    }
                                %>
                                <nav class="blog-pagination justify-content-center d-flex">
                                    <ul class="pagination">
                                        <li class="page-item">
                                            <a href="?page=<%= Math.max(1, (Integer) request.getAttribute("currentPage") - 1)%>&pageSize=<%= request.getAttribute("pageSize")%>&sortOrder=<%= request.getAttribute("sortOrder")%>" class="page-link" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <%
                                            int totalPosts = (Integer) request.getAttribute("totalPosts");
                                            int pageSize = (Integer) request.getAttribute("pageSize");
                                            int currentPage = (Integer) request.getAttribute("currentPage");
                                            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
                                            for (int i = 1; i <= totalPages; i++) {
                                        %>
                                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                                            <a href="?page=<%= i %>&pageSize=<%= pageSize %>&sortOrder=<%= request.getAttribute("sortOrder") %>" class="page-link"><%= i %></a>
                                        </li>
                                        <% } %>
                                        <li class="page-item">
                                            <a href="?page=<%= Math.min(totalPages, currentPage + 1) %>&pageSize=<%= pageSize %>&sortOrder=<%= request.getAttribute("sortOrder") %>" class="page-link" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="blog_right_sidebar">
                                <aside class="single_sidebar_widget search_widget">
                                    <form action="blog" method="get">
                                        <div class="form-group">
                                            <div class="input-group mb-3">
                                                <input type="text" class="form-control" placeholder="Tìm kiếm" name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">

                                            </div>
                                        </div>
                                    </form>
                                </aside>

                                <aside class="single_sidebar_widget post_category_widget">
                                    <h4 class="widget_title">Các thể loại bài đăng</h4>
                                    <ul class="list cat-list">
                                        <%
                                            List<String> categories = (List<String>) request.getAttribute("postCategories");
                                            if (categories != null && !categories.isEmpty()) {
                                                for (String category : categories) {
                                        %>
                                        <li>
                                            <a href="?category=<%= category%>" class="d-flex">
                                                <p><%= category %></p>
                                            </a>
                                        </li>
                                        <%
                                                }
                                            } else {
                                        %>
                                        <li><p>No categories found.</p></li>
                                            <%
                                                }
                                            %>
                                    </ul>
                                </aside>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <script>
            // Lắng nghe sự kiện nhấp chuột vào tiêu đề của bài đăng
            document.querySelectorAll('.post-title').forEach(title => {
                title.addEventListener('click', () => {
                    const postId = title.getAttribute('data-postId');
                    window.location.href = 'postdetail?postId=' + postId;
                });
            });

            function sortPosts() {
                var sortOrder = document.getElementById("sortDropdown").value;
                var currentUrl = window.location.href.split('?')[0];
                var pageSize = '<%= request.getAttribute("pageSize") %>';
                var searchParams = new URLSearchParams(window.location.search);
                searchParams.set('sortOrder', sortOrder);
                searchParams.set('page', '1');
                searchParams.set('pageSize', pageSize);
                window.location.href = currentUrl + '?' + searchParams.toString();
            }
        </script>
        <!--================Blog Area =================-->

        <jsp:include page="footer.jsp"/>

        <!-- Bootstrap JS và các dependencies -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa2t6zI+QLtd0h5PvXja/hFOF" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIyO4FfSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"></script>
    </body>
</html>