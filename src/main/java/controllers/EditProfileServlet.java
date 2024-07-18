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
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class EditProfileServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(EditProfileServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("user_id");
        int userId = 0;
        if (userIdStr != null && !userIdStr.isEmpty()) {
            try {
                userId = Integer.parseInt(userIdStr);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.SEVERE, "Invalid user ID format: {0}", userIdStr);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID format.");
                return;
            }
        }
        DAOUsers dao = new DAOUsers();
        User user = dao.getUserById(userId);
        if (user == null) {
            LOGGER.log(Level.SEVERE, "User not found for ID: {0}", userId);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found.");
            return;
        }
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

    if (user == null) {
        request.setAttribute("STATUS", "User not found!");
        forwardToEditProfile(request, response, userId);
        return;
    }

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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
