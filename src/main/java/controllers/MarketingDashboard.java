/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOBooks;
import dal.DAOOrders;
import dal.DAOPosts;
import dal.DAOSlider;
import dal.DAOUsers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.User;

/**
 *
 * @author ADMIN
 */
public class MarketingDashboard extends HttpServlet {

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
            out.println("<title>Servlet MarketingDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarketingDashboard at " + request.getContextPath() + "</h1>");
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
        DAOPosts dao = new DAOPosts();
        DAOUsers dao1 = new DAOUsers();
        DAOBooks dao2 = new DAOBooks();
        DAOSlider dao3 = new DAOSlider();
        int totalPosts = dao.getPostsCount();
        int totalBooks = dao2.getBooksCount();
        int totalCustomers = dao1.getCustomerCount();
        int totalSliders = dao3.getSlidersCount();

        int monthc1 = dao1.getCustomerCountByMonth(1);
        int monthc2 = dao1.getCustomerCountByMonth(2);
        int monthc3 = dao1.getCustomerCountByMonth(3);
        int monthc4 = dao1.getCustomerCountByMonth(4);
        int monthc5 = dao1.getCustomerCountByMonth(5);
        int monthc6 = dao1.getCustomerCountByMonth(6);
        int monthc7 = dao1.getCustomerCountByMonth(7);
        int monthc8 = dao1.getCustomerCountByMonth(8);
        int monthc9 = dao1.getCustomerCountByMonth(9);
        int monthc10 = dao1.getCustomerCountByMonth(10);
        int monthc11 = dao1.getCustomerCountByMonth(11);
        int monthc12 = dao1.getCustomerCountByMonth(12);

        request.setAttribute("monthc1", monthc1);
        request.setAttribute("monthc2", monthc2);
        request.setAttribute("monthc3", monthc3);
        request.setAttribute("monthc4", monthc4);
        request.setAttribute("monthc5", monthc5);
        request.setAttribute("monthc6", monthc6);
        request.setAttribute("monthc7", monthc7);
        request.setAttribute("monthc8", monthc8);
        request.setAttribute("monthc9", monthc9);
        request.setAttribute("monthc10", monthc10);
        request.setAttribute("monthc11", monthc11);
        request.setAttribute("monthc12", monthc12);
        int monthp1 = dao.getPostsCountByMonth(1);
        int monthp2 = dao.getPostsCountByMonth(2);
        int monthp3 = dao.getPostsCountByMonth(3);
        int monthp4 = dao.getPostsCountByMonth(4);
        int monthp5 = dao.getPostsCountByMonth(5);
        int monthp6 = dao.getPostsCountByMonth(6);
        int monthp7 = dao.getPostsCountByMonth(7);
        int monthp8 = dao.getPostsCountByMonth(8);
        int monthp9 = dao.getPostsCountByMonth(9);
        int monthp10 = dao.getPostsCountByMonth(10);
        int monthp11 = dao.getPostsCountByMonth(11);
        int monthp12 = dao.getPostsCountByMonth(12);

        request.setAttribute("monthp1", monthp1);
        request.setAttribute("monthp2", monthp2);
        request.setAttribute("monthp3", monthp3);
        request.setAttribute("monthp4", monthp4);
        request.setAttribute("monthp5", monthp5);
        request.setAttribute("monthp6", monthp6);
        request.setAttribute("monthp7", monthp7);
        request.setAttribute("monthp8", monthp8);
        request.setAttribute("monthp9", monthp9);
        request.setAttribute("monthp10", monthp10);
        request.setAttribute("monthp11", monthp11);
        request.setAttribute("monthp12", monthp12);

        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalSliders", totalSliders);
        request.getRequestDispatcher("./views/marketingdashboard.jsp").forward(request, response);
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
