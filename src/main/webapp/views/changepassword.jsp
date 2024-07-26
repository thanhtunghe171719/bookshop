<%-- 
    Document   : changepassword
    Created on : Jun 9, 2024, 3:35:41 PM
    Author     : TDG
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Đổi mật khẩu</title>
        <link rel="icon" href="./img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="./vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="./vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="./vendors/linericon/style.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="./vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="./vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="./vendors/nouislider/nouislider.min.css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="./css/style.css">
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>
        <!--================ End Header Menu Area =================-->



        <!--================Login Box Area =================-->
        <section class="login_box_area section-margin">
            <div class="container">
                <div class="row" style="justify-content: center">
                    
                    <div class="col-lg-6">
                        <div class="login_form_inner register_form_inner">
                            <h3>Đổi mật khẩu</h3>
                            <form class="row login_form" action="changepassword" id="register_form"  onsubmit="return validateForm()">
                                <div class="col-md-12 form-group">
                                    <div class="password-container" style="display: flex">
                                        <input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="Mật khẩu cũ" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Mật khẩu cũ'"  onblur="validateOldPassword()">
                                        <button type="button" onclick="togglePassword('oldPassword', this)" style="border: none;background-color: white"><i class="bi bi-eye-slash"></i></button>
                                    </div>
                                    <p  id="oldPasswordError" class="text-danger"></p>
                                </div>
                                <div class="col-md-12 form-group">
                                    <div class="password-container" style="display: flex">
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Mật khẩu mới" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Mật khẩu mới'" onblur="validateNewPassword()">
                                        <button type="button" onclick="togglePassword('newPassword', this)" style="border: none;background-color: white"><i class="bi bi-eye-slash"></i></button>
                                    </div>
                                    <p  id="newPasswordError" class="text-danger"></p>
                                </div>
                                <div class="col-md-12 form-group">
                                    <div class="password-container" style="display: flex">
                                        <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" placeholder="Xác nhận mật khẩu mới" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Xác nhận mật khẩu mới'" onblur="validateConfirmPassword()">
                                        <button type="button" onclick="togglePassword('confirmNewPassword', this)" style="border: none;background-color: white"><i class="bi bi-eye-slash"></i></button>
                                    </div>
                                    <p  id="confirmNewPasswordError" class="text-danger"></p>
                                </div>

                                <div class="col-md-12 form-group">
                                    <button type="submit" name ="submit" value="submit" class="button button-register w-100">Lưu</button>
                                    <p  id="formError" class="text-danger">${notice}</p>
                                    <%--<c:if test="not empty notice">--%>
                                        <!--<p class="text-danger">${notice}</p>-->
                                    <%--</c:if>--%>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================End Login Box Area =================-->



        <!--================ Start footer Area  =================-->	
        <jsp:include page="footer.jsp"/>
        <!--================ End footer Area  =================-->

        <script>
            function togglePassword(inputId, button) {
                var input = document.getElementById(inputId);
                var icon = button.querySelector('i');

                if (input.type === "password") {
                    input.type = "text";
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                } else {
                    input.type = "password";
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                }
            }
            function validateOldPassword() {
                const oldPassword = document.getElementById('oldPassword').value;
                const oldPasswordError = document.getElementById('oldPasswordError');
                oldPasswordError.textContent = '';
                if (!oldPassword) {
                    oldPasswordError.textContent = 'Vui lòng nhập mật khẩu cũ của bạn.';
                    return false;
                } else if (/[\s]/.test(oldPassword)) {
                    oldPasswordError.textContent = 'Không được chứa dấu cách.';
                    return false;
                } else if (oldPassword.length < 8) {
                    oldPasswordError.textContent = 'Phải có ít nhất 8 ký tự.';
                    return false;
                }else if(oldPassword.length > 20){
                    oldPasswordError.textContent = 'Không vượt quá 20 ký tự.';
                    return false;
                }else if(!/[!@#$%^&*(),.?":{}|<>]/.test(oldPassword)){
                    oldPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
                    return false;
                } else if (!/[A-Za-z]/.test(oldPassword)) {
                    oldPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một chữ cái.';
                    return false;
                }else if(!/\d/.test(oldPassword)){
                    oldPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một số.';
                    return false;
                }
                    
                return true;
            }

            function validateNewPassword() {
                const newPassword = document.getElementById('newPassword').value;
                const oldPassword = document.getElementById('oldPassword').value;
                const newPasswordError = document.getElementById('newPasswordError');
                newPasswordError.textContent = '';
                if (!newPassword) {
                    newPasswordError.textContent = 'Vui lòng nhập mật khẩu mới của bạn.';
                    return false;
                } else if (newPassword.length < 8) {
                    newPasswordError.textContent = 'Phải có độ dài ít nhất 8 ký tự.';
                    return false;
                }else if(newPassword.length > 20){
                    newPasswordError.textContent = 'Không vượt quá 20 ký tự.';
                    return false;
                }else if (/[\s]/.test(newPassword)) {
                    newPasswordError.textContent = 'Không được chứa dấu cách.';
                    return false;
                }else if(!/[!@#$%^&*(),.?":{}|<>]/.test(newPassword)){
                    newPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
                    return false;
                } else if (!/[A-Za-z]/.test(newPassword)) {
                    newPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một chữ cái.';
                    return false;
                }else if(!/\d/.test(newPassword)){
                    newPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một số.';
                    return false;
                } else if (newPassword === oldPassword) {
                    newPasswordError.textContent = 'Mật khẩu mới phải khác với Mật khẩu cũ.';
                    return false;
                }
                return true;
            }

            function validateConfirmPassword() {
                const newPassword = document.getElementById('newPassword').value;
                const confirmNewPassword = document.getElementById('confirmNewPassword').value;
                const confirmNewPasswordError = document.getElementById('confirmNewPasswordError');
                confirmNewPasswordError.textContent = '';
                if (!confirmNewPassword) {
                    confirmNewPasswordError.textContent = 'Vui lòng xác nhận mật khẩu mới của bạn.';
                    return false;
                } else if (confirmNewPassword.length < 8) {
                    confirmNewPasswordError.textContent = 'Phải có độ dài ít nhất 8 ký tự.';
                    return false;
                } else if (/[\s]/.test(confirmNewPassword)) {
                    confirmNewPasswordError.textContent = 'Không được chứa dấu cách.';
                    return false;
                } else if(!/[!@#$%^&*(),.?":{}|<>]/.test(confirmNewPassword)){
                    confirmNewPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
                    return false;
                } else if (!/[A-Za-z]/.test(confirmNewPassword)) {
                    confirmNewPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một chữ cái.';
                    return false;
                }else if(!/\d/.test(confirmNewPassword)){
                    confirmNewPasswordError.textContent = 'Mật khẩu phải chứa ít nhất một số.';
                    return false;
                }  else if (newPassword !== confirmNewPassword) {
                    confirmNewPasswordError.textContent = 'Mật khẩu mới và Xác nhận mật khẩu mới không khớp.';
                    return false;
                }
                return true;
            }

            function validateForm() {
                const isOldPasswordValid = validateOldPassword();
                const isNewPasswordValid = validateNewPassword();
                const isConfirmPasswordValid = validateConfirmPassword();

                if (!isOldPasswordValid || !isNewPasswordValid || !isConfirmPasswordValid) {
                    document.getElementById('formError').textContent = 'Vui lòng sửa các lỗi trên và thử lại.';
                    return false;
                }
                return true;
            }

            document.getElementById('oldPassword').addEventListener('blur', validateOldPassword);
            document.getElementById('newPassword').addEventListener('blur', validateNewPassword);
            document.getElementById('confirmNewPassword').addEventListener('blur', validateConfirmPassword);


        </script>

        <script src="./vendors/jquery/jquery-3.2.1.min.js"></script>
        <script src="./vendors/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="./vendors/skrollr.min.js"></script>
        <script src="./vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="./vendors/nice-select/jquery.nice-select.min.js"></script>
        <script src="./vendors/jquery.ajaxchimp.min.js"></script>
        <script src="./vendors/mail-script.js"></script>
        <script src="./js/main.js"></script>
    </body>
</html>
