/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.FeedbackDAO;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Feedback;
import models.OrderItems;
import models.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "FeedbackController", urlPatterns = {"/feedback"})
public class FeedbackController extends HttpServlet {

    private FeedbackDAO feedbackDAO;

    public void init() {
        feedbackDAO = new FeedbackDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            FeedbackDAO feedbackDao = new FeedbackDAO();
            try {
                int orderItemId = Integer.parseInt(request.getParameter("orderItemId"));
                OrderDAO orderDao = new OrderDAO();
                OrderItems orderItem = orderDao.getOrderItemById(orderItemId);
                if (orderItem != null) {
                    Feedback feedback = feedbackDao.getFeedbackByOrderItemId(orderItemId);
                    request.setAttribute("feedback", feedback);
                    request.setAttribute("orderItem", orderItem);
                    request.getRequestDispatcher("./views/feedback.jsp").forward(request, response);
                } else {
                    response.sendRedirect("history-order?error=Can not found this order");
                }
            } catch (Exception e) {
                System.out.println("Feedback: " + e);
                response.sendRedirect("history-order");
            }
        } else {
            response.sendRedirect("login");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int orderItemId = Integer.parseInt(request.getParameter("orderItemId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        if ("add".equals(action)) {
            addFeedback(orderItemId, rating, comment);
        } else if ("edit".equals(action)) {
            editFeedback(orderItemId, rating, comment);
        }

        response.sendRedirect("feedback?orderItemId=" +orderItemId+"&success=Feedback success");
    }

    private void addFeedback(int orderItemId, int rating, String comment) {
        Feedback feedback = new Feedback();
        feedback.setOrderItemId(orderItemId);
        feedback.setRating(rating);
        feedback.setComment(comment);
        feedbackDAO.addFeedback(feedback);
    }

    private void editFeedback(int orderItemId, int rating, String comment) {
        Feedback feedback = feedbackDAO.getFeedbackByOrderItemId(orderItemId);
        if (feedback != null) {
            feedback.setRating(rating);
            feedback.setComment(comment);
            feedbackDAO.updateFeedback(feedback);
        }
    }

}
