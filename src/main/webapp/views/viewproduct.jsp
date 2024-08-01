<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Detail</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
        font-family: 'Roboto', sans-serif;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Book Details</h2>

    <table class="table table-bordered">
        <tr>
            <th>ID</th>
            <td>${book.bookId}</td>
        </tr>
        <tr>
            <th>Tên sách</th>
            <td>${book.title}</td>
        </tr>
        <tr>
            <th>Tác giả</th>
            <td>${book.author}</td>
        </tr>
        <tr>
            <th>Ảnh</th>
            <td><img src="${book.image}" alt="Book Image" style="width:100px;height:100px;"></td>
        </tr>
        <tr>
            <th>Thể loại</th>
            <td>${category.categoryName}</td>
        </tr>
        <tr>
            <th>Nhà xuất bản</th>
            <td>${book.publishingHouse}</td>
        </tr>
        <tr>
            <th>Năm xuất bản</th>
            <td>${book.publishedYear}</td>
        </tr>
        <tr>
            <th>Kích thước</th>
            <td>${book.size}</td>
        </tr>
        <tr>
            <th>Cân nặng</th>
            <td>${book.weight}</td>
        </tr>
        <tr>
            <th>Tóm tắt</th>
            <td>${book.summary}</td>
        </tr>
        <tr>
            <th>Giá</th>
            <td><fmt:formatNumber value="${book.price}" type="number" minFractionDigits="3" maxFractionDigits="3" /> vnd</td>
        </tr>
        <tr>
            <th>Đánh giá</th>
            <td>${book.rating}</td>
        </tr>
        <tr>
            <th>Discount</th>
            <td>${book.discount}%</td>
        </tr>
        <tr>
            <th>Số lượng</th>
            <td>${book.stock}</td>
        </tr>
        <tr>
            <th>Ngày tạo</th>
            <td>${book.createdAt}</td>
        </tr>
        <tr>
            <th>Ngày cập nhật</th>
            <td>${book.updatedAt}</td>
        </tr>
        <tr>
            <th>Hình thức</th>
            <td>${book.format}</td>
        </tr>
        <tr>
            <th>Số trang</th>
            <td>${book.pages}</td>
        </tr>
    </table>

    <a href="marketing-product" class="btn btn-primary">Trở về Book List</a>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>