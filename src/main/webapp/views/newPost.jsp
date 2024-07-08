<%@ page import="models.Post" %>
<%@ page import="dal.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create New Post</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/newcss.css">
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container mt-5">
            <h2>Create New Post</h2>
            <div id="statusMessage" class="alert alert-info" style="display: none;"></div>
            <form id="createPostForm" action="${pageContext.request.contextPath}/createrpost" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">Title</label>
                    <input class="form-control" type="text" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" name="description" rows="5" required></textarea>
                </div>
                <div class="form-group">
                    <label for="post_type">Type</label>
                    <select class="form-control" name="post_type" required>
                        <option value="review">Review</option>
                        <option value="event">Event</option>
                        <option value="hot_spot">Hot Spot</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="status">Status</label>
                    <select class="form-control" name="status" required>
                        <option value="Show">Show</option>
                        <option value="Hide">Hide</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="image">Image</label>
                    <input type="file" name="image" accept=".png, .jpg, .jpeg" class="form-control-file" required>
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary">Create</button>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#createPostForm').on('submit', function (event) {
                    event.preventDefault();
                    var formData = new FormData(this);
                    $.ajax({
                        url: '${pageContext.request.contextPath}/createrpost',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            if (response.status === 'success') {
                                $('#statusMessage').removeClass('alert-danger').addClass('alert-info').text('Post created successfully with ID: ' + response.postId).show();
                            } else {
                                $('#statusMessage').removeClass('alert-info').addClass('alert-danger').text('Error creating post: ' + response.message).show();
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error creating post:', error);
                            $('#statusMessage').removeClass('alert-info').addClass('alert-danger').text('Error creating post: ' + xhr.responseText).show();
                        }
                    });
                });
            });
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>