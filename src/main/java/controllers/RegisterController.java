/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dal.DAOUsers;
import models.User;
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
        String address = request.getParameter("address");
        
        // Check if username already exists
        User existingUser = userDAO.getUserByUsername(email);
        if (existingUser != null) {
            request.setAttribute("errorMessage", "Username already exists");
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
        newUser.setAddress(address);
       
        // Add the new user to the database
        boolean userAdded = userDAO.addUser(newUser);

        if (userAdded) {
            // Registration successful
            request.setAttribute("error", "Register Success!");
            request.getRequestDispatcher("./views/register.jsp").forward(request, response);
            //response.sendRedirect("login");
        } else {
            // Registration failed
            request.setAttribute("errorMessage", "Registration failed. Please try again later.");
            request.getRequestDispatcher("./views/register.jsp").forward(request, response);
        }
    }
}