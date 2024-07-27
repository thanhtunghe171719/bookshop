/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOOrders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;

/**
 *
 * @author ngdin
 */
public class CancelOrder extends HttpServlet {

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

        HttpSession session = request.getSession(false); // Use false to avoid creating a new session if it doesn't exist

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        DAOOrders orderDAO = new DAOOrders();
        String id = request.getParameter("oid");

        if (id != null && !id.isEmpty()) {
            try {
                int orderId = Integer.parseInt(id);
                orderDAO.cancelOrder(orderId);
                int cancelResult = orderDAO.cancelOrder(orderId);
                if (cancelResult > 0) {
                    int updatedItems = orderDAO.updateInventoryOnCancel(orderId); // Update inventory
                    if (updatedItems > 0) {
                        request.getRequestDispatcher("views/cancelsuccess.jsp").forward(request, response);
                        // Optionally set a success message
                    } else {
                        request.getRequestDispatcher("views/cancelfail.jsp").forward(request, response);
                        // Optionally set a warning message
                    }
                } else {
                    request.getRequestDispatcher("views/cancelfail.jsp").forward(request, response);
                    // Optionally set a failure message
                }
            } catch (NumberFormatException e) {
                // Log the exception and handle the error
                e.printStackTrace();
            }
        } else {
            // Handle the case where id is null or empty
            // You might want to set an error message in the request and forward it to an error page or back to the homepage
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
        processRequest(request, response);
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
