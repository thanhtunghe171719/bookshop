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
  
  <!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>ĐỔI MẬT KHẨU</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">ĐỔI MẬT KHẨU</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<div class="hover">
							<h4>Already have an account?</h4>
							<p>There are advances being made in science and technology everyday, and a good example of this is the</p>
							<a class="button button-account" href="login.html">Login Now</a>
						</div>
					</div>
				</div>
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
                                                                <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="mật khẩu mới" onfocus="this.placeholder = ''" onblur="this.placeholder = 'mật khẩu mới'" onblur="validateNewPassword()">
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
                                                                <p  id="formError" class="text-danger"></p>
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
      } else if (!/^[A-Z]/.test(oldPassword)) {
        oldPasswordError.textContent = 'Phải bắt đầu bằng chữ in hoa.';
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
      } else if (/[\s]/.test(newPassword)) {
        newPasswordError.textContent = 'Không được chứa dấu cách.';
        return false;
      } else if (!/^[A-Z]/.test(newPassword)) {
        newPasswordError.textContent = 'Phải bắt đầu bằng chữ in hoa.';
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
      } else if (!/^[A-Z]/.test(confirmNewPassword)) {
        confirmNewPasswordError.textContent = 'Phải bắt đầu bằng chữ in hoa.';
        return false;
      } else if (newPassword !== confirmNewPassword) {
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
      }else{
          document.getElementById('formError').textContent = 'Đổi mật khẩu thành công.';
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
