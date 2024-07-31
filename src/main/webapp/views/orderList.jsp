<%-- 
    Document   : orderList
    Created on : Jul 15, 2024, 12:25:59 AM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="getUserAsssin" class="dal.OrderDAO" />
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css" rel="stylesheet">
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
            <div class="row mb-4">
                <div class="col-md-4">
                    <label for="min-date">From Date:</label>
                    <input type="text" id="min-date" class="form-control" placeholder="yyyy-mm-dd">
                </div>
                <div class="col-md-4">
                    <label for="max-date">To Date:</label>
                    <input type="text" id="max-date" class="form-control" placeholder="yyyy-mm-dd">
                </div>
            </div>

            <table id="orderTable" class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>No.</th>
                        <th>Tổng giá tiền</th>
                        <th>Trạng thái đơn hàng</th>
                        <th>Ngày đặt hàng</th>
                        <th>Ngày cập nhật</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Tên khách hàng</th>
                        <th>Giới tính</th>
                        <th>Địa chỉ</th>
                        <th>Shipper</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}" varStatus="index">
                        <c:set value="${getUserAsssin.getAssignedShipForOrder(order.orderId)}" var="shipM"/>
                        <tr>
                            <td>${index.index + 1}</td>
                            <td><fmt:formatNumber value="${order.total}" type="number" minFractionDigits="3" maxFractionDigits="3" /></td>
                            <td>${order.orderStatus}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.updatedAt}</td>
                            <td>${order.user.email}</td>
                            <td>${order.user.phone}</td>
                            <td>${order.user.fullname}</td>
                            <td>${order.user.gender}</td>
                            <td>${order.user.address}</td>
                            <td>
                                ${shipM != null ? shipM.shipper.fullname : ""}
                            </td>
                            <td>
                                <a class="btn btn-info" href="manage-order-sale?action=view&orderId=${order.orderId}">View Detail</a>
                                <c:if test="${shipM == null}">
                                    <button type="button" class="btn btn-primary" onclick="showAssignSaleModal(${order.orderId})">Assign</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="modal fade" id="selectSaleModal" tabindex="-1" aria-labelledby="selectSaleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="selectSaleModalLabel">Select shipper Representative</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="selectSaleForm" method="post" action="update-ship-manage">
                            <input type="hidden" name="orderId" id="orderId" value="">
                            <div class="mb-3">
                                <label for="saleSelect" class="form-label">Shipper Representative</label>
                                <select class="form-select" id="saleSelect" name="shipId" required>
                                    <c:forEach var="sale" items="${users}">
                                        <option value="${sale.userId}">${sale.fullname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Assign</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/datetime/1.1.1/js/dataTables.dateTime.min.js"></script>
        <link href="https://cdn.datatables.net/datetime/1.1.1/css/dataTables.dateTime.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                     function showAssignSaleModal(orderId) {
                                         document.getElementById("orderId").value = orderId;
                                         $('#selectSaleModal').modal('show');
                                     }
        </script>
        <script>
            $(document).ready(function () {
                var minDate, maxDate;
                $.fn.dataTable.ext.search.push(
                        function (settings, data, dataIndex) {
                            var min = minDate.val();
                            var max = maxDate.val();
                            var date = new Date(data[3]);

                            if (
                                    (min === null && max === null) ||
                                    (min === null && date <= max) ||
                                    (min <= date && max === null) ||
                                    (min <= date && date <= max)
                                    ) {
                                return true;
                            }
                            return false;
                        }
                );

                minDate = new DateTime($('#min-date'), {
                    format: 'YYYY-MM-DD'
                });
                maxDate = new DateTime($('#max-date'), {
                    format: 'YYYY-MM-DD'
                });

                var table = $('#orderTable').DataTable();

                $('#min-date, #max-date').on('change', function () {
                    table.draw();
                });
            });
        </script>
    </body>
</html>

