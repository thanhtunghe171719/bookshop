package controllers;

import dal.DAOBlog;
import dal.DBConnect;
import models.Post;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kobietkolam
 */
@WebServlet(name = "BlogServlet", urlPatterns = {"/blog"})
public class BlogServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DAOBlog daoBlog;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBConnect dbConnect = new DBConnect();
        DAOBlog daoBlog = null;
        try {
            daoBlog = new DAOBlog(dbConnect);
        } catch (SQLException ex) {
            Logger.getLogger(BlogServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Get sort order
        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "desc";
        }

        // Get current page and page size
        int pageSize = 5; // Number of posts per page
        int currentPage = 1; // Default to the first page
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        // Get search query
        String searchQuery = request.getParameter("search");

        // Retrieve total number of posts
        int totalPosts = daoBlog.getTotalPosts();

        // Calculate total number of pages
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        // Retrieve posts based on current page and search query
        List<Post> posts = null;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            posts = daoBlog.searchPosts(searchQuery, currentPage, pageSize, sortOrder);
        } else {
            posts = daoBlog.getPosts(currentPage, pageSize, sortOrder);
        }

        // Retrieve post categories
        List<String> postCategories = daoBlog.getPostCategories();

        // Set request attributes
        request.setAttribute("posts", posts);
        request.setAttribute("postCategories", postCategories);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("sortOrder", sortOrder);

        // Forward the request to the JSP
        request.getRequestDispatcher("views/blog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
