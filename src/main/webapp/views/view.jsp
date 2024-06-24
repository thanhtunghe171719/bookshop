<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Detail</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
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
            <th>Title</th>
            <td>${book.title}</td>
        </tr>
        <tr>
            <th>Author</th>
            <td>${book.author}</td>
        </tr>
        <tr>
            <th>Image</th>
            <td><img src="${book.image}" alt="Book Image" style="width:100px;height:100px;"></td>
        </tr>
        <tr>
            <th>Category</th>
            <td>${category.categoryName}</td>
        </tr>
        <tr>
            <th>Publishing House</th>
            <td>${book.publishingHouse}</td>
        </tr>
        <tr>
            <th>Published Year</th>
            <td>${book.publishedYear}</td>
        </tr>
        <tr>
            <th>Size</th>
            <td>${book.size}</td>
        </tr>
        <tr>
            <th>Weight</th>
            <td>${book.weight}</td>
        </tr>
        <tr>
            <th>Summary</th>
            <td>${book.summary}</td>
        </tr>
        <tr>
            <th>Price</th>
            <td>${book.price}vnd</td>
        </tr>
        <tr>
            <th>Rating</th>
            <td><fmt:formatNumber value="${book.price}" type="currency" currencySymbol="" pattern="#,##"/> vnd</td>

        </tr>
        <tr>
            <th>Discount</th>
            <td>${book.discount}%</td>
        </tr>
        <tr>
            <th>Stock</th>
            <td>${book.stock}</td>
        </tr>
        <tr>
            <th>Created At</th>
            <td>${book.createdAt}</td>
        </tr>
        <tr>
            <th>Updated At</th>
            <td>${book.updatedAt}</td>
        </tr>
        <tr>
            <th>Format</th>
            <td>${book.format}</td>
        </tr>
        <tr>
            <th>Pages</th>
            <td>${book.pages}</td>
        </tr>
    </table>

    <a href="marketing-product" class="btn btn-primary">Back to Book List</a>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
