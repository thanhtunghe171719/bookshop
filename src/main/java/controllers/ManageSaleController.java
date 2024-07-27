/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import models.Order;
import models.OrderItems;
import models.User;

/**
 *
 * @author HP
 */
@WebServlet(name="ManageSaleController", urlPatterns={"/manage-sale"})
public class ManageSaleController extends HttpServlet {
   
     private OrderDAO orderDAO;

    public ManageSaleController() {
        super();
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (user != null && user.getRoleId() != 5)) {
            response.sendRedirect("login");
            return;
        }
        Integer userId = user.getUserId();
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "view":
                viewOrderDetail(request, response);
                break;
            default:
                listOrders(request, response);
                break;
        }
    }
    
    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = orderDAO.getOrderById(orderId);
        List<OrderItems> orderitems = orderDAO.getOrderItemsByOrderId(orderId);
        request.setAttribute("orderItems", orderitems);
        request.setAttribute("order", order);
        request.getRequestDispatcher("./views/manage-orderDetail.jsp").forward(request, response);
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = orderDAO.getAllSale();
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("users", users);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("./views/orderList-sale-manage.jsp").forward(request, response);
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
//        processRequest(request, response);
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
