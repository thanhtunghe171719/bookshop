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
import models.UserHistory;

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
        String userIdParam = request.getParameter("userId"); // Get userId from URL
        if (userIdParam != null) {
            try {
                int userId = Integer.parseInt(userIdParam);
                User user = daoUsers.getUserById(userId); // Fetch the user based on userId
                List<UserHistory> historyList = daoUsers.getUserHistory(userId); // Fetch user history from the database

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
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        User user = new User(userId, fullname, gender, email, phone, address);

        String jdbcURL = "jdbc:mysql://localhost:3306/checksql";
        String dbUser = "root";
        String dbPassword = "12345";

        String query = "UPDATE Users SET fullname = ?, gender = ?, email = ?, phone = ?, address = ? WHERE user_Id = ?";

        try ( Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);  PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, user.getFullname());
            statement.setString(2, user.getGender());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getAddress());
            statement.setInt(6, user.getUserId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("message", "Changes saved successfully.");
            } else {
                request.setAttribute("error", "Failed to save changes.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
