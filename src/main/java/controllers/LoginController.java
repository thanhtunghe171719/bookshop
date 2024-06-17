/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOUsers;
import models.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;



    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        DAOUsers dao = new DAOUsers();
        users user = dao.getUserByUsername(email);
        if (user != null && user.getStatus() == 0) {
            request.setAttribute("errorMessage", "Your account no confirmed. Please confirm your account");
            request.getRequestDispatcher("./views/login.jsp").forward(request, response);
        } else if (user != null && user.getPassword().equals(password)) {
            // Authentication successful
            request.getSession().setAttribute("user", user);
            response.sendRedirect("home");
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("./views/login.jsp").forward(request, response);
        }
    }
}
