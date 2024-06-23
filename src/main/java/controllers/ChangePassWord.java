/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOUsers;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;

/**
 *
 * @author TDG
 */
public class ChangePassWord extends HttpServlet {

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

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        session.setAttribute("user", user);

        if (user == null) {
            response.sendRedirect("login");
        }else{
            String submit = request.getParameter("submit");
            if(submit != null && submit.equals("submit")){
                DAOUsers dao = new DAOUsers();

                String oldPassword = (String) request.getParameter("oldPassword");
                String newPassword = (String) request.getParameter("newPassword");

                String notice = null;

                if(oldPassword.equals(user.getPassword())){
                    user.setPassword(newPassword);
                    int result = dao.update(user);
                    if(result != 0){
                        notice = "change password successful.";
                        response.sendRedirect("home");
                        return;
                    }else{
                        notice = "change password fail.";
                    }
                }else{
                    notice = "input wrong old password.";
                }
            }
            RequestDispatcher dispth = request.getRequestDispatcher("./views/changepassword.jsp");
            //run(view)
            dispth.forward(request, response);

        }
//            DAOUsers dao = new DAOUsers();
//
//            String oldPassword = (String) request.getParameter("oldPassword");
//            String newPassword = (String) request.getParameter("newPassword");
//
//            String notice = null;
//
//            if(oldPassword.equals(user.getPassword())){
//                user.setPassword(newPassword);
//                int result = dao.update(user);
//                if(result != 0){
//                    notice = "change password successful.";
//                }else{
//                    notice = "change password fail.";
//                }
//            }else{
//                notice = "input wrong old password.";
//            }
//            //select(jsp)   
//            RequestDispatcher dispth = request.getRequestDispatcher("./views/changepassword.jsp");
//            //run(view)
//            dispth.forward(request, response);

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
protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
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


