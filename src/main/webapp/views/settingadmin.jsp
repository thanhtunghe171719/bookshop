<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Admin Setting</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: white;
                margin: 0;
                padding: 0;
            }
            .container {
                display: flex;
            }
            .sidebar {
                width: 200px;
                padding: 20px;
                background-color: #f0f0f0;
                height: 100vh;
            }
            .main-content {
                flex-grow: 1;
                padding: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            .search-bar {
                margin-bottom: 20px;
            }
            .status {
                padding: 3px 8px;
                border-radius: 12px;
                font-size: 12px;
            }
            .active {
                background-color: white;
            }
            .inactive {
                background-color: red;
                color: white;
            }
            .sidebar a {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: black;
                cursor: pointer;
            }
            .sidebar a:hover {
                background-color: #ddd;
            }
            .content {
                display: none;
            }
            .content.active {
                display: block;
            }
            .status-btn {
                padding: 5px 10px;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                font-size: 12px;
            }
            .status-btn.active {
                background-color: #4CAF50;
                color: white;
            }
            .status-btn.inactive {
                background-color: #f44336;
                color: white;
                .category-image {
                    width: 50px;
                    height: 50px;
                    object-fit: cover;
                    border-radius: 5px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page = "header.jsp"/>
        <div class="container">
            <div class="sidebar">
                <a onclick="showContent('userRole')">Cài đặt vai trò</a>
                <a onclick="showContent('category')">Cài đặt danh mục</a>
            </div>
            <div class="main-content">
                <div id="userRoleContent" class="content active">
                    <h2>Cài đặt vai trò</h2>             
                    <div class="search-bar">
                        <div class="col-md-6 text-right">
                            <button class="btn btn-primary" style="background-color: green; color: white;" onclick="addNewRole()">Tạo vai trò</button>
                        </div>
<!--                        <div class="modal" id="addRoleModal" tabindex="-1" role="dialog">
                            
                    <div class="modal-dialog" role="document" style="max-width: 800px; margin: 100px auto;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Tạo Role Mới</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="addRoleForm" action="settingadmin" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
                                    <input type="hidden" name="service" value="addRole">
                                    <div class="form-group">
                                        <label for="newId">Role ID</label>
                                        <input type="number" class="form-control" id="newId" name="newId" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="newName">Role Name</label>
                                        <textarea class="form-control" id="newName" name="newName" rows="3" required></textarea>
                                    </div>
                                    <div class="form-group" style="padding-bottom: 10px">
                                        <div for="newStatus">Trạng Thái</div>
                                        <div>
                                            <select class="form-control" id="newStatus" name="newStatus">
                                                <option value="Active">Active</option>
                                                <option value="Inactive">Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div style="text-align: center;">
                                        <button type="submit" class="btn btn-primary">Thêm</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>-->
                    </div>
                    <h4 class="text-primary" style="padding-top: 20px;">${messageRole}</h4>
            <%
//                String messageSlider = (String) session.getAttribute("messageSlider");
//                messageSlider = "";
                session.setAttribute("messageSlider", "");
            %>
            <br>
                    <table>
                        <tr>
                            <th>Role ID</th>
                            <th>Tên vai trò</th>
                            <th>Trạng thái</th>
                        </tr>
                        <c:forEach items="${listRole}" var="role">
                            <tr>
                                <td>${role.role_id}</td>
                                <td>${role.role_name}</td>
                                <td>
                                    <button onclick="updateStatus(${role.role_id}, ${role.status_id})" class="status-btn ${role.status_id == 1 ? 'active' : 'inactive'}">
                                        ${role.status_id == 1 ? 'Active' : 'Inactive'}
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div id="categoryContent" class="content">
                    <h2>Cài đặt danh mục</h2>
                    <div class="search-bar">
                        <div class="col-md-6 text-right">
                            <button class="btn btn-primary" style="background-color: green; color: white;" onclick="addNewCategory()">Tạo danh mục</button>
                        </div>
                    </div>
                    <table>
                        <tr>
                            <th>ID Danh mục</th>
                            <th>Tên danh mục</th>
                            <th>Ảnh</th>
                        </tr>
                        <c:forEach items="${categories}" var="category">
                            <tr>
                                <td>${category.categoryId}</td>
                                <td>${category.categoryName}</td>
                                <td><img src="${category.image}" alt="${category.categoryName}" style="width: 50px; height: 50px;"></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </body>
    <script>
        function showContent(contentType) {
            var contents = document.getElementsByClassName('content');
            for (var i = 0; i < contents.length; i++) {
                contents[i].classList.remove('active');
            }
            document.getElementById(contentType + 'Content').classList.add('active');
        }
        function updateStatus(roleId, currentStatus) {
            var newStatus = currentStatus === 'Active' ? 'Inactive' : 'Active';
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    // Handle response from the server if needed
                    console.log("Status updated successfully.");
                    // Reload the page to reflect changes
                    window.location.reload();
                }
            };
            xhr.open("GET", "settingadmin?service=updateStatus&roleId=" + role_id + "&newStatus=" + newStatus, true);
            xhr.send();
        }

        function showAddRoleModal() {
            document.getElementById('addRoleModal').style.display = 'block';
        }

        function closeAddRoleModal() {
            document.getElementById('addRoleModal').style.display = 'none';
        }

        const style = document.createElement('style');
        style.innerHTML = `
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    `;
        document.head.appendChild(style);
    </script>
    <script>
        function updateStatus(sliderId, currentStatus) {
            var newStatus = currentStatus === 'Show' ? 'Hide' : 'Show';
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    console.log("Cập nhật trạng thái thành công.");
                    var button = event.target;
                    button.textContent = newStatus;
                    button.classList.toggle('active');
                    button.classList.toggle('inactive');
                }
            };
            xhr.open("GET", "settingadmin?service=updateSliderStatus&sliderId=" + sliderId + "&newStatus=" + newStatus, true);
            xhr.send();
        }
    </script>
    <script>
        function addNewRole() {
            $('#addRoleModal').modal('show');
        }
    </script>
</html>