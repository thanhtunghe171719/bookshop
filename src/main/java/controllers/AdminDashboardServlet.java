/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import com.google.gson.Gson;
import dal.DAOBooksList;
import dal.DAOOrders;
import dal.DAOUsers;
import dal.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import models.Books;
import models.Categories;
import models.User;

/**
 *
 * @author ADMIN
 */
public class AdminDashboardServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AdminDashboardServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashboardServlet at " + request.getContextPath () + "</h1>");
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
//        processRequest(request, response);
        DAOOrders dao= new DAOOrders();
        DAOUsers dao1 = new DAOUsers();
        FeedbackDAO dao2 = new FeedbackDAO();
        
        double totalProfit = dao.getTotalProfit();
        int totalOrders = dao.getOrdersCount();
        int totalCustomers = dao1.getCustomerCount();
        int totalFeedbacks = dao2.getFeedbacksCount();
        double month1 = dao.getTotalProfitByMonth(1);
        double month2 = dao.getTotalProfitByMonth(2);
        double month3 = dao.getTotalProfitByMonth(3);
        double month4 = dao.getTotalProfitByMonth(4);
        double month5 = dao.getTotalProfitByMonth(5);
        double month6 = dao.getTotalProfitByMonth(6);
        double month7 = dao.getTotalProfitByMonth(7);
        double month8 = dao.getTotalProfitByMonth(8);
        double month9 = dao.getTotalProfitByMonth(9);
        double month10 = dao.getTotalProfitByMonth(10);
        double month11 = dao.getTotalProfitByMonth(11);
        double month12 = dao.getTotalProfitByMonth(12);
        
        request.setAttribute("month1", month1);
        request.setAttribute("month2", month2);
        request.setAttribute("month3", month3);
        request.setAttribute("month4", month4);
        request.setAttribute("month5", month5);
        request.setAttribute("month6", month6);
        request.setAttribute("month7", month7);
        request.setAttribute("month8", month8);
        request.setAttribute("month9", month9);
        request.setAttribute("month10", month10);
        request.setAttribute("month11", month11);
        request.setAttribute("month12", month12);

        request.setAttribute("totalProfit", totalProfit);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalFeedbacks", totalFeedbacks);
        
        request.getRequestDispatcher("./views/admindashboard.jsp").forward(request, response);

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
//       processRequest(request, response);
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
