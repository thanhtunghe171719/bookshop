<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
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
            .body{
                margin-bottom: 50px;
            }
            .table{
                font-size: 11px;
            }
            .inner-form {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                font-size: 15px;
            }
            .input-field {
                position: relative;
                width: calc(20% - 1rem);
            }
            .input-field input, .input-field select, .input-field button {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid #ccc;
                border-radius: 0.25rem;
            }
            .input-field .icon-wrap {
                position: absolute;
                top: 50%;
                left: 0.75rem;
                transform: translateY(-50%);
            }
            .input-field .icon-wrap svg {
                fill: #888;
            }
            .btn-search {
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                padding: 0.75rem 1.5rem;
            }
            .btn-search:hover {
                background-color: #0056b3;
            }
            fieldset {
                border: 1px solid #ccc;
                padding: 0.75rem;
                margin-bottom: 1rem;
            }
            legend {
                padding: 0 0.75rem;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <h2 class="text-center">Danh Sách Người Dùng</h2>
            <form action="userList" method="get" class="mb-5">
                <fieldset>
                    <div class="inner-form">
                        <div class="input-field first-wrap">
                            <input id="search" name="search" type="text" placeholder="Tìm theo tên" value="${param.search}">
                        </div>
                        <div class="input-field second-wrap">
                            <select name="gender">
                                <option value="">Tất cả giới tính</option>
                                <option value="Nam" <c:if test="${param.gender == 'Nam'}"></c:if>Nam</option>
                                <option value="Nữ" <c:if test="${param.gender == 'Nữ'}"></c:if>Nữ</option>
                            </select>
                        </div>
                        <div class="input-field third-wrap">
                            <select name="role">
                                <option value="">Tất cả vai trò</option>
                                <option value="sale" <c:if test="${param.role == 'sale'}"></c:if>Sale</option>
                                <option value="customer" <c:if test="${param.role == 'customer'}"></c:if>Customer</option>
                                <option value="Marketing" <c:if test="${param.role == 'Marketing'}"></c:if>Marketing</option>
                            </select>
                        </div>
                        <div class="input-field fouth-wrap">
                            <select name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="Active" <c:if test="${param.status == 'Active'}"></c:if>Active</option>
                                <option value="Inactive" <c:if test="${param.status == 'Inactive'}"></c:if>Inactive</option>
                            </select>
                        </div>
                        <div class="input-field fifth-wrap">
                            <button class="btn-search" type="submit">TÌM KIẾM</button>
                        </div>
                    </div>
                </fieldset>
                <div class="col-md-2">
                    <button type="button" class="btn btn-success mb-3" data-toggle="modal" data-target="#addUserModal">Thêm Người Dùng</button>
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
                            <th>Thứ tự</th>
                            <th class="sorting<%= sortField != null && sortField.equals("fullname") ? (sortOrder.equals("asc") ? "_asc" : "_desc") : ""%>"
                                onclick="window.location.href = 'userList?sortField=fullname&sortOrder=<%= sortOrder != null && sortOrder.equals("asc") ? "desc" : "asc"%>&search=<%= search != null ? search : ""%>'">
                                Họ và Tên 
                                <i class="bi <%= sortField != null && sortField.equals("fullname") ? (sortOrder.equals("asc") ? "bi-sort-alpha-up" : "bi-sort-alpha-down") : "bi-filter"%>"></i>
                            </th>
                            <th>Giới tính</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th class="sorting<%= sortField != null && sortField.equals("create_at") ? (sortOrder.equals("asc") ? "_asc" : "_desc") : ""%>" 
                                onclick="window.location.href = 'userList?sortField=create_at&sortOrder=<%= sortOrder != null && sortOrder.equals("asc") ? "desc" : "asc"%>&search=<%= search != null ? search : ""%>'">
                                Ngày tạo 
                                <i class="bi <%= sortField != null && sortField.equals("create_at") ? (sortOrder.equals("asc") ? "bi-sort-numeric-up" : "bi-sort-numeric-down") : "bi-filter"%>"></i>
                            </th>
                            <th class="sorting<%= sortField != null && sortField.equals("updated_at") ? (sortOrder.equals("asc") ? "_asc" : "_desc") : ""%>" 
                                onclick="window.location.href = 'userList?sortField=updated_at&sortOrder=<%= sortOrder != null && sortOrder.equals("asc") ? "desc" : "asc"%>&search=<%= search != null ? search : ""%>'">
                                Ngày cập nhật 
                                <i class="bi <%= sortField != null && sortField.equals("updated_at") ? (sortOrder.equals("asc") ? "bi-sort-numeric-up" : "bi-sort-numeric-down") : "bi-filter"%>"></i>
                            </th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
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
                            <td><%= user.getRoleName()%></td>
                            <td><%= user.getStatus()%></td>
                            <td>
                                <!-- Edit Button -->
                                <button class="table-link btn btn-link" data-toggle="modal" data-target="#editUserModal"
                                        data-userid="<%= user.getUserId()%>"
                                        data-fullname="<%= user.getFullname()%>"
                                        data-gender="<%= user.getGender()%>"
                                        data-email="<%= user.getEmail()%>"
                                        data-phone="<%= user.getPhone()%>"
                                        data-role="<%= user.getRoleName()%>"
                                        data-status="<%= user.getStatus()%>">

                                    <span class="fa-stack">
                                        <i class="fa fa-square fa-stack-2x"></i>
                                        <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                                    </span>
                                </button>
                            </td>
                        </tr>
                        <%  }
                        } else { %>
                        <tr>
                            <td colspan="10" class="text-center">Không tìm thấy người dùng nào.</td>
                        </tr>
                        <%  } %>
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
                        String gender = (String) request.getAttribute("gender");
                        String role = (String) request.getAttribute("role");
                        String status = (String) request.getAttribute("status");

                        String buildUrl = "userList?index=";
                        String parameters = "&search=" + (searchQuery != null ? searchQuery : "")
                                + "&sortField=" + (sortField != null ? sortField : "")
                                + "&sortOrder=" + (sortOrder != null ? sortOrder : "")
                                + "&gender=" + (gender != null ? gender : "")
                                + "&role=" + (role != null ? role : "")
                                + "&status=" + (status != null ? status : "");

                        if (currentPage > 1) {
                    %>
                    <li class="page-item">
                        <a href="<%= buildUrl + (currentPage - 1) + parameters%>" class="page-link" aria-label="Previous">
                            <span aria-hidden="true">
                                <span class="lnr lnr-chevron-left"></span>
                            </span>
                        </a>
                    </li>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) {%>
                    <li class="page-item <%= (i == currentPage) ? "active" : ""%>">
                        <a href="<%= buildUrl + i + parameters%>" class="page-link"><%= i%></a>
                    </li>
                    <% } %>
                    <% if (currentPage < totalPages) {%>
                    <li class="page-item">
                        <a href="<%= buildUrl + (currentPage + 1) + parameters%>" class="page-link" aria-label="Next">
                            <span aria-hidden="true">
                                <span class="lnr lnr-chevron-right"></span>
                            </span>
                        </a>
                    </li>
                    <% }%>
                </ul>
            </nav>
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
                            <input type="hidden" name="user_id" id="editUserId">
                            <div class="form-group">
                                <label for="fullname">Họ và Tên</label>
                                <input type="text" class="form-control" name="fullname" id="editFullname" required>
                            </div>
                            <div class="form-group">
                                <label for="gender">Giới Tính</label>
                                <select class="form-control" name="gender" id="editGender" required>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" name="email" id="editEmail" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" id="editPhone" required>
                            </div>
                            <div class="form-group">
                                <label for="role">Role</label>
                                <select class="form-control"  name="role" id="editRole" required>
                                    <option value="Sale">Sale</option>
                                    <option value="Customer" >Customer</option>
                                    <option value="Marketing" >Marketing</option>
                                    <option value="Sale Manager" >Sale Manager</option>
                                    <option value="Shipper" >Shipper</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="status">Status</label>
                                <select class="form-control" name="status" id="editStatus" required>
                                    <option value="active">Active</option>
                                    <option value="inactive">Inactive</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <span id="editUserMessage" class="ml-2"></span>
                        </form>
                    </div>
                </div>
            </div>

        </div>
            <!-- Add User Modal -->
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
                            <form id="addUserForm" action="userList" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="form-group">
                                    <label for="fullname">Họ và Tên</label>
                                    <input type="text" class="form-control" id="fullname" name="fullname" required>
                                </div>
                                <div class="form-group">
                                    <label for="gender">Giới Tính</label>
                                    <select class="form-control" name="gender" id="editGender" required>
                                        <option value="Nam">Nam</option>
                                        <option value="Nữ">Nữ</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                                <div class="form-group">
                                    <label for="phone">Số điện thoại</label>
                                    <input type="text" class="form-control" id="phone" name="phone" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="password" name="password" required>

                                    </div>
                                </div> 
                                <div class="form-group">
                                    <label for="role">Vai trò</label>
                                    <select class="form-control" id="role" name="role" required>
                                        <option value="Sale">Sale</option>
                                        <option value="Customer">Customer</option>
                                        <option value="Marketing">Marketing</option>
                                        <option value="Sale Manager" >Sale Manager</option>
                                        <option value="Shipper" >Shipper</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="status">Trạng thái</label>
                                    <select class="form-control" id="status" name="status" required>
                                        <option value="active">Active</option>
                                        <option value="inactive">Inactive</option>
                                    </select>
                                </div>

                                <button type="submit" class="btn btn-primary">Thêm Người Dùng</button>
                                <span id="addUserMessage" class="ml-2"></span>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                                    $(document).ready(function () {
                                        $('#editUserForm').on('submit', function (e) {
                                            e.preventDefault();

                                            $.ajax({
                                                url: 'userList',
                                                type: 'POST',
                                                data: $(this).serialize(),
                                                success: function (response) {
                                                    $('#editUserMessage').text('Save successful').css('color', 'green');
                                                    setTimeout(function () {
                                                        $('#editUserMessage').text('');
                                                        $('#editUserModal').modal('hide');
                                                        location.reload();  // Reload page to reflect changes
                                                    }, 2000);
                                                },
                                                error: function (xhr) {
                                                    let errorMessage = 'Save failed';
                                                    if (xhr.responseJSON && xhr.responseJSON.message) {
                                                        errorMessage += ': ' + xhr.responseJSON.message;
                                                    }
                                                    $('#editUserMessage').text(errorMessage).css('color', 'red');
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
                                                error: function (xhr) {
                                                    let errorMessage = 'Delete failed';
                                                    if (xhr.responseJSON && xhr.responseJSON.message) {
                                                        errorMessage += ': ' + xhr.responseJSON.message;
                                                    }
                                                    alert(errorMessage);
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
                                                        $('#addUserMessage').text('User added successfully').css('color', 'green');
                                                        setTimeout(function () {
                                                            $('#addUserMessage').text('');
                                                            $('#addUserModal').modal('hide');
                                                            location.reload();  // Reload page to reflect changes
                                                        }, 2000);
                                                    } else {
                                                        $('#addUserMessage').text('Failed to add user: ' + response.message).css('color', 'red');
                                                        setTimeout(function () {
                                                            $('#addUserMessage').text('');
                                                        }, 2000);
                                                    }
                                                },
                                                error: function (xhr) {
                                                    let errorMessage = 'Failed to add user';
                                                    if (xhr.responseJSON && xhr.responseJSON.message) {
                                                        errorMessage += ': ' + xhr.responseJSON.message;
                                                    }
                                                    $('#addUserMessage').text(errorMessage).css('color', 'red');
                                                    setTimeout(function () {
                                                        $('#addUserMessage').text('');
                                                    }, 2000);
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
                                            var role = button.data('role');
                                            var status = button.data('status');

                                            var modal = $(this);
                                            modal.find('.modal-body #editUserId').val(userId);
                                            modal.find('.modal-body #editFullname').val(fullname);
                                            modal.find('.modal-body #editGender').val(gender);
                                            modal.find('.modal-body #editEmail').val(email);
                                            modal.find('.modal-body #editPhone').val(phone);
                                            modal.find('.modal-body #editRole').val(role);
                                            modal.find('.modal-body #editStatus').val(status);
                                        });
                                    });


            </script>

    </body>
</html>
