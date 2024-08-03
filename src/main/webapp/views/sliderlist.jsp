<%-- 
    Document   : sliderlist
    Created on : Jul 14, 2024, 5:58:49 PM
    Author     : TDG
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Marketing Slider</title>
        <link rel="icon" href="./img/Fevicon.png" type="image/png">
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
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>
        <!--================ End Header Menu Area =================-->

        <div class="container mt-5">
            <h2 style="padding-bottom: 10px ">Quản Lý Slider</h2>
            <div class="row">

                <div class="col-md-4">
                    <input type="text" id="titleSearch" name="title" value="${param.title}" class="form-control" placeholder="Tìm kiếm theo tiêu đề" style="width: 250px" onkeypress="checkEnter(event)">
                </div>

                <div class="col-md-2">
                    <select id="statusFilter" name="status" class="form-control" onchange="search()">
                        <option value="" ${param.status == '' ? 'selected' : ''}>Trạng Thái</option>
                        <option value="Show" ${param.status == 'Show' ? 'selected' : ''}>Show</option>
                        <option value="Hide" ${param.status == 'Hide' ? 'selected' : ''}>Hide</option>
                    </select>
                </div>

                <div class="col-md-6 text-right">
                    <button class="btn btn-primary" onclick="addNewSlider()">Tạo slider mới</button>
                </div>

                <!-- Modal for adding new slider -->
                <div class="modal" id="addSliderModal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document" style="max-width: 800px; margin: 100px auto;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Tạo Slider Mới</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="addSliderForm" action="marketingslider" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
                                    <input type="hidden" name="service" value="addSlider">
                                    <div class="form-group">
                                        <label for="newTitle">Tiêu Đề</label>
                                        <input type="text" class="form-control" id="newTitle" name="newTitle" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="editImage">Image</label>
                                        <input type="file" class="form-control-file" id="editImage" name="newImage" accept="image/*" required onchange="updateImagePreview(this, 0)">
                                        <img id="imagePreview_0" src="${slider.image}" alt="alt" style="width: 200px; height: 100px;"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="newDescription">Mô tả</label>
                                        <textarea class="form-control" id="newDescription" name="newDescription" rows="3" required></textarea>
                                    </div>
                                    <div class="form-group" style="padding-bottom: 10px">
                                        <div for="newStatus">Trạng Thái</div>
                                        <div>
                                            <select class="form-control" id="newStatus" name="newStatus">
                                                <option value="Show">Show</option>
                                                <option value="Hide">Hide</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div style="text-align: center;">
                                        <button type="submit" class="btn btn-primary">Thêm Slider</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>    

            <!-- Notification Section -->
            <h4 class="text-primary" style="padding-top: 20px;">${messageSlider}</h4>
            <%
