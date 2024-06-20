<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Book</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Add New Book</h2>
        <c:if test="${not empty errors}">
            <div class="alert alert-danger" role="alert">
                <ul>
                    <c:forEach var="error" items="${errors.values()}">
                        <li>${error}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        <form action="marketing-product?action=add" method="post">
            <div class="form-group">
                <label>Title:</label>
                <input type="text" name="title" class="form-control" value="${formData['title'][0]}">
            </div>
            <div class="form-group">
                <label>Author:</label>
                <input type="text" name="author" class="form-control" value="${formData['author'][0]}">
            </div>
            <div class="form-group">
                <label>Image URL:</label>
                <input type="text" name="image" class="form-control" value="${formData['image'][0]}">
            </div>
            <div class="form-group">
                <label>Category:</label>
                <select name="category_id" class="form-control">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}" ${category.categoryId == param.categoryId ? 'selected' : ''}>${category.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Publishing House:</label>
                <input type="text" name="publishing_house" class="form-control" value="${formData['publishing_house'][0]}">
            </div>
            <div class="form-group">
                <label>Published Year:</label>
                <input type="number" name="published_year" class="form-control" value="${formData['published_year'][0]}">
            </div>
            <div class="form-group">
                <label>Size:</label>
                <input type="text" name="size" class="form-control" value="${formData['size'][0]}">
            </div>
            <div class="form-group">
                <label>Weight:</label>
                <input type="text" name="weight" class="form-control" value="${formData['weight'][0]}">
            </div>
            <div class="form-group">
                <label>Summary:</label>
                <textarea name="summary" class="form-control">${formData['summary'][0]}</textarea>
            </div>
            <div class="form-group">
                <label>Price:</label>
                <input type="number" step="0.01" name="price" class="form-control" value="${formData['price'][0]}">
            </div>
            <div class="form-group">
                <label>Discount:</label>
                <input type="number" name="discount" class="form-control" value="${formData['discount'][0]}">
            </div>
            <div class="form-group">
                <label>Stock:</label>
                <input type="number" name="stock" class="form-control" value="${formData['stock'][0]}">
            </div>
            <div class="form-group">
                <label>Format:</label>
                <input type="text" name="format" class="form-control" value="${formData['format'][0]}">
            </div>
            <div class="form-group">
                <label>Pages:</label>
                <input type="number" name="pages" class="form-control" value="${formData['pages'][0]}">
            </div>
            <input type="submit" value="Add Book" class="btn btn-primary">
        </form>
    </div>
</body>
</html>