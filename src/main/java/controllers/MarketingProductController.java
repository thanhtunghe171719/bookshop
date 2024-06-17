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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Book;
import models.Categorie;

/**
 *
 * @author HP
 */
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
        int pageSize = 10;
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
                    request.getRequestDispatcher("./marketing/book/view.jsp").forward(request, response);
                } else {
                    response.sendRedirect("marketing-product?error=Book can not found");
                }
            } catch (Exception e) {
                response.sendRedirect("marketing-product?error=Id is not valid");
                System.out.println("View: " + e);
            }
            break;
            default:
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                String title = request.getParameter("title");
                String category = request.getParameter("category");
                String sortTitle = request.getParameter("sortTitle");
                String sortListPrice = request.getParameter("sortListPrice");
                String sortPriceSale = request.getParameter("sortPriceSale");
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
                request.getRequestDispatcher("./marketing/book/list.jsp").forward(request, response);
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
        processRequest(request, response);
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
