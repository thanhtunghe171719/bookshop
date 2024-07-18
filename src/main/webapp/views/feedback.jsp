<%-- 
    Document   : history-order
    Created on : Jul 15, 2024, 1:16:38 AM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title></title>
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
        <style>
            .star-rating {
                direction: rtl;
                display: inline-block;
            }

            .star-rating input[type="radio"] {
                display: none;
            }

            .star-rating label {
                font-size: 2rem;
                color: #ddd;
                cursor: pointer;
            }

            .star-rating label:hover,
            .star-rating label:hover ~ label,
            .star-rating input[type="radio"]:checked ~ label {
                color: #f5b301;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container mt-5">
            <h2 class="mb-4">Order List</h2>
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
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Book Title</th>
                        <th>Book Author</th>
                        <th>Book Image</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${orderItem.book.title}</td>
                        <td>${orderItem.book.author}</td>
                        <td><img src="${orderItem.book.image}" alt="Book Image" width="100"></td>
                        <td>${orderItem.quantity}</td>
                        <td>${orderItem.book.price}</td>
                    </tr>
                </tbody>
                <form action="feedback" method="post">
                    <input type="hidden" name="orderItemId" value="${orderItem.orderItemId}">
                    <input type="hidden" name="feedbackId" value="${feedback != null ? feedback.feedbackId : ""}">
                    <input type="hidden" name="action" value="${feedback != null ? "edit" : "add"}">
                    <div class="form-group">
                        <label for="rating">Rating:</label><br>
                        <div class="star-rating">
                            <input ${feedback.rating == 5 ? "checked" : ""} type="radio" name="rating" id="rating-5" value="5"><label for="rating-5">&#9733;</label>
                            <input ${feedback.rating == 4 ? "checked" : ""} type="radio" name="rating" id="rating-4" value="4"><label for="rating-4">&#9733;</label>
                            <input ${feedback.rating == 3 ? "checked" : ""} type="radio" name="rating" id="rating-3" value="3"><label for="rating-3">&#9733;</label>
                            <input ${feedback.rating == 2 ? "checked" : ""} type="radio" name="rating" id="rating-2" value="2"><label for="rating-2">&#9733;</label>
                            <input ${feedback.rating == 1 ? "checked" : ""} type="radio" name="rating" id="rating-1" value="1"><label for="rating-1">&#9733;</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="comment">Comment:</label>
                        <textarea name="comment" id="comment" class="form-control" rows="3" required>${feedback.comment}</textarea>
                    </div>
                    <button type="submit" class="btn btn-sm btn-success">Submit Feedback</button>
                </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>
            const stars = document.querySelectorAll('.star-rating label');
            stars.forEach(star => {
                star.addEventListener('mouseover', function () {
                    this.classList.add('hover');
                    let previous = this.previousElementSibling;
                    while (previous) {
                        previous.classList.add('hover');
                        previous = previous.previousElementSibling;
                    }
                });

                star.addEventListener('mouseout', function () {
                    stars.forEach(s => s.classList.remove('hover'));
                });

                star.addEventListener('click', function () {
                    stars.forEach(s => s.classList.remove('checked'));
                    this.classList.add('checked');
                    let previous = this.previousElementSibling;
                    while (previous) {
                        previous.classList.add('checked');
                        previous = previous.previousElementSibling;
                    }
                });
            });
        </script>
    </body>
</html>


