<%-- 
    Document   : editprofile
    Created on : Jun 10, 2024, 11:08:54 PM
    Author     : kobietkolam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Aroma Shop - Category</title>
        <link rel="icon" href="img/Fevicon.png" type="image/png">
        <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
        <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">

        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <!--================ Start Header Menu Area =================-->
        <jsp:include page="header.jsp"/>

        <!--================ End Header Menu Area =================-->
        <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
            <h5 class="mb-0 pb-2">Schedule Timing</h5>
            <div class="rounded shadow mt-4">
                <div class="p-4 border-bottom">
                    <h5 class="mb-0">Personal Information :</h5>
                </div>

                <div class="p-4 border-bottom">
                    <div class="row align-items-center">
                        <div class="col-lg-2 col-md-4">
                            <img src="../assets/images/doctors/01.jpg" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                        </div><!--end col-->

                        <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                            <h5 class="">Upload your picture</h5>
                            <p class="text-muted mb-0">For best results, use an image at least 256px by 256px in either .jpg or .png format</p>
                        </div><!--end col-->

                        <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">                                        
                            <a href="#" class="btn btn-primary">Upload</a>
                            <a href="#" class="btn btn-soft-primary ms-2">Remove</a>
                        </div><!--end col-->
                    </div><!--end row-->
                </div>

                <div class="p-4">
                    <form>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">First Name</label>
                                    <input name="name" id="name" type="text" class="form-control" placeholder="First Name :">
                                </div>
                            </div><!--end col-->

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Last Name</label>
                                    <input name="name" id="name2" type="text" class="form-control" placeholder="Last Name :">
                                </div>
                            </div><!--end col-->

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Your Email</label>
                                    <input name="email" id="email" type="email" class="form-control" placeholder="Your email :">
                                </div> 
                            </div><!--end col-->

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Phone no.</label>
                                    <input name="number" id="number" type="text" class="form-control" placeholder="Phone no. :">
                                </div>                                                                               
                            </div><!--end col-->

                            <div class="col-md-12">
                                <div class="mb-3">
                                    <label class="form-label">Your Bio Here</label>
                                    <textarea name="comments" id="comments" rows="4" class="form-control" placeholder="Bio :"></textarea>
                                </div>
                            </div>
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-sm-12">
                                <input type="submit" id="submit" name="send" class="btn btn-primary" value="Save changes">
                            </div><!--end col-->
                        </div><!--end row-->
                    </form><!--end form--> 
                </div>
            </div>


            <!--================ Start footer Area  =================-->	
            <jsp:include page="footer.jsp"/>
            <!--================ End footer Area  =================-->



            <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
            <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
            <script src="vendors/skrollr.min.js"></script>
            <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
            <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
            <script src="vendors/nouislider/nouislider.min.js"></script>
            <script src="vendors/jquery.ajaxchimp.min.js"></script>
            <script src="vendors/mail-script.js"></script>
            <script src="js/main.js"></script>
    </body>
</html>
