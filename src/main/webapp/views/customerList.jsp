<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Khách Hàng</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css">

        <style>
            .table {
                font-size: 12px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <h2 class="text-center">Danh Sách Khách Hàng</h2>
            <form action="customers" method="get" class="mb-5">
                <div class="row">
                    <div class="col-md-4">
                        <input type="text" name="search" placeholder="Tìm kiếm theo tên" class="form-control" value="${param.search}">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-success mb-3" data-toggle="modal" data-target="#addUserModal">Thêm Người Dùng</button>
                    </div>
                </div>
            </form>

            <div class="table-responsive-md-4">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <%
                                String sortField = request.getParameter("sortField");
                                String sortOrder = request.getParameter("sortOrder");
                                String search = request.getParameter("search");

                                if (sortOrder == null) {
                                    sortOrder = "asc"; // Default sort order
                                }
                            %>
                            <th>STT</th>
                            <th class="sorting<%= sortField != null && sortField.equals("fullname") ? (sortOrder.equals("asc") ? "_asc" : "_desc") : ""%>"
                                onclick="window.location.href = 'customers?sortField=fullname&sortOrder=<%= sortOrder != null && sortOrder.equals("asc") ? "desc" : "asc"%>&search=<%= search != null ? search : ""%>'">
                                Họ Tên
                                <i class="bi <%= sortField != null && sortField.equals("fullname") ? (sortOrder.equals("asc") ? "bi-sort-alpha-up" : "bi-sort-alpha-down") : "bi-filter"%>"></i>
                            </th>
                            <th>Giới Tính</th>
                            <th>Email</th>
                            <th>Số Điện Thoại</th>
                            <th class="sorting<%= sortField != null && sortField.equals("create_at") ? (sortOrder.equals("asc") ? "_asc" : "_desc") : ""%>"
                                onclick="window.location.href = 'customers?sortField=create_at&sortOrder=<%= sortOrder != null && sortOrder.equals("asc") ? "desc" : "asc"%>&search=<%= search != null ? search : ""%>'">
                                Ngày Tạo
                                <i class="bi <%= sortField != null && sortField.equals("create_at") ? (sortOrder.equals("asc") ? "bi-sort-numeric-up" : "bi-sort-numeric-down") : "bi-filter"%>"></i>
                            </th>
                            <th class="sorting<%= sortField != null && sortField.equals("updated_at") ? (sortOrder.equals("asc") ? "_asc" : "_desc") : ""%>"
                                onclick="window.location.href = 'customers?sortField=updated_at&sortOrder=<%= sortOrder != null && sortOrder.equals("asc") ? "desc" : "asc"%>&search=<%= search != null ? search : ""%>'">
                                Ngày Cập Nhật
                                <i class="bi <%= sortField != null && sortField.equals("updated_at") ? (sortOrder.equals("asc") ? "bi-sort-numeric-up" : "bi-sort-numeric-down") : "bi-filter"%>"></i>
                            </th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<User> users = (List<User>) request.getAttribute("users");
                            if (users != null && !users.isEmpty()) {
                                for (int i = 0; i < users.size(); i++) {
                                    User user = users.get(i);
                        %>
                        <tr>
                            <td><%= i + 1%></td>
                            <td><a href="userDetail?userId=<%= user.getUserId()%>"><%= user.getFullname()%></a></td>
                            <td><%= user.getGender()%></td>
                            <td><%= user.getEmail()%></td>
                            <td><%= user.getPhone()%></td>
                            <td><%= user.getCreateAt()%></td>
                            <td><%= user.getUpdatedAt()%></td>
                            <td><%= user.getStatus()%></td>
                            <td>
                                <!-- Edit Button -->
                                <button class="table-link btn btn-link" data-toggle="modal" data-target="#editUserModal"
                                        data-userid="<%= user.getUserId()%>"
                                        data-fullname="<%= user.getFullname()%>"
                                        data-gender="<%= user.getGender()%>"
                                        data-email="<%= user.getEmail()%>"
                                        data-phone="<%= user.getPhone()%>"
                                        data-status="<%= user.getStatus()%>">
                                    <span class="fa-stack">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                                    </span>
                                </button>

                                <!-- Delete Button -->
                                <%--    <button class="table-link btn btn-link deleteUserButton" data-userid="<%= user.getUserId() %>"
                                        data-toggle="modal" data-target="#deleteUserModal">
                                    <span class="fa-stack">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
                                    </span>
                                </button>
                                --%>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center">Không có người dùng nào</td>
                        </tr>
                        <% } %>
                    </tbody>

                </table>
            </div>

            <!-- Pagination -->
            <nav class="blog-pagination justify-content-center d-flex">
                <ul class="pagination">
                    <%
                        int currentPage = (int) request.getAttribute("currentPage");
                        int totalPages = (int) request.getAttribute("totalPages");
                        String searchQuery = (String) request.getAttribute("searchQuery");
                        sortField = (String) request.getAttribute("sortField");
                        sortOrder = (String) request.getAttribute("sortOrder");

                        if (currentPage > 1) {
                    %>
                    <li class="page-item">
                        <a href="customers?index=<%= currentPage - 1%>&search=<%= searchQuery != null ? searchQuery : ""%>&sortField=<%= sortField != null ? sortField : ""%>&sortOrder=<%= sortOrder != null ? sortOrder : ""%>" class="page-link" aria-label="Previous">
                            <span aria-hidden="true">
                                <span class="lnr lnr-chevron-left"></span>
                            </span>
                        </a>
                    </li>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) {%>
                    <li class="page-item <%= (i == currentPage) ? "active" : ""%>">
                        <a href="customers?index=<%= i%>&search=<%= searchQuery != null ? searchQuery : ""%>&sortField=<%= sortField != null ? sortField : ""%>&sortOrder=<%= sortOrder != null ? sortOrder : ""%>" class="page-link"><%= i%></a>
                    </li>
                    <% } %>
                    <% if (currentPage < totalPages) {%>
                    <li class="page-item">
                        <a href="customers?index=<%= currentPage + 1%>&search=<%= searchQuery != null ? searchQuery : ""%>&sortField=<%= sortField != null ? sortField : ""%>&sortOrder=<%= sortOrder != null ? sortOrder : ""%>" class="page-link" aria-label="Next">
                            <span aria-hidden="true">
                                <span class="lnr lnr-chevron-right"></span>
                            </span>
                        </a>
                    </li>
                    <% }%>
                </ul>
            </nav>
        </div>
        <jsp:include page="footer.jsp"/>

        <!-- Modal Add User -->
        <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addUserModalLabel">Thêm Người Dùng</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addUserForm" action="customers" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="form-group">
                                <label for="fullname">Họ và Tên</label>
                                <input type="text" class="form-control" id="fullname" name="fullname" required>
                            </div>
                            <div class="form-group">
                                <label for="gender">Giới Tính</label>
                                <select class="form-control" id="gender" name="gender" required>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>

                                </select>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" required>

                                </div>
                            </div>
                            <div class="form-group">
                                <label for="phone">Số Điện Thoại</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                            </div>
                            <div class="form-group">
                                <label for="status">Trạng Thái</label>
                                <select class="form-control" id="status" name="status" required>
                                    <option value="active">Hoạt Động</option>
                                    <option value="inactive">Không Hoạt Động</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                            <span id="addUserMessage" class="ml-2"></span>

                        </form>
                    </div>
                </div>
            </div>
        </div>

         <!-- Edit User Modal -->
        <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editUserForm" method="post">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="user_id" id="editUserId">                      <div class="form-group">
                                <label for="editFullname">Họ và Tên</label>
                                <input type="text" class="form-control" id="editFullname" name="fullname" required>
                            </div>
                            <div class="form-group">
                                <label for="editGender">Giới Tính</label>
                                <select class="form-control" id="editGender" name="gender" required>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>

                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editEmail">Email</label>
                                <input type="email" class="form-control" id="editEmail" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="editPhone">Số Điện Thoại</label>
                                <input type="tel" class="form-control" id="editPhone" name="phone" required>
                            </div>
                            <div class="form-group">
                                <label for="editStatus">Trạng Thái</label>
                                <select class="form-control" id="editStatus" name="status" required>
                                    <option value="active">Hoạt Động</option>
                                    <option value="inactive">Không Hoạt Động</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>

                            <button type="submit" class="btn btn-primary">Lưu</button>
 <span id="editUserMessage" class="ml-2"></span>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Delete User -->
        <div class="modal fade" id="deleteUserModal" tabindex="-1" role="dialog" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteUserModalLabel">Xóa Người Dùng</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn xóa người dùng này không?</p>
                        <form action="deleteUser" method="post">
                            <input type="hidden" id="deleteUserId" name="userId">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                    $(document).ready(function () {
                                        $('#editUserForm').on('submit', function (e) {
                                            e.preventDefault();

                                            $.ajax({
                                                url: 'customers',
                                                type: 'POST',
                                                data: $(this).serialize(),
                                                success: function (response) {
                                                    $('#editUserMessage').text('Lưu thành công').css('color', 'green');
                                                    setTimeout(function () {
                                                        $('#editUserMessage').text('');
                                                        $('#editUserModal').modal('hide');
                                                        location.reload();  // Reload page to reflect changes
                                                    }, 2000);
                                                },
                                                error: function () {
                                                    $('#editUserMessage').text('Save failed').css('color', 'red');
                                                    setTimeout(function () {
                                                        $('#editUserMessage').text('');
                                                    }, 2000);
                                                }
                                            });
                                        });



                                        let userIdToDelete;

                                        // Open delete confirmation modal
                                        $('.deleteUserButton').on('click', function () {
                                            userIdToDelete = $(this).data('userid');
                                            $('#deleteUserId').val(userIdToDelete); // Set user_id to deleteUserForm
                                        });

                                        // Handle delete form submission
                                        $('#deleteUserForm').on('submit', function (e) {
                                            e.preventDefault();

                                            $.ajax({
                                                url: $(this).attr('action'),
                                                type: $(this).attr('method'),
                                                data: $(this).serialize(),
                                                success: function (response) {
                                                    if (response.status === 'success') {
                                                        $('#deleteUserModal').modal('hide');
                                                        location.reload();  // Reload page to reflect changes
                                                    } else {
                                                        alert('Delete failed: ' + response.message);
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    alert('Delete failed: ' + xhr.responseText);
                                                }
                                            });
                                        });

                                        $('#addUserForm').on('submit', function (e) {
                                            e.preventDefault();

                                            $.ajax({
                                                url: $(this).attr('action'),
                                                type: $(this).attr('method'),
                                                data: $(this).serialize(),
                                                success: function (response) {
                                                    if (response.status === 'success') {
                                                        $('#addUserMessage').text('Thêm người dùng mới thành công').css('color', 'green');
                                                        setTimeout(function () {
                                                            $('#addUserMessage').text('');
                                                            $('#addUserModal').modal('hide');
                                                            location.reload();  // Reload page to reflect changes
                                                        }, 2000);
                                                    } else {
                                                        $('#addUserMessage').text('Thất bại: ' + response.message).css('color', 'red');
                                                        setTimeout(function () {
                                                            $('#addUserMessage').text('');
                                                        }, 5000);
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    $('#addUserMessage').text('Thất bạ :' + xhr.responseText).css('color', 'red');
                                                    setTimeout(function () {
                                                        $('#addUserMessage').text('');
                                                    }, 5000);
                                                }
                                            });
                                        });


                                        $('#editUserModal').on('show.bs.modal', function (event) {
                                            var button = $(event.relatedTarget);
                                            var userId = button.data('userid');
                                            var fullname = button.data('fullname');
                                            var gender = button.data('gender');
                                            var email = button.data('email');
                                            var phone = button.data('phone');
                                            var status = button.data('status');

                                            var modal = $(this);
                                            modal.find('.modal-body #editUserId').val(userId);
                                            modal.find('.modal-body #editFullname').val(fullname);
                                            modal.find('.modal-body #editGender').val(gender);
                                            modal.find('.modal-body #editEmail').val(email);
                                            modal.find('.modal-body #editPhone').val(phone);
                                            modal.find('.modal-body #editStatus').val(status);
                                        });
                                    });


        </script>
    </body>
</html>
