<%-- 
    Document   : editProfile
    Created on : May 27, 2024, 2:06:51 PM
    Author     : kobietkolam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Profile</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            
            .tab-pane {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background-color: #f9f9f9; /* Light grey background for contrast */
            }

            .login {
                width: 100%;
                margin-top: 20px;
                margin-bottom: 20px;
                max-width: 500px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: #fff;
                border-radius: 8px;
            }

            .login_form_container {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .form-row {
                width: 100%;
                margin-bottom: 15px;
            }

            .form-row label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .input_type {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .save_button {
                display: flex;
                align-items: center;
            }

            .save_button .status_message {
                margin-left: 10px; /* Adjust as needed for spacing */
                min-width: 200px;  /* Adjust as needed to reserve space */
                text-align: left;  /* Align the text to the left */
            }

            .save_button .status_message h6 {
                margin: 0;
            }

            .primary_btn {
                background-color: #007bff; /* Blue color for the button */
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .primary_btn:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }

            .edit {
                background-color: transparent; /* Transparent background */
                color: #007bff; /* Blue text color */
                padding: 10px 20px;
                border: 2px solid #007bff; /* Blue border */
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .edit:hover {
                background-color: #007bff; /* Blue background on hover */
                color: #fff; /* White text color on hover */

            }
            .profile-image {
                text-align: center;
                margin-bottom: 20px;
            }

            .profile-image img {
                border-radius: 50%;
                width: 150px;
                height: 150px;
                object-fit: cover;
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        

        <!--profile popup-->
        <div class="tab-pane fade show active" id="account-details">
            <div class="login">
                <div class="login_form_container">
                    <!-- Profile Image -->
                    <div class="profile-image">
                        <c:if test="${not empty user.image}">
                            <img src="${user.image}" alt="Profile Image">
                        </c:if>
                    </div>
                    <form id="form-1" action="editprofile" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="user_id" value="${user.userId}">
                        <div class="form-row">
                            <label for="fullname">Họ và tên</label>
                            <input class="input_type" type="text" name="fullname" value="${user.fullname}" readonly>
                        </div>
                        <div class="form-row">
                            <label for="email">Email</label>
                            <input class="input_type" type="text" name="email" value="${user.email}" readonly>
                        </div>
                        <div class="form-row">
                            <label for="gender">Giới tính  </label>
                            <select class="select_type" name="gender" id="gender" disabled>
                                <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>
                        <div class="form-row">
                            <label for="address">Địa chỉ</label>
                            <input class="input_type" type="text" name="address" value="${user.address}" readonly>
                        </div>
                        <div class="form-row">
                            <label for="phone">Số điện thoại</label>
                            <input class="input_type" type="text" name="phone" value="${user.phone}" readonly>
                        </div>
                        <div class="form-row">
                            <label for="image">Ảnh đại diện</label>
                            <input type="file" name="image" accept=".png, .jpg, .jpeg" class="input_type" readonly>
                        </div>
                        <div class="save_button">
                            <button onclick="changeType(this)" id="edit" type="button" class="edit">Edit</button>
                            <div class="status_message">
                                <c:if test="${requestScope.STATUS != null}">
                                    <h6 style="color: green">${requestScope.STATUS}</h6>
                                </c:if>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>


        <jsp:include page="footer.jsp"/>

        <script type="text/javascript">
            function changeType(button) {
                var inputElements = document.querySelectorAll(".input_type, .select_type");
                if (button.id === "edit") {
                    button.id = "save";
                    button.textContent = "Save";
                    inputElements.forEach(x => {
                        if (x.name !== "email") {
                            x.readOnly = false;
                            x.disabled = false;
                            x.classList.add("default_input");
                        }
                    });
                } else {
                    document.getElementById("form-1").submit();
                }
            }

            window.addEventListener('load', function () {
                var statusMessage = document.getElementById('statusMessage');
                var status = '<%= request.getAttribute("STATUS")%>';

                if (status) {
                    statusMessage.textContent = status;
                    statusMessage.classList.add(status.includes('Error') ? 'error' : '');
                    statusMessage.style.display = 'block';
                }
            });
        </script>
    </div>
</body>
</html>