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
        <h2 class="mb-4">Feedback List</h2>
        <c:if test="${param.error != null}">
            <div class="alert alert-danger" role="alert">
                ${param.error}
            </div>
        </c:if>
        <c:if test="${param.success != null}">
            <div class="alert alert-success" role="alert">
                ${param.success}
            </div>
        </c:if>
        <div class="container mt-5">
            <table class="table table-bordered" id="feedbackTable">
                <thead class="thead-dark">
                    <tr>
                        <th>Feedback ID</th>
                        <th>User Fullname</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Created At</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="feedback" items="${feedbackList}">
                        <tr>
                            <td>${feedback.feedbackId}</td>
                            <td>${feedback.user.fullname}</td>
                            <td>${feedback.rating}</td>
                            <td>${feedback.comment}</td>
                            <td>${feedback.createdAt}</td>
                            <td>
                                <a href="manage-feedback?feedbackId=${feedback.feedbackId}&action=detail" class="btn btn-info">View Details</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <a href="javascript:history.back()" class="btn btn-primary">Back to Order List</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#feedbackTable').DataTable();
        });
    </script>
</body>
</html>
