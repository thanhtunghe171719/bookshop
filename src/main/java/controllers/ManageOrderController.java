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
import models.OrderStatus;
import models.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "ManageOrderController", urlPatterns = {"/manage-order-sale"})
public class ManageOrderController extends HttpServlet {

    private OrderDAO orderDAO;

    public ManageOrderController() {
        super();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (user != null && user.getRoleId() != 3)) {
            response.sendRedirect("login");
            return;
        }
        Integer userId = user.getUserId();
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = orderDAO.getOrderByIdUser(orderId, userId);
            if (order != null) {
                List<OrderItems> orderItems = orderDAO.getOrderItemsByOrderId(orderId);
                List<OrderStatus> orderStatuses = orderDAO.getAllOrderStatuses();
                request.setAttribute("orderStatuses", orderStatuses);
                request.setAttribute("orderItems", orderItems);
                request.setAttribute("order", order);
                request.getRequestDispatcher("./views/manage-orderDetail-sale.jsp").forward(request, response);
            } else {
                response.sendRedirect("manage-order-sale?error=Not have this order for you");
            }
        } catch (Exception e) {
            response.sendRedirect("manage-order-sale?error=Have a error");
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (user != null && user.getRoleId() != 3)) {
            response.sendRedirect("login");
            return;
        }
        Integer userId = user.getUserId();
        List<User> users = orderDAO.getAllShip();
        List<Order> orders = orderDAO.getAllOrdersByUserStaff(userId);
        request.setAttribute("orders", orders);
        request.setAttribute("users", users);
        request.getRequestDispatcher("./views/orderList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
