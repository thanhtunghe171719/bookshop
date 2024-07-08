<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Categories List</title>
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
            <h2 class="mb-4">Categories List</h2>
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
            <form method="get" action="marketing-category" class="form-inline mb-4">
                <input type="hidden" name="action" value="">
                <div class="form-group mx-sm-3 mb-2">
                    <label for="name" class="sr-only">Search</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Search" value="${name}">
                </div>
                <button type="submit" class="btn btn-primary mb-2">Filter</button>
            </form>
            <a href="admin-category?action=add" class="btn btn-success btn-sm mb-2">Add new </a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Create At</th>
                        <th>Updated At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${requestScope.data}">
                        <c:set var="categoryId" value="${c.categoryId}"/>
                        <tr>
                            <td>${categoryId}</td>
                            <td><img src="${c.image}" alt="${c.categoryName}" style="width:50px;height:50px;"></td>
                            <td>${c.categoryName}</td>
                            <td><fmt:formatDate value="${c.create_at}" pattern="yyyy-MM-dd" /></td>
                            <td><fmt:formatDate value="${c.updated_at}" pattern="yyyy-MM-dd" /></td>
                            <td>
                                <a href="marketing-category?action=view&id=${category.categoryId}" class="btn btn-info btn-sm">View</a>
                                <a href="marketing-category?action=edit&id=${category.categoryId}" class="btn btn-warning btn-sm">Edit</a>
                                <a onclick="return confirm('Are you sure to delete this category?')" href="marketing-category?action=delete&id=${category.categoryId}" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item"><a class="page-link" href="marketing-category?page=${currentPage - 1}&name=${name}">Previous</a></li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="marketing-category?page=${i}&name=${name}">${i}</a></li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item"><a class="page-link" href="marketing-category?page=${currentPage + 1}&name=${name}">Next</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>
