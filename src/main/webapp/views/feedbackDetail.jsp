<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Feedback List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- DataTables CSS -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container mt-5">
            <h2 class="mb-4">Feedback Detail</h2>

            <table class="table table-bordered">
                <tr>
                    <th style="width: 200px;">Feedback ID</th>
                    <td>${feedback.feedbackId}</td>
                </tr>
                <tr>
                    <th style="width: 200px;">Book Title</th>
                    <td>${feedback.book.title}</td>
                </tr>
                <tr>
                    <th style="width: 200px;">Book Author</th>
                    <td>${feedback.book.author}</td>
                </tr>
                <tr>
                    <th style="width: 200px;">User Fullname</th>
                    <td>${feedback.user.fullname}</td>
                </tr>
                <tr>
                    <th style="width: 200px;">Rating</th>
                    <td>${feedback.rating}</td>
                </tr>
                <tr>
                    <th style="width: 200px;">Comment</th>
                    <td>${feedback.comment}</td>
                </tr>
                <tr>
                    <th>Created At</th>
                    <td>${feedback.createdAt}</td>
                </tr>
            </table>

            <a href="javascript:history.back()" class="btn btn-primary">Back to Feedback List</a>
        </div>
    </body>
</html>
