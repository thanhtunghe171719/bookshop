package controllers;

import dal.DAOBlog;
import dal.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.SQLException;
import models.Post;
import models.User;
import net.minidev.json.JSONObject;

@MultipartConfig
public class CreaterPostServlet extends HttpServlet {

    private DAOBlog dao;

    @Override
    public void init() throws ServletException {
        try {
            DBConnect dbConnect = new DBConnect();
            dao = new DAOBlog(dbConnect);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject jsonResponse = new JSONObject();

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                throw new IllegalStateException("User is not logged in.");
            }

            User loggedInUser = (User) session.getAttribute("user");
            int userId = loggedInUser.getUserId();

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String postType = request.getParameter("post_type");
            String status = request.getParameter("status");

            if (title == null || description == null || postType == null || status == null) {
                throw new IllegalArgumentException("One of the required parameters is missing.");
            }

            Part filePart = request.getPart("image");
            if (filePart == null) {
                throw new IllegalArgumentException("Image file part is missing.");
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            Post post = new Post();
            post.setTitle(title);
            post.setDescription(description);
            post.setPostType(postType);
            post.setStatus(status);
            post.setImage("uploads/" + fileName);
            post.setUserId(userId);

            if (dao == null) {
                throw new IllegalStateException("DAO object is not initialized.");
            }

            int postId = dao.insertPost(post);

            jsonResponse.put("status", "success");
            jsonResponse.put("postId", postId);
        } catch (SQLException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Error creating post: " + e.getMessage());
            e.printStackTrace();
        } catch (IllegalArgumentException | IllegalStateException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
            e.printStackTrace();
        }

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/newPost.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}