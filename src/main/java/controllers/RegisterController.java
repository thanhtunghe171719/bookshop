/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dal.*;
import models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import models.Cart;
import models.users;

/**
 *
 * @author TDG
 */
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DAOUsers userDAO;

    public void init() {
        userDAO = new DAOUsers();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./views/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        
        // Check if username already exists
        User existingUser = userDAO.getUserByUsername(email);
        if (existingUser != null) {
            request.setAttribute("errorMessage", "Tài khoản đã tồn tại");
            request.getRequestDispatcher("./views/register.jsp").forward(request, response);
            return;
        }

        // Create a new user object
        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone(phone);
        newUser.setRoleId(4); 
        newUser.setFullname(fullname);
        newUser.setGender(gender);
        newUser.setAddress(address);
       
        // Add the new user to the database
        boolean userAdded = userDAO.addUser(newUser);

        if (userAdded) {
            // Registration successful
            DAOCart dao = new DAOCart();
            Cart cart = new Cart();
            User user = userDAO.getUserByUsername(email);
            cart.setUserId(user.getUserId());
            dao.insert(cart); 
            request.setAttribute("errorMessage", "Đăng ký thành công. Vui lòng đăng nhập."); 
            request.getRequestDispatcher("./views/login.jsp").forward(request, response);
            //response.sendRedirect("login");
        } else {
            // Registration failed
            request.setAttribute("errorMessage", "Đăng ký thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("./views/register.jsp").forward(request, response);
        }
    }
}