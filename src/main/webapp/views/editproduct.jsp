<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Edit Book</h2>

        <c:if test="${not empty errors}">
            <div class="alert alert-danger" role="alert">
                <ul>
                    <c:forEach var="error" items="${errors.values()}">
                        <li>${error}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <form action="marketing-product?action=edit" method="post">
            <input type="hidden" name="id" value="${book.bookId}">
            <div class="form-group">
                <label>Title:</label>
                <input type="text" name="title" class="form-control" value="${book.title}">
            </div>
            <div class="form-group">
                <label>Author:</label>
                <input type="text" name="author" class="form-control" value="${book.author}">
            </div>
            <div class="form-group">
                <label>Image URL:</label>
                <input type="text" name="image" class="form-control" value="${book.image}">
            </div>
            <div class="form-group">
                <label>Category:</label>
                <select name="category_id" class="form-control">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}" ${category.categoryId == book.categoryId ? 'selected' : ''}>${category.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Publishing House:</label>
                <input type="text" name="publishing_house" class="form-control" value="${book.publishingHouse}">
            </div>
            <div class="form-group">
                <label>Published Year:</label>
                <input type="number" name="published_year" class="form-control" value="${book.publishedYear}">
            </div>
            <div class="form-group">
                <label>Size:</label>
                <input type="text" name="size" class="form-control" value="${book.size}">
            </div>
            <div class="form-group">
                <label>Weight:</label>
                <input type="text" name="weight" class="form-control" value="${book.weight}">
            </div>
            <div class="form-group">
                <label>Summary:</label>
                <textarea name="summary" class="form-control">${book.summary}</textarea>
            </div>
            <div class="form-group">
                <label>Price:</label>
                <input type="number" step="0.01" name="price" class="form-control" value="${book.price}">
            </div>
            <div class="form-group">
                <label>Discount:</label>
                <input type="number" name="discount" class="form-control" value="${book.discount}">
            </div>
            <div class="form-group">
                <label>Stock:</label>
                <input type="number" name="stock" class="form-control" value="${book.stock}">
            </div>
            <div class="form-group">
                <label>Format:</label>
                <input type="text" name="format" class="form-control" value="${book.format}">
            </div>
            <div class="form-group">
                <label>Pages:</label>
                <input type="number" name="pages" class="form-control" value="${book.pages}">
            </div>
            <input type="submit" value="Update Book" class="btn btn-primary">
        </form>
    </div>
</body>
</html>