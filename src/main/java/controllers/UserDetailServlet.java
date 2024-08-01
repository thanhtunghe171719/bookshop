package controllers;

import dal.DAOUsers;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.User;
import models.UserChangeHistory;

public class UserDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DAOUsers daoUsers;

    @Override
    public void init() throws ServletException {
        daoUsers = new DAOUsers(); // Khởi tạo DAOUsers
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        if (userIdParam != null) {
            try {
                int userId = Integer.parseInt(userIdParam);
                User user = daoUsers.getUserById(userId);
                List<UserChangeHistory> historyList = daoUsers.getUserChangeHistory(userId);

                request.setAttribute("user", user);
                request.setAttribute("historyList", historyList);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/userDetails.jsp");
                dispatcher.forward(request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId;
        try {
            userId = Integer.parseInt(request.getParameter("userId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            return;
        }

        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Fetch current user data from the database
        User oldUser = daoUsers.getUserById(userId);
        if (oldUser == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        // Ensure non-null fields retain their old values if not provided
        fullname = (fullname != null && !fullname.trim().isEmpty()) ? fullname : oldUser.getFullname();
        gender = (gender != null && !gender.trim().isEmpty()) ? gender : oldUser.getGender();
        email = (email != null && !email.trim().isEmpty()) ? email : oldUser.getEmail();
        phone = (phone != null && !phone.trim().isEmpty()) ? phone : oldUser.getPhone();
        address = (address != null && !address.trim().isEmpty()) ? address : oldUser.getAddress();

        User newUser = new User( fullname,userId, gender, email, phone, address);

        // Database update logic
        String jdbcURL = "jdbc:mysql://localhost:3306/bookshop";
        String dbUser = "root";
        String dbPassword = "1234";

        String updateQuery = "UPDATE Users SET fullname = ?, gender = ?, email = ?, phone = ?, address = ? WHERE user_id = ?";
        String insertHistoryQuery = "INSERT INTO UserChangeHistory (user_id, field_name, old_value, new_value) VALUES (?, ?, ?, ?)";

        try ( Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            connection.setAutoCommit(false);

            try ( PreparedStatement updateStatement = connection.prepareStatement(updateQuery);  PreparedStatement historyStatement = connection.prepareStatement(insertHistoryQuery)) {

                updateStatement.setString(1, newUser.getFullname());
                updateStatement.setString(2, newUser.getGender());
                updateStatement.setString(3, newUser.getEmail());
                updateStatement.setString(4, newUser.getPhone());
                updateStatement.setString(5, newUser.getAddress());
                updateStatement.setInt(6, newUser.getUserId());
                updateStatement.executeUpdate();

                saveChangeHistory(historyStatement, userId, "fullname", oldUser.getFullname(), newUser.getFullname());
                saveChangeHistory(historyStatement, userId, "gender", oldUser.getGender(), newUser.getGender());
                saveChangeHistory(historyStatement, userId, "email", oldUser.getEmail(), newUser.getEmail());
                saveChangeHistory(historyStatement, userId, "phone", oldUser.getPhone(), newUser.getPhone());
                saveChangeHistory(historyStatement, userId, "address", oldUser.getAddress(), newUser.getAddress());

                historyStatement.executeBatch();
                connection.commit();

                request.setAttribute("message", "Changes saved successfully.");
            } catch (SQLException e) {
                connection.rollback();
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database connection error: " + e.getMessage());
        }

        doGet(request, response);
    }

    private void saveChangeHistory(PreparedStatement statement, int userId, String fieldName, String oldValue, String newValue) throws SQLException {
        if (oldValue != null && newValue != null && !oldValue.equals(newValue)) {
            statement.setInt(1, userId);
            statement.setString(2, fieldName);
            statement.setString(3, oldValue);
            statement.setString(4, newValue);
            statement.addBatch();
        } else if (oldValue == null && newValue != null) {
            statement.setInt(1, userId);
            statement.setString(2, fieldName);
            statement.setString(3, "null");
            statement.setString(4, newValue);
            statement.addBatch();
        } else if (oldValue != null && newValue == null) {
            statement.setInt(1, userId);
            statement.setString(2, fieldName);
            statement.setString(3, oldValue);
            statement.setString(4, "null");
            statement.addBatch();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}