/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOCart;
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
import models.Cart;
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
                String status = request.getParameter("status");
                String roleName = request.getParameter("role");
                String encryptOld = daoUsers.Sha256(password);
                logger.info("Adding user with details: fullname=" + fullname + ", gender=" + gender + ", email=" + email + ", phone=" + phone + ", password=" + password + ", role=" + roleName + "status=" + status);

                // Validation
                String namePattern = "^[\\p{L}\\s]+$"; // Allow Unicode letters and spaces
                String phonePattern = "^\\d{10}$";
                String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"; // Minimum 8 characters, at least one letter, one number and one special character

                if (fullname == null || fullname.trim().isEmpty() || !fullname.matches(namePattern)) {
                    out.print("{\"status\":\"error\",\"message\":\"Full name must contain only letters and spaces and must not be empty.\"}");
                    return;
                }

                if (phone == null || phone.trim().isEmpty() || !phone.matches(phonePattern)) {
                    out.print("{\"status\":\"error\",\"message\":\"Phone number must be exactly 10 digits.\"}");
                    return;
                }
                if (password == null || password.trim().isEmpty() || !password.matches(passwordPattern)) {
                    out.print("{\"status\":\"error\",\"message\":\"Password must be at least 8 characters long and include at least one letter, one number, and one special character.\"}");
                    return;
                }

                User user = new User(fullname, gender, email, encryptOld, phone, status, roleName);
                if (daoUsers.addUsers(user)) {
                    DAOCart dao = new DAOCart();
                    Cart cart = new Cart();
                    User usernew = daoUsers.getUserByUsername(email);
                    cart.setUserId(usernew.getUserId());
                    dao.insert(cart);
                    out.print("{\"status\":\"success\"}");
                } else {
                    out.print("{\"status\":\"error\",\"message\":\"Failed to add user\"}");
                }
            } else if ("edit".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("user_id"));
                String fullname = request.getParameter("fullname");
                String gender = request.getParameter("gender");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String status = request.getParameter("status");
                String roleName = request.getParameter("role");
                String namePattern = "^[\\p{L}\\s]+$"; // Allow Unicode letters and spaces
                String phonePattern = "^\\d{10}$";

                if (fullname == null || fullname.trim().isEmpty() || !fullname.matches(namePattern)) {
                    out.print("{\"status\":\"error\",\"message\":\"Full name must contain only letters and spaces and must not be empty.\"}");
                    return;
                }

                if (phone == null || phone.trim().isEmpty() || !phone.matches(phonePattern)) {
                    out.print("{\"status\":\"error\",\"message\":\"Phone number must be exactly 10 digits.\"}");
                    return;
                }
               
                User user = new User(fullname, userId, gender, email, phone, roleName, status);
                user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
                boolean isUpdated = daoUsers.updateUsers(user);

                if (isUpdated) {
                    out.print("{\"status\":\"success\"}");
                } else {
                    out.print("{\"status\":\"error\",\"message\":\"Failed to edit user\"}");
                }
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

    @Override
    public String getServletInfo() {
        return "User management servlet";
    }
}
