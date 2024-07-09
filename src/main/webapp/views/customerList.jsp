<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer List</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/newcss.css">
        <link rel="stylesheet" href="./vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="./vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="./vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="./css/style.css">
        <style>
            .btn-xs {
                padding: .25rem .5rem;
                font-size: .75rem;
                line-height: 1.5;
                border-radius: .2rem;
                align-items: center;
                justify-content: center;
            }
            .dt-edit::before, .dt-delete::before {
                font-family: FontAwesome;
                display: inline-block;
                vertical-align: middle;
                align-items: center;
                justify-content: center;
            }
            .dt-edit::before {
                content: "\f044";
                margin-right: .5rem;
                font-family: FontAwesome;
            }
            .dt-delete::before {
                content: "\f1f8";
                margin-right: .5rem;
                font-family: FontAwesome;
            }
        </style>

    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <h2 class="text-center">Customer List</h2>
            <form action="customers" method="post" class="mb-5">
                <input type="hidden" name="action" value="add">
                <div class="form-row">
                    <div class="col-md-2">
                        <input type="text" name="fullname" placeholder="Full Name" class="form-control">
                    </div>
                    <div class="col-md-1">
                        <select name="gender" class="form-control">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="email" placeholder="Email" class="form-control">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="phone" placeholder="Phone" class="form-control">
                    </div>
                    <input type="hidden" name="status" value="2">
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-success">Add User</button>
                    </div>
                </div>
            </form>

            <div class="table-responsive-md-4">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Order</th>
                            <th>Full Name</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        List<User> users = (List<User>) request.getAttribute("users");
                        if (users != null && !users.isEmpty()) {
                            for (User user : users) { 
                        %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getFullname() %></td>
                            <td><%= user.getGender() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getPhone() %></td>

                            <td><%= user.getStatus() %></td> 
                            <td>
                                <button type="button" class="btn btn-primary btn-xs dt-edit" style="margin-right:16px;">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                </button>
                                <form action="customers" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="user_id" value="${user.userId}">
                                    <button type="submit" class="btn btn-danger btn-xs dt-delete">
                                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                    </button>
                                </form>
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
        </div>

        <jsp:include page="footer.jsp"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#example').DataTable({
                    searching: false, // Loại bỏ thanh tìm kiếm
                    paging: false, // Bật phân trang
                    info: true, // Bật hiển thị thông tin
                    lengthChange: false // Loại bỏ tùy chọn số lượng bản ghi
                });
            });
        </script>
    </body>
</html>
