/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOCart;
import dal.DAOOrders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import models.Items;
import models.Orders;
import models.User;

/**
 *
 * @author skyfc
 */
public class MyOrdersController extends HttpServlet {

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
            out.println("<title>Servlet MyOrdersController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyOrdersController at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);

        DAOOrders orders = new DAOOrders();
        DAOCart daoCart = new DAOCart();

        User user = (User) session.getAttribute("user");
        session.setAttribute("user", user);

        if (user == null) {
            response.sendRedirect("login");
        } else {
            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);

            // Get status filter from the request
            String statusFilter = request.getParameter("status");
            if (statusFilter == null) {
                statusFilter = "all"; // Default to show all orders
            }

            int userId = user.getUserId();
            int cartId = daoCart.getCartId(userId);

            int totalOrders;

            List<Orders> list_orders;

            if (statusFilter == "all") {
                list_orders = orders.getOrders(cartId, index);
                totalOrders = orders.getOrderCount(cartId);
            } else {
                list_orders = orders.getOrdersByStatus(cartId, index, statusFilter);
                totalOrders = orders.getOrderCountByStatus(statusFilter, cartId);
            }

            int endPage = totalOrders / 3;
            if (totalOrders % 3 != 0) {
                endPage++;
            }

            for (Orders list_order : list_orders) {
                List<Items> orderItems = orders.getOrderItemsForOrder(list_order.getOrderID());
                list_order.setOrderItems(orderItems);
            }

            request.setAttribute("orders", list_orders);
            request.setAttribute("page", endPage);
            request.setAttribute("pagetag", index);
            request.setAttribute("status", statusFilter);

            request.getRequestDispatcher("views/myorders.jsp").forward(request, response);

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
