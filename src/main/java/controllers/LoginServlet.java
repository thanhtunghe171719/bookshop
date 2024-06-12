/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOUsers;
import models.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author TDG
 */
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DAOUsers userDAO;

    public void init() {
        userDAO = new DAOUsers();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        users user = userDAO.getUserByUsername(email);
        if (user != null && user.getStatus() == 0) {
            request.setAttribute("errorMessage", "Your account no confirmed. Please confirm your account");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        } else if (user != null && user.getPassword().equals(password)) {
            // Authentication successful
            request.getSession().setAttribute("user", user);
            response.sendRedirect("home");
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không chính xác");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }
}
