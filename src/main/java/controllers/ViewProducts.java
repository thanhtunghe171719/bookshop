/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOBooksList;
import models.User;
import models.Books;
import models.Categories;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author skyfc
 */
public class ViewProducts extends HttpServlet {

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
            out.println("<title>Servlet ViewProducts</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewProducts at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);

        DAOBooksList daoBooksList = new DAOBooksList();

        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        String sort = request.getParameter("sort");
        if (sort == null) {
            sort = "default";
        }

        String grid = request.getParameter("grid");
        if (grid == null || grid == "") {
            grid = "6";
        }

        String categoryidParam = request.getParameter("categoryid");
        if (categoryidParam == null) {
            categoryidParam = "0";
        }

        ArrayList<Books> lst_books;
        int totalBooks = 0;

        int categoryid = 0;

        if (categoryidParam == "0") {
            lst_books = daoBooksList.getListBooks(grid, index, sort);
            totalBooks = daoBooksList.getTotalBooks();
        } else {
            try {
                categoryid = Integer.parseInt(categoryidParam);
                lst_books = daoBooksList.getListBooksByCategory(categoryid, grid, index, sort);
                totalBooks = daoBooksList.getTotalBooksByCategory(categoryid);
            } catch (NumberFormatException e) {
                // Handle the error, maybe set a default category or show an error message
                lst_books = daoBooksList.getListBooks(grid, index, sort); // Default behavior if parsing fails
                totalBooks = daoBooksList.getTotalBooks();
            }
        }

        int page = totalBooks / Integer.parseInt(grid);
        if (totalBooks % Integer.parseInt(grid) != 0) {
            page++;
        }

        ArrayList<Categories> lst_categories = daoBooksList.getListCategories();

        request.setAttribute("book", lst_books);
        request.setAttribute("page", page);
        request.setAttribute("pagetag", index);
        request.setAttribute("category", lst_categories);
        request.setAttribute("tag", categoryid);
        request.setAttribute("sort", sort);
        request.setAttribute("grid", grid);

        request.getRequestDispatcher("views/product.jsp").forward(request, response);
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
