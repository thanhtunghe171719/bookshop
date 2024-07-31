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
        DAOUsers userDAO = new DAOUsers();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String encrypt = userDAO.Sha256(password);
        DAOUsers dao = new DAOUsers();
        User us = dao.getUserByUsername(email);
        if (us == null) {
            request.setAttribute("errorMessage", "Tài khoản không tồn tại. Vui lòng thử lại.");
            request.getRequestDispatcher("./views/login.jsp").forward(request, response);
        } else if (us != null && us.getPassword().equals(encrypt) && dao.isAccountActive(us)) {
            // Authentication successful
            request.getSession().setAttribute("user", us);
            switch (us.getRoleId()) {
                case 1:
                    response.sendRedirect("admin_dashboard");
                    break;
                case 2:
                    response.sendRedirect("marketing_dashboard");
                    break;
                case 3:
                    response.sendRedirect("manage-order-sale");
                    break;
                case 4:
                    response.sendRedirect("home");
                    break;
                case 5:
                    response.sendRedirect("sale_dashboard");
                    break;
                case 6:
                    response.sendRedirect("manage-shipper");
                    break;
                default:
                    // Trường hợp roleId không khớp với bất kỳ trường hợp nào trên
                    response.sendRedirect("home");
                    break;
            }
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
