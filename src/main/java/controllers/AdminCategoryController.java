/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOCategories;
import dal.DAOCategories;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Book;
import models.Categorie;
import models.Categories;


@WebServlet(name = "AdminCategoryController", urlPatterns = {"/admin-category"})
public class AdminCategoryController extends HttpServlet {
private static final long serialVersionUID = 1L;
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MarketingProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarketingProductController at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        DAOCategories categoryDao = new DAOCategories();
        int page = 1;
        int pageSize = 10;
        switch (action) {
            case "view":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Categorie category = categoryDao.getById(id);
                    if (category != null) {
                        request.setAttribute("category", category);
                        request.getRequestDispatcher("./views/viewcategory.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("admin-category?error=Category not found");
                    }
                } catch (Exception e) {
                    response.sendRedirect("admin-category?error=Id is not valid");
                    System.out.println("View: " + e);
                }
                break;
            case "add":
                request.getRequestDispatcher("./views/addcategory.jsp").forward(request, response);
                break;
            case "edit":
                try {
                    int categoryId = Integer.parseInt(request.getParameter("id"));
                    Categorie existingCategory = categoryDao.getById(categoryId);
                    request.setAttribute("category", existingCategory);
                    request.getRequestDispatcher("./views/editcategory.jsp").forward(request, response);
                } catch (Exception e) {
                    response.sendRedirect("admin-category?error=Category not found");
                }
                break;
            case "delete":
                try {
                    int categoryId = Integer.parseInt(request.getParameter("id"));
                    int result = categoryDao.deleteCategory(categoryId);
                    if (result > 0) {
                        response.sendRedirect("admin-category?success=Delete successfully");
                    } else {
                        response.sendRedirect("admin-category?error=Delete fail");
                    }
                } catch (Exception e) {
                    response.sendRedirect("admin-category?error=Id is not valid");
                }
                break;
            default:
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                String categoryName = request.getParameter("categoryName");
                categoryName = categoryName != null ? categoryName.trim() : "";
                List<Categorie> categories = categoryDao.getCategories(categoryName, page, pageSize);
                int totalCategories = categoryDao.getCategoryCount(categoryName);
                int totalPages = (int) Math.ceil(totalCategories / (double) pageSize);

                request.setAttribute("categoryName", categoryName);
                request.setAttribute("categories", categories);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.getRequestDispatcher("./views/listcategory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "add":
                this.addCategory(request, response);
                break;
            case "edit":
                this.editCategory(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DAOCategories categoryDao = new DAOCategories();
        try {
            Map<String, String> errors = validateInput(request);
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("formData", request.getParameterMap());
                request.getRequestDispatcher("./views/addcategory.jsp").forward(request, response);
                return;
            }
            String categoryName = request.getParameter("categoryName");
            String image = request.getParameter("image");
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());
            Timestamp updatedAt = null;

            Categorie category = new Categorie(0, categoryName, image, createdAt, updatedAt);
            int result = categoryDao.addCategory(category);
            if (result > 0) {
                response.sendRedirect("admin-category?success=Add successfully");
            } else {
                response.sendRedirect("admin-category?error=Add fail");
            }
        } catch (Exception e) {
            System.out.println("Add error: " + e);
            response.sendRedirect("admin-category?error=Add fail");
        }
    }

    private void editCategory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DAOCategories categoryDao = new DAOCategories();
        try {
            Map<String, String> errors = validateInput(request);
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("formData", request.getParameterMap());
                request.getRequestDispatcher("./views/editcategory.jsp").forward(request, response);
                return;
            }
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String categoryName = request.getParameter("categoryName");
            String image = request.getParameter("image");
            Timestamp updatedAt = new Timestamp(System.currentTimeMillis());

            Categorie category = new Categorie(categoryId, categoryName, image, null, updatedAt);
            int result = categoryDao.updateCategory(category);
            if (result > 0) {
                response.sendRedirect("admin-category?success=Update successfully");
            } else {
                response.sendRedirect("admin-category?error=Update fail");
            }
        } catch (Exception e) {
            System.out.println("Update error: " + e);
            response.sendRedirect("admin-category?error=Update fail");
        }
    }

    private Map<String, String> validateInput(HttpServletRequest request) {
        Map<String, String> errors = new HashMap<>();
        String categoryName = request.getParameter("categoryName");
        if (categoryName == null || categoryName.trim().isEmpty()) {
            errors.put("categoryName", "Category name is required.");
        }
        return errors;
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