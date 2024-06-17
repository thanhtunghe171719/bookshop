/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOBooksList;
import models.Books;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import models.Categories;

/**
 *
 * @author skyfc
 */
public class SearchControl extends HttpServlet {

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
            out.println("<title>Servlet SearchControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchControl at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        DAOBooksList daoBooksList = new DAOBooksList();

        String searchText = request.getParameter("search");
        String indexPage = request.getParameter("index");
        int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

        String sort = request.getParameter("sort");
        if (sort == null) {
            sort = "default";
        }

        String grid = request.getParameter("grid");
        if (grid == null) {
            grid = "6";
        }

        String categoryidParam = request.getParameter("categoryid");
        int categoryid = (categoryidParam == null) ? 0 : Integer.parseInt(categoryidParam);

        ArrayList<Books> lst_books;
        int totalBooks = 0;

        if (searchText != null && !searchText.isEmpty()) {
            lst_books = daoBooksList.getBookBySearch(searchText, grid, index, sort);
            totalBooks = lst_books.size();
        } else {
            if (categoryid == 0) {
                lst_books = daoBooksList.getListBooks(grid, index, sort);
                totalBooks = daoBooksList.getTotalBooks();
            } else {
                lst_books = daoBooksList.getListBooksByCategory(categoryid, grid, index, sort);
                totalBooks = daoBooksList.getTotalBooksByCategory(categoryid);
            }
        }

        int page = (totalBooks + 2) / Integer.parseInt(grid); // Round up for pagination

        ArrayList<Categories> lst_categories = daoBooksList.getListCategories();

        request.setAttribute("book", lst_books);
        request.setAttribute("page", page);
        request.setAttribute("pagetag", index);
        request.setAttribute("search", searchText);
        request.setAttribute("category", lst_categories);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("views/product.jsp").forward(request, response);
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