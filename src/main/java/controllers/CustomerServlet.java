/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOUsers;
import dal.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.User;

/**
 *
 * @author kobietkolam
 */
public class CustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DAOUsers daoUsers;
    
      @Override
    public void init() throws ServletException {
        super.init();
        daoUsers = new DAOUsers();
    }
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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          List<User> users = daoUsers.getAll("SELECT * FROM users WHERE role_id = 2");
        request.setAttribute("users", users);
        
        request.getRequestDispatcher("views/customerList.jsp").forward(request, response);
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
       String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Handle add customer
            String fullname = request.getParameter("fullname");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int status = 2; // Assuming role_id 2 is for customers

            User newUser = new User();
            newUser.setFullname(fullname);
            newUser.setGender(gender);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setRoleId(status);

            daoUsers.addUser(newUser);
        } else if ("delete".equals(action)) {
            // Handle delete customer
            int userId = Integer.parseInt(request.getParameter("user_id"));
            daoUsers.deleteUser(userId);
        }

        response.sendRedirect("customers");
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
