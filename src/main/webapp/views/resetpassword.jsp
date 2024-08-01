<%-- 
    Document   : resetpassword
    Created on : Jun 14, 2024, 2:13:37 PM
    Author     : TDG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Aroma Shop - reset password</title>
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
                        <div class="login_form_inner" style="padding: 50px 0;">
                            <h2 style="margin-bottom: 20px">Quên Mật Khẩu?</h2>
                            <input type="hidden" name="emailReset" value="${emailReset}">
                            
                            <!--màn hình nhập email-->
                            <c:if test="${indexScreen == 'first'}">
                                <form class="row login_form" action="resetpassword" id="contactForm" >
                                    <p style="text-align: left;padding-left: 15px;padding-bottom: 20px">Điền email gắn với tài khoản của bạn để nhận đường dẫn thay đổi mật khẩu</p>
                                    <div class="col-md-12 form-group">
                                        
                                        <input type="text" class="form-control" id="email" name="emailReset" style="border: 1px #7c3aed solid; border-radius: 15px;" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'">

                                        <input type="hidden" name="service" value="sendEmail">    
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <p style="float: left;color: red">${messageErrorEmail}</p>
                                        <button type="submit" value="submit" class="button button-login w-100">Tiếp Tục</button>
                                        <a href="login">Quay Lại Đăng Nhập</a>
                                    </div>
                                </form>
                            </c:if>

                            <!--màn hình nhập otp-->
                            <c:if test="${indexScreen == 'second'}">
                                <form class="row login_form" action="resetpassword" id="contactForm" >
                                    <p style="text-align: left;padding-left: 15px;padding-bottom: 20px">Điền mã otp đã gửi đến email bạn đã nhập</p>
                                    <div class="col-md-12 form-group">
                                        <input type="text" class="form-control" id="otp" name="otpInput" style="border: 1px #7c3aed solid; border-radius: 15px;" placeholder="OTP" onfocus="this.placeholder = ''" onblur="this.placeholder = 'OTP'">

                                        <!--<input type="hidden" name="service" value="checkOtp">-->    
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <p style="float: left;color: red">${messageEnrrorOtp}</p>
                                        <button type="submit" name="service" value="checkOtp" class="button button-login w-100">Tiếp Tục</button>
                                        <a href="resetpassword">Nhập Lại Email</a>
                                    </div>
                                </form>        
                            </c:if> 

                            <!--màn hình nhập new password-->
                            <c:if test="${indexScreen == 'three'}">
                                <form class="row login_form" action="resetpassword" id="contactForm" onsubmit="return validateForm();">
                                    <p style="text-align: left;padding-left: 15px;padding-bottom: 20px">Điền mật khẩu mới</p>
                                    <div class="col-md-12 form-group">
                                        <div class="password-container" style="display: flex">
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" style="border: 1px #7c3aed solid; border-radius: 15px;" placeholder="Mật Khẩu Mới" onblur="validateNewPassword()">
                                            <button type="button" onclick="togglePassword('newPassword', this)" style="border: none;background-color: white"><i class="bi bi-eye-slash"></i></button>
                                        </div>
                                        <p id="newPasswordResult" style="text-align: left;padding-left: 15px;color: red"></p>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <div class="password-container" style="display: flex">
                                            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" style="border: 1px #7c3aed solid; border-radius: 15px;" placeholder="Xác Nhận Mật Khẩu Mới" onblur="validateConfirmPassword()">
                                            <button type="button" onclick="togglePassword('confirmNewPassword', this)" style="border: none;background-color: white"><i class="bi bi-eye-slash"></i></button>
                                        </div>
                                        <p id="confirmNewPasswordResult" style="text-align: left;padding-left: 15px;color: red"></p>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <p id="buttonResult" style="text-align: left;padding-left: 15px;color: red"></p>
                                        <button type="submit" value="submit" class="button button-login w-100" id="submitButton">Tiếp Tục</button>
                                    </div>
                                    <input type="hidden" name="service" value="updatePassWord">
                                </form>
                            </c:if>

                            <c:if test="${not empty messageUpdate}">
                                <h3 style="margin-top: 150px">${messageUpdate}</h3>     
                                <form class="row login_form" action="login">
                                    <button class="button button-login w-100">Quay Lại Đăng Nhập</button>
                                </form>
                            </c:if>
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

            function validateNewPassword() {
                var newPassword = document.getElementById('newPassword').value.trim();
                var newPasswordResult = document.getElementById('newPasswordResult');
                newPasswordResult.textContent = '';

                if (!newPassword) {
                    newPasswordResult.textContent = 'Vui lòng nhập mật khẩu mới của bạn.';
                    return false;
                } else if (newPassword.length < 8) {
                    newPasswordResult.textContent = 'Phải có độ dài ít nhất 8 ký tự.';
                    return false;
                }else if(newPassword.length > 20){
                    newPasswordResult.textContent = 'Không vượt quá 20 ký tự.';
                    return false;
                } else if (/\s/.test(newPassword)) {
                    newPasswordResult.textContent = 'Không được chứa dấu cách.';
                    return false;
                }else if(!/[!@#$%^&*(),.?":{}|<>]/.test(newPassword)){
                    newPasswordResult.textContent = 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
                    return false;
                } else if (!/[A-Za-z]/.test(newPassword)) {
                    newPasswordResult.textContent = 'Mật khẩu phải chứa ít nhất một chữ cái.';
                    return false;
                }else if(!/\d/.test(newPassword)){
                    newPasswordResult.textContent = 'Mật khẩu phải chứa ít nhất một số.';
                    return false;
                }

                newPasswordResult.innerHTML = '<span style="color: green;">&#10004; Mật khẩu hợp lệ.</span>';
                return true;
            }

            function validateConfirmPassword() {
                var newPassword = document.getElementById('newPassword').value.trim();
                var confirmNewPassword = document.getElementById('confirmNewPassword').value.trim();
                var confirmNewPasswordResult = document.getElementById('confirmNewPasswordResult');
                confirmNewPasswordResult.textContent = '';

                if (!confirmNewPassword) {
                    confirmNewPasswordResult.textContent = 'Vui lòng xác nhận mật khẩu mới của bạn.';
                    return false;
                } else if (newPassword !== confirmNewPassword) {
                    confirmNewPasswordResult.textContent = 'Mật khẩu không phù hợp.';
                    return false;
                }

                confirmNewPasswordResult.innerHTML = '<span style="color: green;">&#10004; Mật khẩu trùng khớp.</span>';
                return true;
            }

function validateForm() {
    var isNewPasswordValid = validateNewPassword();
    var isConfirmPasswordValid = validateConfirmPassword();

      if (!isNewPasswordValid || !isConfirmPasswordValid) {
        document.getElementById('buttonResult').textContent = 'Vui lòng sửa các lỗi trên và thử lại.';
        return false;
      }

      return true;
      
}


            document.getElementById('newPassword').addEventListener('blur', validateNewPassword);
            document.getElementById('confirmNewPassword').addEventListener('blur', validateConfirmPassword);


        </script>

        <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
        <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="vendors/skrollr.min.js"></script>
        <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
        <script src="vendors/jquery.ajaxchimp.min.js"></script>
        <script src="vendors/mail-script.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>