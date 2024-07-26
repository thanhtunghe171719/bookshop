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

    String searchQuery = request.getParameter("search");
    String pageIndexParam = request.getParameter("page");
    String sortField = request.getParameter("sortField");
    String sortOrder = request.getParameter("sortOrder");
    String category = request.getParameter("category");
    String status = request.getParameter("status");

   
    if (sortOrder == null || sortOrder.isEmpty()) {
        sortOrder = "desc";
    }

    int pageIndex = (pageIndexParam == null || pageIndexParam.isEmpty()) ? 1 : Integer.parseInt(pageIndexParam);
    int pageSize = 5;

    List<Post> posts = null;
    int totalPosts = 0;

    try {
        if (searchQuery != null && !searchQuery.isEmpty()) {
            totalPosts = daoBlog.getTotalPostsBySearch(searchQuery);
            posts = daoBlog.searchPosts(searchQuery, pageIndex, pageSize, sortOrder);
        } else if (category != null && !category.isEmpty()) {
            totalPosts = daoBlog.getTotalPostsByCategory(category);
            posts = daoBlog.getPostsByCategory(category, pageIndex, pageSize, sortField, sortOrder);
        } else {
            totalPosts = daoBlog.getTotalPosts();
            posts = daoBlog.getPosts(pageIndex, pageSize, sortField, sortOrder);
        }
    } catch (SQLException ex) {
        Logger.getLogger(BlogServlet.class.getName()).log(Level.SEVERE, null, ex);
    }

    List<String> postCategories = daoBlog.getPostCategories();
    int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

    request.setAttribute("posts", posts);
    request.setAttribute("postCategories", postCategories);
    request.setAttribute("totalPosts", totalPosts);
    request.setAttribute("pageSize", pageSize);
    request.setAttribute("currentPage", pageIndex);
    request.setAttribute("sortField", sortField);
    request.setAttribute("sortOrder", sortOrder);

    request.getRequestDispatcher("views/blog.jsp").forward(request, response);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}