//                String messageSlider = (String) session.getAttribute("messageSlider");
//                messageSlider = "";
                session.setAttribute("messageSlider", "");
            %>
            <br>
            <table class="table table-hover table-bordered" >
                <tr>
                    <td>Hình Ảnh</td>
                    <td>Tiêu Đề</td>
                    <td>Mô Tả</td>
                    <td>Trạng Thái</td>
                    <td>Hoạt Động</td>
                </tr>
                <c:if test="${not empty listSlider}">
                    <c:forEach var="slider" items="${listSlider}">
                        <tr>
                            <td><img src="${slider.image}" alt="alt" style="width: 210px;height: 110px"/></td>
                            <td style="width: 200px">${slider.title}</td>
                            <td style="width: 480px">${slider.description}</td>
                            <td>
                                <button class="btn ${slider.status == 'Show' ? 'btn-success' : 'btn-danger'}"  onclick="updateStatus(${slider.sliderId}, '${slider.status}')">${slider.status}</button>
                            </td>
                            <td>
                                <ul>
                                    <li><button class="btn btn-success" data-toggle="modal" data-target="#pop_up_view_${slider.sliderId}" style="width: 60px">Xem</button></li>
                                    <li><button class="btn btn-primary" onclick="editSlider(${slider.sliderId})"  style="width: 60px">Sửa</button></li>
                                    <li><button class="btn btn-danger" onclick="deleteSlider(${slider.sliderId})" style="width: 60px">Xóa</button></li>
                                </ul>    



                            </td>
                        </tr>

                        <!-- View -->
                        <div id="pop_up_view_${slider.sliderId}" class="modal fade" role="dialog">
                            <div class="modal-dialog" style="max-width: 800px; margin: 100px auto;">
                                <div class="modal-content" style="padding: 20px;border: none;box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2);">
                                    <a class="close" href="#" data-dismiss="modal" style="position: absolute;top: 10px;right: 15px;font-size: 30px;color: #aaa;cursor: pointer;">×</a>
                                    <div class="page-body" style="padding: 20px;">
                                        <div class="head" style="text-align: center;margin-bottom: 20px;">
                                            <img src="${slider.image}" alt="alt" style="width: 200px; height: 100px"/>
                                        </div>
                                        <div>
                                            <ul style="list-style: none;padding: 0;margin: 0;">

                                                <li>Tiêu Đề</li>
                                                <li><textarea name="name" readonly  style="width: calc(100% - 10px);padding: 8px;margin-bottom: 10px;
                                                              box-sizing: border-box;border: 1px solid #ccc;border-radius: 4px;
                                                              background-color: #f2f2f2; min-height: 150px;height: auto;">${slider.title}</textarea></li>
                                                <li>Mô Tả</li>
                                                <li><textarea name="name" readonly  style="width: calc(100% - 10px);padding: 8px;margin-bottom: 10px;
                                                              box-sizing: border-box;border: 1px solid #ccc;border-radius: 4px;
                                                              background-color: #f2f2f2; min-height: 150px;height: auto;">${slider.description}</textarea></li>
                                                <li>Trạng Thái</li>
                                                <li><input type="text" name="name" value="${slider.status}" readonly  style="width: calc(100% - 10px);
                                                           padding: 8px;margin-bottom: 10px;box-sizing: border-box;
                                                           border: 1px solid #ccc;border-radius: 4px;background-color: #f2f2f2;"></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Modal for editing slider -->
                        <div class="modal" id="editSliderModal_${slider.sliderId}" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document" style="max-width: 800px; margin: 100px auto;">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Chỉnh Sửa Slider</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="editSliderForm_${slider.sliderId}" action="marketingslider" method="POST" enctype="multipart/form-data"  onsubmit="submitEditForm(event, ${slider.sliderId})">
                                            <input type="hidden" name="service" value="updateSlider">
                                            <input type="hidden" name="sliderId" value="${slider.sliderId}">
                                            <div class="form-group">
                                                <label for="editTitle_${slider.sliderId}">Tiêu Đề</label>
                                                <input type="text" class="form-control" id="editTitle_${slider.sliderId}" name="title" value="${slider.title}" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editImage_${slider.sliderId}">Hình Ảnh</label>
                                                <input type="file" class="form-control-file" id="editImage_${slider.sliderId}" name="image" accept="image/*" onchange="updateImagePreview(this, ${slider.sliderId})">
                                                <img id="imagePreview_${slider.sliderId}" src="${slider.image}" alt="alt" style="width: 200px; height: 100px;"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="editDescription_${slider.sliderId}">Mô Tả</label>
                                                <textarea class="form-control" id="editDescription_${slider.sliderId}" name="description" rows="3" required>${slider.description}</textarea>
                                            </div>
                                            <div class="form-group" style="padding-bottom: 10px">
                                                <div>
                                                    <label for="editStatus_${slider.sliderId}">Trạng Thái</label>
                                                </div>
                                                <div>
                                                    <select class="form-control" id="editStatus_${slider.sliderId}" name="status">
                                                        <option value="Show" ${slider.status == 'Show' ? 'selected' : ''}>Show</option>
                                                        <option value="Hide" ${slider.status == 'Hide' ? 'selected' : ''}>Hide</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div style="text-align: center;">
                                                <button type="submit" class="btn btn-primary">Lưu</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:forEach>
                </c:if>
                <c:if test="${ empty listSlider}"><tr><td colspan="5"><h3 class="text-success" style="text-align:center">Không Có Sản Phẩm</h3></td></tr></c:if> 
                </table>

                <!-- Phân trang -->
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">

                    <c:if test="${page > 1}">
                        <li class="page-item"><a class="page-link" href="marketingslider?service=listAll&page=1&title=${title}&status=${status}" >Đầu</a></li>
                        <li class="page-item"><a class="page-link" href="marketingslider?service=listAll&page=${page - 1}&title=${title}&status=${status}">Trước</a></li>
                        </c:if>

                    <c:forEach begin="1" end="${totalPage}" var="pageNumber">
                        <li class="page-item ${pageNumber == page ? 'active' : ''}">
                            <a class="page-link" href="marketingslider?service=listAll&page=${pageNumber}&title=${title}&status=${status}">${pageNumber}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${page < totalPage}">
                        <li class="page-item"><a class="page-link" href="marketingslider?service=listAll&page=${page + 1}&title=${title}&status=${status}">Tiếp</a></li>
                        <li class="page-item"><a class="page-link" href="marketingslider?service=listAll&page=${totalPage}&title=${title}&status=${status}">Cuối</a></li>
                        </c:if>

                </ul>
            </nav>
        </div>



        <br>
        <!--================ Start footer Area  =================-->	
        <jsp:include page="footer.jsp"/>
        <!--================ End footer Area  =================-->

    </body>

    <script>
        function validateForm() {
            // Lấy các giá trị của các trường
            var title = document.getElementById('newTitle').value.trim();
            var description = document.getElementById('newDescription').value.trim();

            // Kiểm tra nếu trường bị bỏ trống sau khi loại bỏ dấu cách
            if (title === '') {
                alert('Tiêu đề không được chỉ chứa dấu cách!');
                return false;
            }

            if (description === '') {
                alert('Mô tả không được chỉ chứa dấu cách!');
                return false;
            }

            // Nếu không có lỗi, cho phép gửi biểu mẫu
            return true;
        }
        function search() {
            var title = document.getElementById('titleSearch').value;
            var status = document.getElementById('statusFilter').value;
            var url = 'marketingslider?service=listAll&title=' + title + '&status=' + status;
            window.location.href = url;
        }
        function checkEnter(event) {
            if (event.key === 'Enter') {
                search();
            }
        }
        function updateStatus(sliderId, currentStatus) {
            var newStatus = currentStatus === 'Show' ? 'Hide' : 'Show';
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    // Handle response from the server if needed
                    console.log("Status updated successfully.");
                    // Reload the page to reflect changes
                    window.location.reload();
                }
            };
            xhr.open("GET", "marketingslider?service=updateStatus&sliderId=" + sliderId + "&newStatus=" + newStatus, true);
            xhr.send();
        }

        function deleteSlider(sliderId) {
            if (confirm('Bạn có chắc chắn muốn xóa slider này không?')) {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        // Handle response from the server if needed
                        console.log("Slider deleted successfully.");
                        // Reload the page to reflect changes
                        window.location.reload();
                    }
                };
                xhr.open("GET", "marketingslider?service=delete&sliderId=" + sliderId, true);
                xhr.send();
            }
        }

        function addNewSlider() {
            $('#addSliderModal').modal('show');
        }

        function editSlider(id) {
            $('#editSliderModal_' + id).modal('show');
        }

        function submitEditForm(event, sliderId) {
            event.preventDefault();
            // Lấy giá trị từ các trường
            var title = document.getElementById('editTitle_' + sliderId).value.trim();
            var description = document.getElementById('editDescription_' + sliderId).value.trim();

            // Kiểm tra nếu các trường bị bỏ trống sau khi loại bỏ dấu cách
            if (title === '') {
                alert('Tiêu đề không được chỉ chứa dấu cách!');
                return;
            }

            if (description === '') {
                alert('Mô tả không được chỉ chứa dấu cách!');
                return;
            }
            var formData = new FormData(document.getElementById('editSliderForm_' + sliderId));
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'marketingslider', true);
            xhr.onload = function () {
                if (xhr.status === 200) {
                    // Handle response from the server if needed
                    console.log('Slider updated successfully.');
                    $('#editSliderModal_' + sliderId).modal('hide');
                    // Optionally, update the slider list dynamically here
                    window.location.reload();
                }
            };
            xhr.send(formData);
        }

        function updateImagePreview(input, index) {
            const file = input.files[0];
            if (file && ['image/png', 'image/jpeg'].includes(file.type)) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('imagePreview_' + index).src = e.target.result;
                };
                reader.readAsDataURL(file);
            } else {
                alert("Vui lòng chọn tệp PNG hoặc JPG.");
                input.value = ""; // Reset the input
                document.getElementById('imagePreview_' + index).src = ""; // Clear the image preview
            }
        }

    </script>

    <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
    <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="vendors/skrollr.min.js"></script>
    <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
    <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
    <script src="vendors/jquery.ajaxchimp.min.js"></script>
    <script src="vendors/mail-script.js"></script>
    <script src="js/main.js"></script>
</html>
