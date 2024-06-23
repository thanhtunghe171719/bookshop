<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>
    <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Shop Book - Home</title>
	<link rel="icon" href="./img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="./vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="./vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="./vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="./vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="./vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="./vendors/owl-carousel/owl.carousel.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
  <link rel="stylesheet" href="./css/style.css">
</head>
<body>
    <div class="container">
        <h2>Edit Category</h2>

        <c:if test="${not empty errors}">
            <div class="alert alert-danger" role="alert">
                <ul>
                    <c:forEach var="error" items="${errors.values()}">
                        <li>${error}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>

        <form action="admin-category?action=edit" method="post">
            <input type="hidden" name="id" value="${category.categoryId}">
            <div class="form-group">
                <label>Category Name:</label>
                <input type="text" name="title" class="form-control" value="${category.categoryName}">
            </div>
            
            <div class="form-group">
                <label>Image URL:</label>
                <input type="text" name="image" class="form-control" value="${category.image}">
            </div>
            <input type="submit" value="Update Category" class="btn btn-primary">
        </form>
    </div>
</body>
</html>