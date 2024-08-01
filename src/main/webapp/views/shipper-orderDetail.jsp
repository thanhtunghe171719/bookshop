

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
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container mt-5">
            <h2 class="mb-4">Order Detail</h2>
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
            <div class="container">
                <table class="table table-bordered">
                    <tr>
                        <th style="width: 200px;">Order ID</th>
                        <td>${order.orderId}</td>
                    </tr>
                    <tr>
                        <th style="width: 200px;">Tên</th>
                        <td>${order.user.fullname}</td>
                    </tr>
                    <tr>
                        <th style="width: 200px;">Email</th>
                        <td>${order.user.email}</td>
                    </tr>
                    <tr>
                        <th style="width: 200px;">Phone</th>
                        <td>${order.user.phone}</td>
                    </tr>
                    <tr>
                        <th style="width: 200px;">Địa chỉ</th>
                         <td>${order.user.address}</td>
                    </tr>
                    <tr>
                        <th>Tổng giá tiền</th>
                        <td><fmt:formatNumber value="${order.total}" type="number" minFractionDigits="3" maxFractionDigits="3" /> vnd</td>
                    </tr>
                    <tr>
                        <th>Trạng thái</th>
                        <td>${order.orderStatus}</td>
                    </tr>
                    <tr>
                        <th>Ngày đặt</th>
                        <td>${order.orderDate}</td>
                    </tr>
                    <tr>
                        <th>Ngày cập nhật</th>
                        <td>${order.updatedAt}</td>
                    </tr>
                </table>
                <c:if test="${order.statusId == 3}">
                    <div class="card" style="padding: 10px">
                        <form action="update-order-status" method="post">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <div class="form-group">
                                <label for="status">Lựa chọn trạng thái:</label>
                                <select name="status" id="status" class="form-control">
                                    <c:forEach var="status" items="${orderStatuses}">
                                        <c:if test="${status.orderStatusId >= 3}">
                                            <option value="${status.orderStatusId}" 
                                                    ${status.orderStatusId == order.statusId ? 'selected' : ''}>
                                                ${status.orderStatus}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Cập nhật trạng thái</button>
                        </form>
                    </div>
                </c:if>
                <h2>Order Items</h2>
                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Order Item ID</th>
                            <th>Tên sách</th>
                            <th>Tác giả</th>
                            <th>Ảnh</th>
                            <th>Số lượng</th>
                            <th>Giá</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="orderItem" items="${orderItems}">
                            <tr>
                                <td>${orderItem.orderItemId}</td>
                                <td>${orderItem.book.title}</td>
                                <td>${orderItem.book.author}</td>
                                <td><img src="${orderItem.book.image}" alt="Book Image" style="max-width: 100px;"></td>
                                <td>${orderItem.quantity}</td>
                                <td><fmt:formatNumber value="${orderItem.book.price}" type="number" minFractionDigits="3" maxFractionDigits="3" /> vnd</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <a href="manage-shipper" class="btn btn-primary">Trở về Order List</a>
            </div>
            <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>

