/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOUsers;
import models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.users;

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
        User us = dao.getUserByUsername(email);
        if (us == null) {
            request.setAttribute("errorMessage", "Tài khoản không tồn tại. Vui lòng thử lại.");
            request.getRequestDispatcher("./views/login.jsp").forward(request, response);
        } else if (us != null && us.getPassword().equals(password) && dao.isAccountActive(us)) {
            // Authentication successful
            request.getSession().setAttribute("user", us);
            response.sendRedirect("home");
        } else if (us != null && !dao.isAccountActive(us)) {
            request.setAttribute("errorMessage", "Tài khoản không được phép truy cập vào hệ thống");
            request.getRequestDispatcher("./views/login.jsp").forward(request, response);
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không chính xác");
            request.getRequestDispatcher("./views/login.jsp").forward(request, response);
        }
        
    }
}
