<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Register</title>
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
        <jsp:include page = "header.jsp"/>

        <!--================Login Box Area =================-->
        <section class="login_box_area section-margin">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="login_box_img">
                            <div class="hover">
                                <h4>Bạn đã có tài khoản?</h4>
                                <p>Hãy nhấn vào đây để đăng nhập</p>
                                <a class="button button-account" href="login">Đăng nhập</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="login_form_inner register_form_inner">
                            <h3>Tạo tài khoản</h3>
                            <form class="row login_form" action="register" id="post" method="post" onsubmit="return validateForm()">
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger" role="alert">
                                        ${errorMessage}
                                    </div>
                                </c:if>
                                <div>${error}</div>
                                <div class="col-md-12 form-group">
                                    <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Họ và tên" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Họ và tên'">
                                    <div id="fullnameError" class="error-message2"></div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="tel" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Số điện thoại'">
                                    <div id="phoneError" class="error-message2"></div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="text" class="form-control" id="address" name="address" placeholder="Địa chỉ" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Địa chỉ'">
                                    <div id="addressError" class="error-message2"></div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <select name="gender" id="gender">
                                        <option value="Nam">Nam</option>
                                        <option value="Nữ">Nữ</option>
                                    </select>
                                    <div id="genderError" class="error-message2"></div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'">
                                    <div id="emailError" class="error-message2"></div>
                                </div>
                                <div class="col-md-12 form-group">                               
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Mật khẩu'">
                                    <i class="bi bi-eye-slash" id="togglePassword" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i>
                                    <div id="passwordError" class="error-message2"></div>
                                </div>  
                                <div class="col-md-12 form-group">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Xác nhận mật khẩu'">
                                    <i class="bi bi-eye-slash" id="toggleConfirmPassword" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i>
                                    <div id="confirmPasswordError" class="error-message2"></div>
                                </div>




                                <!--                                <div class="col-md-12 form-group">
                                                                    <div class="creat_account">
                                                                        <input type="checkbox" id="f-option2" name="selector">
                                                                        <label for="f-option2">Keep me logged in</label>
                                                                    </div>
                                                                </div>-->
                                <div class="col-md-12 form-group">
                                    <button type="submit" value="submit" class="button button-register w-100">Đăng ký</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================End Login Box Area =================-->
        <jsp:include page="footer.jsp"/>
        <style>
            .error-message2 {
                color: red;
                font-size: 12px;
                margin-top: 5px;
            }
        </style>


        <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
        <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="vendors/skrollr.min.js"></script>
        <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
        <script src="vendors/jquery.ajaxchimp.min.js"></script>
        <script src="vendors/mail-script.js"></script>
        <script src="js/main.js"></script>
        <script>
        function validateForm() {
            let isValid = true;

            let fullname = document.getElementById('fullname').value.trim();
            let phone = document.getElementById('phone').value.trim();
            let address = document.getElementById('address').value.trim();
            let email = document.getElementById('email').value.trim();
            let password = document.getElementById('password').value;
            let gender = document.getElementById('gender').value.trim();
            let confirmPassword = document.getElementById('confirmPassword').value;

            // Reset error messages
            document.getElementById('fullnameError').innerText = '';
            document.getElementById('phoneError').innerText = '';
            document.getElementById('addressError').innerText = '';
            document.getElementById('emailError').innerText = '';
            document.getElementById('passwordError').innerText = '';
            document.getElementById('genderError').innerText = '';
            document.getElementById('confirmPasswordError').innerText = '';


            if (fullname === '') {
                document.getElementById('fullnameError').innerText = 'Họ và tên không được để trống';
                isValid = false;
            }
            if (phone === '') {
                document.getElementById('phoneError').innerText = 'Số điện thoại không được để trống';
                isValid = false;
            } else if (!/^\d+$/.test(phone)) {
                document.getElementById('phoneError').innerText = 'Số điện thoại chỉ chứa số';
                isValid = false;
            } else if (phone.length > 10) {
                document.getElementById('phoneError').innerText = 'Số điện thoại chỉ chứa tối đa 10 số';
                isValid = false;
            }
            if (address === '') {
                document.getElementById('addressError').innerText = 'Địa chỉ không được để trống';
                isValid = false;
            }
            if (email === '') {
                document.getElementById('emailError').innerText = 'Email không được để trống';
                isValid = false;
            } else if (!/\S+@\S+\.\S+/.test(email)) {
                document.getElementById('emailError').innerText = 'Email không đúng định dạng';
                isValid = false;
            }
            if (password === '') {
                document.getElementById('passwordError').innerText = 'Mật khẩu không được để trống';
                isValid = false;
            } else if (password.length < 8) {
                document.getElementById('passwordError').innerText = 'Mật khẩu phải chứa ít nhất 8 ký tự';
                isValid = false;
            } else if (!/[A-Za-z]/.test(password)) {
                document.getElementById('passwordError').innerText = 'Mật khẩu phải chứa ít nhất một chữ cái';
                isValid = false;
            } else if (!/\d/.test(password)) {
                document.getElementById('passwordError').innerText = 'Mật khẩu phải chứa ít nhất một số';
                isValid = false;
            } else if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                document.getElementById('passwordError').innerText = 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt';
                isValid = false;
            }
            if (gender === '') {
                document.getElementById('genderError').innerText = 'Giới tính không được để trống';
                isValid = false;
            } else if (gender !== 'Nam' && gender !== 'nam' && gender !== 'nữ' && gender !== 'Nữ' ) {
                document.getElementById('genderError').innerText = 'Giới tính chỉ có thể là "Nam" hoặc "Nữ"';
                isValid = false;
            }
            if (confirmPassword === '') {
                document.getElementById('confirmPasswordError').innerText = 'Xác nhận mật khẩu không được để trống';
                isValid = false;
            } else if (confirmPassword !== password) {
                document.getElementById('confirmPasswordError').innerText = 'Mật khẩu xác nhận không khớp';
                isValid = false;
            }
            return isValid;
        }
        </script>
        <script>
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#password');

            togglePassword.addEventListener('click', function (e) {
                // Toggle the type attribute
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                // Toggle the eye / eye slash icon
                this.classList.toggle('bi-eye');
                this.classList.toggle('bi-eye-slash');
            });
            const toggleConfirmPassword = document.querySelector('#toggleConfirmPassword');
            const confirmPassword = document.querySelector('#confirmPassword');

            toggleConfirmPassword.addEventListener('click', function (e) {
                // Toggle the type attribute
                const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPassword.setAttribute('type', type);
                // Toggle the eye / eye slash icon
                this.classList.toggle('bi-eye');
                this.classList.toggle('bi-eye-slash');
            });
        </script>

    </body>
</html>
