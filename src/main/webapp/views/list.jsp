<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">   
        <title>Books List</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .custom-heading {
                display: flex; /* Sử dụng Flexbox */
                align-items: center; /* Căn giữa theo chiều dọc */
                gap: 10px; /* Khoảng cách giữa biểu tượng và văn bản */
            }

            .icon {
                height: 70px;
                width: 60px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
            <div class="container mt-5">
                <h2 class="mb-4 custom-heading">
                    <img class="icon" src="https://cdn-icons-png.flaticon.com/128/3330/3330314.png" alt="Books Icon"> 
                    Books List
                </h2>

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
                    <label for="title" class="sr-only">Search</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="Search" value="${title}">
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="category"><img style="height: 35px; width: 35px" src="https://cdn-icons-png.flaticon.com/128/9740/9740979.png"></label>
                    <select class="form-control" id="category" name="category">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categoriesAll}">
                            <option value="${cat.categoryId}" ${cat.categoryId == category ? "selected" : ""}>${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="sortTitle"><img style="height: 35px; width: 35px" src="https://cdn-icons-png.flaticon.com/128/690/690342.png"></label>
                    <select class="form-control" id="sortTitle" name="sortTitle">
                        <option value="" ${sortTitle == "" ? "selected" : ""}>Default</option>
                        <option value="desc" ${sortTitle == "desc" ? "selected" : ""}>Desc</option>
                        <option value="asc" ${sortTitle == "asc" ? "selected" : ""}>Asc</option>
                    </select>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="sortListPrice"><img style="height: 35px; width: 35px" src="https://cdn-icons-png.flaticon.com/128/10165/10165422.png"></label>
                    <select class="form-control" id="sortListPrice" name="sortListPrice">
                        <option value="" ${sortListPrice == "" ? "selected" : ""}>Price</option>
                        <option value="desc" ${sortListPrice == "desc" ? "selected" : ""}>Desc</option>
                        <option value="asc" ${sortListPrice == "asc" ? "selected" : ""}>Asc</option>
                    </select>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <label for="sortPriceSale"><img style="height: 35px; width: 35px" src="https://cdn-icons-png.flaticon.com/128/15239/15239669.png"></label>
                    <select class="form-control" id="sortPriceSale" name="sortPriceSale">
                        <option value="" ${sortPriceSale == "" ? "selected" : ""}>Price Sale</option>
                        <option value="desc" ${sortPriceSale == "desc" ? "selected" : ""}>Desc</option>
                        <option value="asc" ${sortPriceSale == "asc" ? "selected" : ""}>Asc</option>
                    </select>
                </div>
                <button type="submit" class="btn mb-2" style="padding: 0px"><img style="height: 40px; width: 40px; background: white; border: none" src="https://cdn-icons-png.flaticon.com/128/10628/10628657.png"></button>
            </form>
            <a href="marketing-product?action=add" style="color: black" class="btn btn-sm mb-2"><img style="height: 30px; width: 30px; background: white; padding: 0px; border: none" src="https://cdn-icons-png.flaticon.com/128/10337/10337579.png">  Add new</a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Thumbnail</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>List Price</th>
                        <th>Sale Price</th>
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
                            <td><fmt:formatNumber value="${book.price}" type="currency" currencySymbol="" pattern="#,##0"/> vnd</td>

                            <td>${book.discount}</td>
                            <td>
                                <a href="marketing-product?action=view&id=${book.bookId}" class="btn btn-sm"><img style="height: 30px; width: 30px" src="https://cdn-icons-png.flaticon.com/128/189/189664.png"></a>
                                <a href="marketing-product?action=edit&id=${book.bookId}" class="btn btn-sm"><img style="height: 30px; width: 30px" src="https://cdn-icons-png.flaticon.com/128/1160/1160515.png"></a>
                                <a onclick="return confirm('Are you sure to delete this books?')" href="marketing-product?action=delete&id=${book.bookId}" class="btn btn-sm"><img style="height: 30px; width: 30px" src="https://cdn-icons-png.flaticon.com/128/9790/9790368.png"></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item"><a class="page-link" href="marketing-product?page=${currentPage - 1}&title=${title}&category=${category}&sortListPrice=${sortListPrice}&sortPriceSale=${sortPriceSale}&sortTitle=${sortTitle}">Previous</a></li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="marketing-product?page=${i}&title=${title}&category=${category}&sortListPrice=${sortListPrice}&sortPriceSale=${sortPriceSale}&sortTitle=${sortTitle}">${i}</a></li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                        <li class="page-item"><a class="page-link" href="marketing-product?page=${currentPage + 1}&title=${title}&category=${category}&sortListPrice=${sortListPrice}&sortPriceSale=${sortPriceSale}&sortTitle=${sortTitle}">Next</a></li>
                        </c:if>
                </ul>
            </nav>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>
