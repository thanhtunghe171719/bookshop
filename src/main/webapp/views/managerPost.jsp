<%@ page import="java.util.List" %>
<%@ page import="models.Post" %>
<%@ page import="dal.DAOBlog" %>
<%@ page import="dal.DBConnect" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manager Post</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/newcss.css">
        <link rel="stylesheet" href="./vendors/bootstrap/bootstrap.min.css">
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
            <div class="text-right mb-4">
                <a href="${pageContext.request.contextPath}/createrpost" class="btn btn-primary">Create New Post</a>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th class="title-column">Title</th>
                        <th>User ID</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Created At</th>
                        <th>Updated At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Post> posts = (List<Post>) request.getAttribute("posts");
                        if (posts != null && !posts.isEmpty()) {
                            for (Post post : posts) {
                    %>
                    <tr>
                        <td><%= post.getPostId() %></td>
                        <td><img src="<%= post.getImage() %>" alt="Post Image" class="img-thumbnail" style="width: 50px;"></td>
                        <td><%= post.getTitle() %></td>
                        <td><%= post.getUserId() %></td>
                        <td><%= post.getPostType() %></td>
                        <td>
                            <button onclick="toggleStatus(<%= post.getPostId() %>, '<%= post.getStatus() %>')" class="btn btn-secondary btn-sm">
                                <%= post.getStatus().equals("Show") ? "Hide" : "Show" %>
                            </button>
                        </td>
                        <td><%= post.getCreatedAt() %></td>
                        <td><%= post.getUpdateAt() %></td>
                        <td>
                            <a href="managerpost?action=edit&post_id=<%= post.getPostId() %>" class="btn btn-primary">Edit</a>
                            <button onclick="deletePost(<%= post.getPostId() %>)" class="btn btn-danger">Delete</button>
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