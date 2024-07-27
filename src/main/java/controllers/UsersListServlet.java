/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOUsers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Logger;
import models.User;

public class UsersListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DAOUsers daoUsers;
    Logger logger = Logger.getLogger(UsersListServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        daoUsers = new DAOUsers();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");
        String pageIndexParam = request.getParameter("index");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        if (sortField == null || sortField.isEmpty()) {
            sortField = "fullname";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "asc";
        }

        int pageIndex = (pageIndexParam == null || pageIndexParam.isEmpty()) ? 1 : Integer.parseInt(pageIndexParam);
        int pageSize = 10;

        List<User> users;
        int totalUsers;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            users = daoUsers.searchUsersWithPagination(searchQuery.trim(), pageIndex, pageSize, sortField, sortOrder, gender, role, status);
            totalUsers = daoUsers.getUserCountWithSearch(searchQuery.trim(), gender, role, status);
        } else {
            users = daoUsers.getUsersWithPagination(pageIndex, pageSize, sortField, sortOrder, gender, role, status);
            totalUsers = daoUsers.getUserCount(gender, role, status);
        }

        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        request.setAttribute("users", users);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("gender", gender);
        request.setAttribute("role", role);
        request.setAttribute("status", status);

        // Generate the pagination URL with query parameters
        StringBuilder paginationUrl = new StringBuilder("UsersListServlet?");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            paginationUrl.append("search=").append(searchQuery).append("&");
        }
        if (sortField != null && !sortField.isEmpty()) {
            paginationUrl.append("sortField=").append(sortField).append("&");
        }
        if (sortOrder != null && !sortOrder.isEmpty()) {
            paginationUrl.append("sortOrder=").append(sortOrder).append("&");
        }
        if (gender != null && !gender.isEmpty()) {
            paginationUrl.append("gender=").append(gender).append("&");
        }
        if (role != null && !role.isEmpty()) {
            paginationUrl.append("role=").append(role).append("&");
        }
        if (status != null && !status.isEmpty()) {
            paginationUrl.append("status=").append(status).append("&");
        }
        String finalPaginationUrl = paginationUrl.toString();

        request.setAttribute("paginationUrl", finalPaginationUrl);

        request.getRequestDispatcher("views/userList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String fullname = request.getParameter("fullname");
                String gender = request.getParameter("gender");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String password = request.getParameter("password");
                String roleName = request.getParameter("role");

                logger.info("Adding user with details: fullname=" + fullname + ", gender=" + gender + ", email=" + email + ", phone=" + phone + ", role=" + roleName);

                if (isValidInput(fullname, gender, email, phone, password, roleName)) {
                    User user = new User(fullname, gender, email, password, phone,  "Active");
                    if (daoUsers.addUser(user)) {
                        out.print("{\"status\":\"success\"}");
                    } else {
                        out.print("{\"status\":\"error\",\"message\":\"Failed to add user\"}");
                    }
                } else {
                    logger.warning("Invalid input data for adding user.");
                    out.print("{\"status\":\"error\",\"message\":\"Invalid input data\"}");
                }
            } else if ("edit".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("user_id"));
                String fullname = request.getParameter("fullname");
                String gender = request.getParameter("gender");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String status = request.getParameter("status");
                User user = new User(userId, fullname, gender, email, phone, status);
                user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
                daoUsers.updateCustomer(user);
                out.print("{\"status\":\"success\"}");
            } else if ("delete".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("user_id"));
                daoUsers.softDeleteUser(userId);
                out.print("{\"status\":\"success\"}");
            } else {
                out.print("{\"status\":\"error\",\"message\":\"Invalid action\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }

    private boolean isValidInput(String... inputs) {
        for (String input : inputs) {
            if (input == null || input.trim().isEmpty()) {
                return false;
            }
        }
        return true;
    }

    @Override
    public String getServletInfo() {
        return "User management servlet";
    }
}