<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category Detail</title>
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
<div class="container mt-5">
    <h2 class="mb-4">Category Details</h2>

    <table class="table table-bordered">
        <tr>
            <th>ID</th>
            <td>${category.categoryId}</td>
        </tr>
        <tr>
            <th>Category Name</th>
            <td>${category.categoryName}</td>
        </tr>
        
        <tr>
            <th>Image</th>
            <td><img src="${category.image}" alt="Category Image" style="width:100px;height:100px;"></td>
        </tr>        
    </table>
    <a href="admin-category" class="btn btn-primary">Back to Category List</a>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>