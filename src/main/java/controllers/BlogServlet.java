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

        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "desc";
        }

        int pageSize = 5; 
        int currentPage = 1; 
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        String searchQuery = request.getParameter("search");
        String category = request.getParameter("category");

        int totalPosts = 0;
        List<Post> posts = null;

        if (searchQuery != null && !searchQuery.isEmpty()) {
            try {
                totalPosts = daoBlog.getTotalPostsBySearch(searchQuery);
            } catch (SQLException ex) {
                Logger.getLogger(BlogServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            posts = daoBlog.searchPosts(searchQuery, currentPage, pageSize, sortOrder);
        } else if (category != null && !category.isEmpty()) {
            try {
                totalPosts = daoBlog.getTotalPostsByCategory(category);
            } catch (SQLException ex) {
                Logger.getLogger(BlogServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                posts = daoBlog.getPostsByCategory(category, currentPage, pageSize, sortOrder);
            } catch (SQLException ex) {
                Logger.getLogger(BlogServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            totalPosts = daoBlog.getTotalPosts();
            posts = daoBlog.getPosts(currentPage, pageSize, sortOrder);
        }

        List<String> postCategories = daoBlog.getPostCategories();

        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        request.setAttribute("posts", posts);
        request.setAttribute("postCategories", postCategories);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("views/blog.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}