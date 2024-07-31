<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <title style="font-family: 'Roboto', sans-serif;">Books List</title>
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
            body {
                font-family: 'Roboto', sans-serif;
            }
        </style>


    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container mt-5">
            <h2 class="mb-4">Books List</h2>
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
            <form method="get" action="marketing-product" class="form-inline mb-4">
                <input type="hidden" name="action" value="">
                <div class="form-group mx-sm-3 mb-2">
                    <label for="title" class="sr-only">Tìm kiếm</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="Search" value="${title}">
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="category">Thể loại</label>
                    <select class="form-control" id="category" name="category">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categoriesAll}">
                            <option value="${cat.categoryId}" ${cat.categoryId == category ? "selected" : ""}>${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="sortTitle">Sắp xếp theo tên</label>
                    <select class="form-control" id="sortTitle" name="sortTitle">
                        <option value="" ${sortTitle == "" ? "selected" : ""}>--Default--</option>
                        <option value="desc" ${sortTitle == "desc" ? "selected" : ""}>Desc</option>
                        <option value="asc" ${sortTitle == "asc" ? "selected" : ""}>Asc</option>
                    </select>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="sortListPrice">Sắp xếp theo giá</label>
                    <select class="form-control" id="sortListPrice" name="sortListPrice">
                        <option value="" ${sortListPrice == "" ? "selected" : ""}>--Default--</option>
                        <option value="desc" ${sortListPrice == "desc" ? "selected" : ""}>Desc</option>
                        <option value="asc" ${sortListPrice == "asc" ? "selected" : ""}>Asc</option>
                    </select>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="sortPriceSale">Sắp xếp theo discount</label>
                    <select class="form-control" id="sortPriceSale" name="sortPriceSale">
                        <option value="" ${sortPriceSale == "" ? "selected" : ""}>--Default--</option>
                        <option value="desc" ${sortPriceSale == "desc" ? "selected" : ""}>Desc</option>
                        <option value="asc" ${sortPriceSale == "asc" ? "selected" : ""}>Asc</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary mb-2">Lọc</button>
            </form>
            <a href="marketing-product?action=add" class="btn btn-success btn-sm mb-2">Thêm mới</a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ảnh</th>
                        <th>Tên sách</th>
                        <th>Thể loại</th>
                        <th>Giá</th>
                        <th>Sale</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}">
                        <tr>
                            <td>${book.bookId}</td>
                            <td><img src="${book.image}" alt="${book.title}" style="width:50px;height:50px;"></td>
                            <td>${book.title}</td>
                            <td>${categories[book.categoryId]}</td>
                            <td>
                                <fmt:formatNumber value="${book.price}" type="number" minFractionDigits="3" maxFractionDigits="3" /> vnd
                            </td>
                            <td>${book.discount}%</td>
                            <td>
                                <a href="marketing-product?action=view&id=${book.bookId}" class="btn btn-info btn-sm">Xem</a>
                                <a href="marketing-product?action=edit&id=${book.bookId}" class="btn btn-warning btn-sm">Sửa</a>
                                <a onclick="return confirm('Are you sure to delete this books?')" href="marketing-product?action=delete&id=${book.bookId}" class="btn btn-danger btn-sm">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item"><a class="page-link" href="marketing-product?page=${currentPage - 1}&title=${title}&category=${category}&sortListPrice=${sortListPrice}&sortPriceSale=${sortPriceSale}">Previous</a></li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="marketing-product?page=${i}&title=${title}&category=${category}&sortListPrice=${sortListPrice}&sortPriceSale=${sortPriceSale}">${i}</a></li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                        <li class="page-item"><a class="page-link" href="marketing-product?page=${currentPage + 1}&title=${title}&category=${category}&sortListPrice=${sortListPrice}&sortPriceSale=${sortPriceSale}">Next</a></li>
                        </c:if>
                </ul>
            </nav>
        </div>
        <jsp:include page="footer.jsp"/>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>