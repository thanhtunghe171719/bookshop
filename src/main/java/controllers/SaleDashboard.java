/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dal.DAOBooks;
import dal.DAOOrders;
import dal.DAOPosts;
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
public class SaleDashboard extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<h1>Servlet MarketingDashboard at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        DAOOrders dao = new DAOOrders();
        
        int totalPendingOrder = dao.getTotalPendingOrder();
        int totalShippingOrder = dao.getTotalShippingOrder();
        int totalDeliveredOrder = dao.getTotalDeliveredOrder();
        int totalCanceledOrder = dao.getTotalCanceledOrder();
        
        int months1 = dao.getOrderSuccessfulCountByMonth(1);
        int months2 = dao.getOrderSuccessfulCountByMonth(2);
        int months3 = dao.getOrderSuccessfulCountByMonth(3);
        int months4 = dao.getOrderSuccessfulCountByMonth(4);
        int months5 = dao.getOrderSuccessfulCountByMonth(5);
        int months6 = dao.getOrderSuccessfulCountByMonth(6);
        int months7 = dao.getOrderSuccessfulCountByMonth(7);
        int months8 = dao.getOrderSuccessfulCountByMonth(8);
        int months9 = dao.getOrderSuccessfulCountByMonth(9);
        int months10 = dao.getOrderSuccessfulCountByMonth(10);
        int months11 = dao.getOrderSuccessfulCountByMonth(11);
        int months12 = dao.getOrderSuccessfulCountByMonth(12);
        
        request.setAttribute("months1", months1);
        request.setAttribute("months2", months2);
        request.setAttribute("months3", months3);
        request.setAttribute("months4", months4);
        request.setAttribute("months5", months5);
        request.setAttribute("months6", months6);
        request.setAttribute("months7", months7);
        request.setAttribute("months8", months8);
        request.setAttribute("months9", months9);
        request.setAttribute("months10", months10);
        request.setAttribute("months11", months11);
        request.setAttribute("months12", months12);
       
        request.setAttribute("totalPendingOrder", totalPendingOrder);
        request.setAttribute("totalShippingOrder", totalShippingOrder);
        request.setAttribute("totalDeliveredOrder", totalDeliveredOrder);
        request.setAttribute("totalCanceledOrder", totalCanceledOrder);      
        request.getRequestDispatcher("./views/saledashboard.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
