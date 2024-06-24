/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import models.User;
import dal.DAOUsers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.Arrays;

/**
 *
 * @author kobietkolam
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class EditProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet EditProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfileServlet at " + request.getContextPath() + "</h1>");
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
        String userIdStr = request.getParameter("user_id");
        int userId = 0;
        if (userIdStr != null && !userIdStr.isEmpty()) {
            userId = Integer.parseInt(userIdStr);
        }
        DAOUsers dao = new DAOUsers();
        User user = dao.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("views/editprofile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        DAOUsers dao = new DAOUsers();
        User user = dao.getUserById(userId);

        // Handle file upload
        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();

        if (fileName != null && !fileName.isEmpty()) {
            if (fileName.lastIndexOf(".") == -1) {
                request.setAttribute("STATUS", "Invalid file. Please select a valid image file.");
                forwardToEditProfile(request, response, userId);
                return;
            }

            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String[] allowedExtensions = {".png", ".jpg", ".jpeg"};

            if (!Arrays.asList(allowedExtensions).contains(fileExtension.toLowerCase())) {
                request.setAttribute("STATUS", "Invalid file type. Only PNG and JPG are allowed.");
                forwardToEditProfile(request, response, userId);
                return;
            }

            // Define the upload path
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            user.setImage("uploads/" + fileName); // Set the new image path
        }

        // Validation
        String namePattern = "^[a-zA-Z\\s]+$";
        String phonePattern = "^\\d{10}$";

        if (!fullname.matches(namePattern)) {
            request.setAttribute("STATUS", "Full name must contain only letters and spaces.");
            forwardToEditProfile(request, response, userId);
            return;
        }

        if (!phone.matches(phonePattern)) {
            request.setAttribute("STATUS", "Phone number must be exactly 10 digits.");
            forwardToEditProfile(request, response, userId);
            return;
        }

        // Update user profile
        user.setFullname(fullname);
        user.setGender(gender);
        user.setAddress(address);
        user.setPhone(phone);

        try {
            dao.updateUser(user);
            request.setAttribute("STATUS", "Profile updated successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("STATUS", "Error updating profile!");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("views/editprofile.jsp").forward(request, response);
    }

    
    private void forwardToEditProfile(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        DAOUsers dao = new DAOUsers();
        User user = dao.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("views/editprofile.jsp").forward(request, response);
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