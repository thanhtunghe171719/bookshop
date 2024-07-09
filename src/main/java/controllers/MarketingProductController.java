/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOBooks;
import dal.DAOCategories;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Book;
import models.Categorie;


@WebServlet(name = "MarketingProductController", urlPatterns = {"/marketing-product"})
public class MarketingProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MarketingProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarketingProductController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        DAOBooks bookDao = new DAOBooks();
        DAOCategories categoryDao = new DAOCategories();
        int page = 1;
        int pageSize = 4;
        Map<Integer, String> categories = new HashMap<>();
        switch (action) {
            case "view":
                try {
                int id = Integer.parseInt(request.getParameter("id"));
                Book book = bookDao.getById(id);
                if (book != null) {
                    Categorie category = categoryDao.getById(book.getCategoryId());
                    request.setAttribute("category", category);
                    request.setAttribute("book", book);
                    request.getRequestDispatcher("./views/viewproduct.jsp").forward(request, response);
                } else {
                    response.sendRedirect("marketing-product?error=Book can not found");
                }
            } catch (Exception e) {
                response.sendRedirect("marketing-product?error=Id is not valid");
                System.out.println("View: " + e);
            }
            break;
            case "add":
                List<Categorie> categoriesAllAdd = categoryDao.getAll();
                request.setAttribute("categories", categoriesAllAdd);
                request.getRequestDispatcher("./views/addproduct.jsp").forward(request, response);
                break;
            case "edit":
                try {
                int bookId = Integer.parseInt(request.getParameter("id"));
                Book existingBook = bookDao.getById(bookId);
                List<Categorie> categoriesAllEdit = categoryDao.getAll();

                request.setAttribute("book", existingBook);
                request.setAttribute("categories", categoriesAllEdit);
                request.getRequestDispatcher("./views/editproduct.jsp").forward(request, response);
            } catch (Exception e) {
                response.sendRedirect("marketing-product?error=Book can not found");
            }
            break;
            case "delete":
                int bookId = Integer.parseInt(request.getParameter("id"));
                int result = bookDao.deleteBook(bookId);

                if (result > 0) {
                    response.sendRedirect("marketing-product?success=Delete successfully");
                } else {
                    response.sendRedirect("marketing-product?error=Delete fail");
                }
                break;
            default:
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                String title = request.getParameter("title");
                title = title != null ? title.trim() : "";
                String category = request.getParameter("category");
                String sortTitle = request.getParameter("sortTitle");
                sortTitle = sortTitle != null ? sortTitle.trim() : "";
                String sortListPrice = request.getParameter("sortListPrice");
                sortListPrice = sortListPrice != null ? sortListPrice.trim() : "";
                String sortPriceSale = request.getParameter("sortPriceSale");
                sortPriceSale = sortPriceSale != null ? sortPriceSale.trim() : "";
                List<Book> books = bookDao.getBooks(title, category, sortTitle, sortListPrice, sortPriceSale, page, pageSize);
                int totalBooks = bookDao.getBookCount(title, category);
                int totalPages = (int) Math.ceil(totalBooks / (double) pageSize);
                for (Book book : books) {
                    Categorie c = categoryDao.getById(book.getCategoryId());
                    categories.put(book.getCategoryId(), c.getCategoryName());
                }

                request.setAttribute("title", title);
                request.setAttribute("category", category);
                request.setAttribute("sortTitle", sortTitle);
                request.setAttribute("sortListPrice", sortListPrice);
                request.setAttribute("sortPriceSale", sortPriceSale);

                List<Categorie> categoriesAll = categoryDao.getAll();
                request.setAttribute("categories", categories);
                request.setAttribute("categoriesAll", categoriesAll);
                request.setAttribute("books", books);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.getRequestDispatcher("./views/listproduct.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "add":
                this.addNew(request, response);
                break;
            case "edit":
                this.edit(request, response);
                break;
            default:
                throw new AssertionError();
        }

    }

    private void addNew(HttpServletRequest request, HttpServletResponse response) {
        DAOBooks bookDao = new DAOBooks();
        DAOCategories categoryDao = new DAOCategories();
        try {
            Map<String, String> errors = validateInput(request);
            if (!errors.isEmpty()) {
                List<Categorie> categoriesAllAdd = categoryDao.getAll();
                request.setAttribute("categories", categoriesAllAdd);
                request.setAttribute("errors", errors);
                request.setAttribute("formData", request.getParameterMap());
                request.getRequestDispatcher("./views/addproduct.jsp").forward(request, response);
                return;
            }
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String image = request.getParameter("image");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            String publishingHouse = request.getParameter("publishing_house");
            int publishedYear = Integer.parseInt(request.getParameter("published_year"));
            String size = request.getParameter("size");
            String weight = request.getParameter("weight");
            String summary = request.getParameter("summary");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int rating = 0;
            int discount = Integer.parseInt(request.getParameter("discount"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());
            Timestamp updatedAt = null;
            String format = request.getParameter("format");
            int pages = Integer.parseInt(request.getParameter("pages"));

            Book book = new Book(0, title, author, image, categoryId, publishingHouse, publishedYear, size, weight, summary, price, rating, discount, stock, createdAt, updatedAt, format, pages);
            int result = bookDao.addBook(book);
            if (result > 0) {
                response.sendRedirect("marketing-product?success=Add new successfully");
            } else {
                response.sendRedirect("marketing-product?error=Add new fail");
            }
        } catch (Exception e) {
            System.out.println("Add new error: " + e);
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DAOBooks bookDao = new DAOBooks();
        DAOCategories categoryDao = new DAOCategories();
        int bookId = Integer.parseInt(request.getParameter("id"));
        try {
            Map<String, String> errors = validateInput(request);
            if (!errors.isEmpty()) {
                List<Categorie> categoriesAllEdit = categoryDao.getAll();
                request.setAttribute("categories", categoriesAllEdit);
                request.setAttribute("errors", errors);
                request.setAttribute("formData", request.getParameterMap());
                request.getRequestDispatcher("./views/editproduct.jsp").forward(request, response);
                return;
            }

            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String image = request.getParameter("image");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            String publishingHouse = request.getParameter("publishing_house");
            int publishedYear = Integer.parseInt(request.getParameter("published_year"));
            String size = request.getParameter("size");
            String weight = request.getParameter("weight");
            String summary = request.getParameter("summary");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int rating = 0;
            int discount = Integer.parseInt(request.getParameter("discount"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            Timestamp updatedAt = new Timestamp(System.currentTimeMillis());
            String format = request.getParameter("format");
            int pages = Integer.parseInt(request.getParameter("pages"));

            Book book = new Book(bookId, title, author, image, categoryId, publishingHouse, publishedYear, size, weight, summary, price, rating, discount, stock, null, updatedAt, format, pages);
            int result = bookDao.updateBook(book);
            if (result > 0) {
                response.sendRedirect("marketing-product?success=Update successfully");
            } else {
                response.sendRedirect("marketing-product?error=Update fail");
            }
        } catch (Exception e) {
            response.sendRedirect("marketing-product?id=" + bookId + "&action=edit&error=Have a error of input");
            System.out.println("Update error: " + e);
        }
    }

    private Map<String, String> validateInput(HttpServletRequest request) {
        Map<String, String> errors = new HashMap<>();

        String title = request.getParameter("title");
        if (title == null || title.trim().isEmpty()) {
            errors.put("title", "Title is required.");
        }

        String author = request.getParameter("author");
        if (author == null || author.trim().isEmpty()) {
            errors.put("author", "Author is required.");
        }

        String image = request.getParameter("image");
        if (image == null || image.trim().isEmpty()) {
            errors.put("image", "Image URL is required.");
        }

        try {
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
        } catch (NumberFormatException e) {
            errors.put("category_id", "Valid category is required.");
        }

        String publishingHouse = request.getParameter("publishing_house");
        if (publishingHouse == null || publishingHouse.trim().isEmpty()) {
            errors.put("publishing_house", "Publishing House is required.");
        }

        try {
            int publishedYear = Integer.parseInt(request.getParameter("published_year"));
            if (publishedYear < 1000) {
                errors.put("Published Year", "Published year must be from 1000.");
            }
        } catch (NumberFormatException e) {
            errors.put("published_year", "Valid published year is required.");
        }

        String size = request.getParameter("size");
        if (size == null || size.trim().isEmpty()) {
            errors.put("size", "Size is required.");
        }

        String weight = request.getParameter("weight");
        if (weight == null || weight.trim().isEmpty()) {
            errors.put("weight", "Weight is required.");
        }

        String summary = request.getParameter("summary");
        if (summary == null || summary.trim().isEmpty()) {
            errors.put("summary", "Summary is required.");
        }

        try {
            double price = Double.parseDouble(request.getParameter("price"));
            if (price < 0) {
                errors.put("price", "Price must be greater 0.");
            }
        } catch (NumberFormatException e) {
            errors.put("price", "Valid price is required.");
        }
        try {
            double discount = Double.parseDouble(request.getParameter("discount"));
            if (discount < 0) {
                errors.put("discount", "Discount must be greater or equals 0.");
            }
        } catch (NumberFormatException e) {
            errors.put("discount", "Valid discount is required.");
        }

        try {
            int stock = Integer.parseInt(request.getParameter("stock"));
            if (stock < 0) {
                errors.put("stock", "Stock must be greater or equals 0.");
            }
        } catch (NumberFormatException e) {
            errors.put("stock", "Valid stock is required.");
        }

        String format = request.getParameter("format");
        if (format == null || format.trim().isEmpty()) {
            errors.put("format", "format is required.");
        }

        try {
            int page = Integer.parseInt(request.getParameter("pages"));
            if (page < 0) {
                errors.put("page", "Page must be greater 0.");
            }
        } catch (NumberFormatException e) {
            errors.put("page", "Valid page is required.");
        }
        return errors;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}