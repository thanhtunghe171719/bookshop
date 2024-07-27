package controllers;

import dal.DAOBlog;
import dal.DBConnect;
import models.Post;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.google.gson.Gson;
import jakarta.mail.Session;

@MultipartConfig
public class PostServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.isEmpty()) {
                listPosts(request, response);
            } else {
                switch (action) {
                    case "new":
                        request.setAttribute("post", new Post());
                        request.getRequestDispatcher("views/editPost.jsp").forward(request, response);
                        break;
                    case "edit":
                        String postIdStr = request.getParameter("post_id");
                        if (postIdStr != null && !postIdStr.isEmpty()) {
                            int postId = Integer.parseInt(postIdStr);
                            Post post = dao.getPostById(postId);
                            request.setAttribute("post", post);
                            request.getRequestDispatcher("views/editPost.jsp").forward(request, response);
                        } else {
                            response.sendRedirect("managerpost");
                        }
                        break;
                    case "delete":
                        handleDeleteRequest(request, response);
                        break;
                    case "toggleStatus":
                        handleToggleStatusRequest(request, response);
                        break;
                    default:
                        listPosts(request, response);
                        break;
                }
            }
        } catch (NumberFormatException | SQLException ex) {
            Logger.getLogger(PostServlet.class.getName()).log(Level.SEVERE, null, ex);
            throw new ServletException(ex);
        }
    
}
    private void handleDeleteRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String postIdStr = request.getParameter("post_id");
        if (postIdStr == null || postIdStr.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Post ID is missing!\"}");
            return;
        }

        try {
            int postId = Integer.parseInt(postIdStr);
            dao.deletePost(postId);
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Post deleted successfully!\"}");
        } catch (NumberFormatException | SQLException ex) {
            Logger.getLogger(PostServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error deleting post!\"}");
        }
    }

    private void handleToggleStatusRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String postIdStr = request.getParameter("post_id");
        if (postIdStr == null || postIdStr.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Post ID is missing!\"}");
            return;
        }

        try {
            int postId = Integer.parseInt(postIdStr);
            dao.toggleStatus(postId);
            Post updatedPost = dao.getPostById(postId);
            String newStatus = updatedPost.getStatus();
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Post status updated successfully!\", \"newStatus\":\"" + newStatus + "\", \"postId\":\"" + postId + "\"}");
        } catch (NumberFormatException | SQLException ex) {
            Logger.getLogger(PostServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error toggling post status!\"}");
        }
    }

    private void listPosts(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String sortOrder = request.getParameter("sortOrder");

        // Truyền tham số sortOrder cho DAO method
        List<Post> posts = dao.searchAndSortPosts(title, category, status, sortOrder);
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("views/managerPost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("toggleStatus".equals(action)) {
            handleToggleStatusRequest(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteRequest(request, response);
        } else if ("new".equals(action)) {
            try {
                createNewPost(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Error creating post!\"}");
            }
        } else if ("edit".equals(action)) {
            handleEditPost(request, response);
        }
    }

    private void handleEditPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postIdStr = request.getParameter("post_id");
        if (postIdStr == null || postIdStr.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Post ID is missing!\"}");
            return;
        }

        try {
            int postId = Integer.parseInt(postIdStr);
            Post post = dao.getPostById(postId);
            if (post == null) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Post not found!\"}");
                return;
            }

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String postType = request.getParameter("post_type");
            String status = request.getParameter("status");

            post.setTitle(title);
            post.setDescription(description);
            post.setPostType(postType);
            post.setStatus(status);

            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();

            if (fileName != null && !fileName.isEmpty()) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                post.setImage("uploads/" + fileName);
            }

            dao.updatePost(post);
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Post updated successfully!\"}");
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid post ID!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error updating post!\"}");
        }
    }

    private void createNewPost(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String postType = request.getParameter("post_type");
        String status = request.getParameter("status");
        String image = request.getParameter("image");

        Post post = new Post();
        post.setTitle(title);
        post.setDescription(description);
        post.setPostType(postType);
        post.setStatus(status);
        post.setImage(image);

        int postId = generateUniquePostId();
        post.setPostId(postId);

        dao.insertPost(post);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"status\":\"success\", \"message\":\"Post created successfully!\", \"postId\":" + postId + "}");
    }

    private int generateUniquePostId() throws SQLException {
        Random random = new Random();
        int postId;
        do {
            postId = random.nextInt(100000); // Generate random ID between 0 and 99999
        } while (dao.postIdExists(postId));
        return postId;
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("post_id"));

        try {
            Post post = dao.getPostById(postId);
            post.setStatus(post.getStatus().equals("Show") ? "Hide" : "Show");
            dao.updatePost(post);
            request.setAttribute("STATUS", "Post status updated successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("STATUS", "Error toggling status!");
        }

        response.sendRedirect("managerpost");
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("post_id"));

        try {
            dao.deletePost(postId);
            request.setAttribute("STATUS", "Post deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("STATUS", "Error deleting post!");
        }

        response.sendRedirect("managerpost");
    }

    private int getNextPostId() {
        int nextPostId = 0;
        try {
            nextPostId = dao.getNextPostId(); // Implement this method in DAOBlog class
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
        return nextPostId;
    }

}