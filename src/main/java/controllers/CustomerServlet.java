package controllers;

import dal.DAOUsers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.User;

public class CustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DAOUsers daoUsers;
    Logger logger = Logger.getLogger(CustomerServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        daoUsers = new DAOUsers();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");
        String pageIndexParam = request.getParameter("index");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");

        // Đặt giá trị mặc định nếu sortField hoặc sortOrder bị bỏ trống
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
            users = daoUsers.searchCustomerWithPagination(searchQuery.trim(), pageIndex, pageSize, sortField, sortOrder);
            totalUsers = daoUsers.getCustomerCountWithSearch(searchQuery.trim());
        } else {
            users = daoUsers.getCustomersWithPagination(pageIndex, pageSize, sortField, sortOrder);
            totalUsers = daoUsers.getCustomerCount();
        }

        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        request.setAttribute("users", users);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", pageIndex);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("views/customerList.jsp").forward(request, response);
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
                // Kiểm tra điều kiện mật khẩu
                if (!isValidPassword(password)) {
                    out.print("{\"status\":\"error\",\"message\":\"Invalid password format.\"}");
                    return;
                }
                String encryptOld = daoUsers.Sha256(password);
                // Kiểm tra điều kiện số điện thoại
                if (!isValidPhoneNumber(phone)) {
                    out.print("{\"status\":\"error\",\"message\":\"Phone number must be 10 digits.\"}");
                    return;
                }
                User user = new User(fullname, gender, email, encryptOld, phone, "Active");
                user.setRoleId(4);
                daoUsers.addUser(user);
                out.print("{\"status\":\"success\"}");
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

    private boolean isValidPassword(String password) {
        return password.length() >= 8 && password.matches(".*[a-zA-Z].*") && password.matches(".*\\d.*") && password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*");
    }

// Phương thức kiểm tra số điện thoại hợp lệ
    private boolean isValidPhoneNumber(String phone) {
        return phone.matches("\\d{10}");
    }

    @Override
    public String getServletInfo() {
        return "Customer management servlet";
    }
}