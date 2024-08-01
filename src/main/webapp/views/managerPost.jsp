<%@ page import="java.util.List" %>
<%@ page import="models.Post" %>
<%@ page import="dal.DAOBlog" %>
<%@ page import="dal.DBConnect" %>
<%@ page import="java.sql.SQLException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manager Post</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/newcss.css">
        <link rel="stylesheet" href="./vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="./vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container mt-5">
            <h2>Manager Post</h2>

            <form id="search-form" action="managerpost" method="get">
                <div class="row mb-4">
                    <div class="col-md-3">
                        <input type="text" id="titleSearch" name="title" class="form-control" placeholder="Tìm kiếm theo tiêu đề">
                    </div>
                    <div class="col-md-2">
                        <select id="categoryFilter" name="category" class="form-control">
                            <option value="">Phân Loại</option>
                            <option value="review">Review</option>
                            <option value="event">Event</option>
                            <option value="hot_spot">Hot Spot</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select id="statusFilter" name="status" class="form-control">
                            <option value="">Trạng Thái</option>
                            <option value="Show">Show</option>
                            <option value="Hide">Hide</option>
                        </select>
                    </div>



                    <div class="col-md-5 text-right">
                        <a href="${pageContext.request.contextPath}/createrpost" class="btn btn-primary">Tạo bài viết mới</a>
                    </div>
                </div>
            </form>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ảnh</th>
                        <th class="sortable" data-sort="title">Tiêu đề</th>
                        <th class="sortable" data-sort="arthorName">Tác giả</th>
                        <th class="sortable" data-sort="postType">Thể Loại</th>
                        <th class="sortable" data-sort="status">Trạng Thái</th>
                        <th class="sortable" data-sort="createdAt">Ngày Đăng</th>
                        <th class="sortable" data-sort="updatedAt">Ngày Sửa</th>
                        <th>Lựa chọn</th>
                    </tr>
                </thead>
                <tbody id="postList">
                    <% 
                        List<Post> posts = (List<Post>) request.getAttribute("posts");
                        if (posts != null && !posts.isEmpty()) {
                            for (Post post : posts) {
                    %>
                    <tr>
                        <td><%= post.getPostId() %></td>
                        <td><img src="<%= post.getImage() %>" alt="Post Image" class="img-thumbnail" style="width: 50px;"></td>
                        <td><%= post.getTitle() %></td>
                        <td><%= post.getAuthorName()%></td>
                        <td><%= post.getPostType() %></td>
                        <td>
                            <button onclick="toggleStatus(<%= post.getPostId() %>, '<%= post.getStatus() %>')" class="btn btn-secondary btn-sm">
                                <%= post.getStatus().equals("Show") ? "Hide" : "Show" %>
                            </button>
                        </td>
                        <td><%= post.getCreatedAt() %></td>
                        <td><%= post.getUpdateAt() %></td>
                        <td>
                            <a href="managerpost?action=edit&post_id=<%= post.getPostId() %>" class="btn btn-primary">Sửa</a>
                          
                        </td>   
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="9" class="text-center">No posts available</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                $(document).ready(function () {
                                    // Tự động gửi biểu mẫu khi thay đổi categories hoặc status
                                    $('#categoryFilter, #statusFilter, #sortOrder').change(function () {
                                        $('#search-form').submit();
                                    });

                                    // Xử lý việc nhấn Enter trong ô tìm kiếm
                                    $('#titleSearch').on('keypress', function (event) {
                                        if (event.which === 13) {
                                            event.preventDefault();
                                            $('#search-form').submit();
                                        }
                                    });
                                });

                               function toggleStatus(postId) {
                                    if (confirm("Are you sure you want to toggle the status of this post?")) {
                                        $.ajax({
                                            url: 'managerpost',
                                            type: 'GET',
                                            data: {
                                                action: 'toggleStatus',
                                                post_id: postId
                                            },
                                            success: function (response) {
                                                if (response.status === 'success') {
                                                    alert(response.message);
                                                    location.reload();
                                                } else {
                                                    alert('Error toggling post status!');
                                                }
                                            }
                                        });
                                    }
                                }

                                function deletePost(postId) {
                                    if (confirm("Are you sure you want to delete this post?")) {
                                        $.ajax({
                                            url: 'managerpost',
                                            type: 'GET',
                                            data: {
                                                action: 'delete',
                                                post_id: postId
                                            },
                                            success: function (response) {
                                                if (response.status === 'success') {
                                                    alert(response.message);
                                                    location.reload();
                                                } else {
                                                    alert('Error deleting post!');
                                                }
                                            }
                                        });
                                    }
                                }
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>