<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.Post" %>
<%
    Post post = (Post) request.getAttribute("post");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Post</title>
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
            <h2>Edit Post</h2>
            <form id="form-1" action="managerpost?action=edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="post_id" value="<%= post != null ? post.getPostId() : 0%>">
                <div class="form-group">
                    <label for="title">Tiêu Đề</label>
                    <input class="form-control" type="text" name="title" value="<%= post != null ? post.getTitle() : ""%>" readonly>
                </div>
                <div class="form-group">
                    <label for="description">Nội Dung</label>
                    <textarea class="form-control" name="description" rows="5" readonly><%= post != null ? post.getDescription() : ""%></textarea>
                </div>
                <div class="form-group">
                    <label for="post_type">Thể Loại</label>
                    <select class="form-control" name="post_type" id="post_type" disabled>
                        <option value="review" <%= post != null && "review".equals(post.getPostType()) ? "selected" : ""%>>Review</option>
                        <option value="event" <%= post != null && "event".equals(post.getPostType()) ? "selected" : ""%>>Event</option>
                        <option value="hot_spot" <%= post != null && "hot_spot".equals(post.getPostType()) ? "selected" : ""%>>Hot Spot</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="status">Trạng Thái</label>
                    <select class="form-control" name="status" id="status" disabled>
                        <option value="Show" <%= post != null && "Show".equals(post.getStatus()) ? "selected" : ""%>>Show</option>
                        <option value="Hide" <%= post != null && "Hide".equals(post.getStatus()) ? "selected" : ""%>>Hide</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="image">Ảnh</label>
                    <input type="file" name="image" accept=".png, .jpg, .jpeg" class="form-control-file" readonly>
                    <% if (post != null && post.getImage() != null && !post.getImage().isEmpty()) {%>
                    <img src="<%= post.getImage()%>" alt="Post Image" class="img-thumbnail mt-2">
                    <% }%>
                </div>
                <div class="text-center mt-4">
                    <button onclick="editPost()" id="edit" type="button" class="btn btn-primary">Chỉnh sử</button>
                      </div>
                <div class="text-center mt-2">
                    <h6 id="statusMessage" style="color: green;"></h6>
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                       

                        function editPost() {
                            document.querySelectorAll('input, textarea, select').forEach((el) => {
                                el.removeAttribute('readonly');
                                el.removeAttribute('disabled');
                            });
                            // Change button text and functionality if needed
                            var editButton = document.getElementById('edit');
                            editButton.innerHTML = "Save";
                            editButton.onclick = function (event) {
                                event.preventDefault();
                                savePost();
                            };
                        }

                        function savePost() {
                            var formData = new FormData(document.getElementById('form-1'));
                            $.ajax({
                                url: 'managerpost?action=edit',
                                type: 'POST',
                                data: formData,
                                processData: false,
                                contentType: false,
                                success: function (response) {
                                    if (response.status === 'success') {
                                        document.getElementById('statusMessage').innerText = 'Post updated successfully!';
                                    } else {
                                        document.getElementById('statusMessage').innerText = 'Post updated successfully!';
                                    }
                                }
                            });
                        }
        </script>
    </body>
</html>