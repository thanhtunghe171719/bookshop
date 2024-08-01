/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import static com.mysql.cj.conf.PropertyKey.logger;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Vector;
import java.util.logging.Logger;
import java.util.logging.Level;
import models.Books;
import models.User;
import models.UserChangeHistory;
import models.UserHistory;
import models.UserRole;

/**
 *
 * @author TDG
 */
public class DAOUsers extends DBConnect {

//    public Vector<User> getAll(String sql) {
//        Vector<User> vector = new Vector<>();
//        try (Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); ResultSet rs = state.executeQuery(sql)) {
//            
//            while (rs.next()) {
//                User u = mapResultSetToUser(rs);
//                vector.add(u);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return vector;
//    }
    public int changePassWord(User obj) {
        int n = 0;

        String sql = "UPDATE users\n"
                + "SET\n"
                + "email = ?,\n"
                + "phone = ?,\n"
                + "password = ?,\n"
                + "role_id = ?,\n"
                + "fullname = ?,\n"
                + "gender = ?,\n"
                + "address = ?,\n"
                + "create_at = ?,\n"
                + "updated_at = ?\n"
                + "WHERE user_id = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setString(1, obj.getEmail());
            pre.setString(2, obj.getPhone());
            pre.setString(3, obj.getPassword());
            pre.setInt(4, obj.getRoleId());
            pre.setString(5, obj.getFullname());
            pre.setString(6, obj.getGender());
            pre.setString(7, obj.getAddress());
            pre.setTimestamp(8, obj.getCreateAt());
            pre.setTimestamp(9, obj.getUpdatedAt());
            pre.setInt(10, obj.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public User getUserByUsername(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("password"),
                            rs.getInt("role_id"),
                            rs.getString("fullname"),
                            rs.getString("gender"),
                            rs.getString("address"),
                            rs.getTimestamp("create_at"),
                            rs.getTimestamp("updated_at"),
                            rs.getString("image"),
                            rs.getString("status"),
                            ""
                    );
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;

    }

    public boolean isAccountActive(User user) {
        return "active".equalsIgnoreCase(user.getStatus());
    }

    public boolean addUser(User user) {
        String query = "INSERT INTO users (email, phone, password, role_id, fullname, gender, address, create_at, updated_at, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getPassword() != null ? user.getPassword() : "defaultPassword");  // Handle default or null password
            ps.setInt(4, user.getRoleId());
            ps.setString(5, user.getFullname());
            ps.setString(6, user.getGender());
            ps.setString(7, user.getAddress() != null ? user.getAddress() : "");  // Handle default or null address
            ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            ps.setString(10, user.getImage() != null ? user.getImage() : "");  // Handle default or null image
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET fullname = ?, gender = ?, address = ?, phone = ?, image = ?, updated_at = ? WHERE user_id = ?";
        try ( PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setString(1, user.getFullname());
            ptm.setString(2, user.getGender());
            ptm.setString(3, user.getAddress());
            ptm.setString(4, user.getPhone());
            ptm.setString(5, user.getImage());
            ptm.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            ptm.setInt(7, user.getUserId());
            ptm.executeUpdate();
        }
    }

    public void updateCustomer(User user) {
        String sql = "UPDATE users SET fullname=?, gender=?, email=?, phone=?, status=?, updated_at=?, address =? WHERE user_id=? ";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, user.getFullname());
            preparedStatement.setString(2, user.getGender());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getStatus());
            preparedStatement.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            preparedStatement.setString(7, user.getAddress() != null ? user.getAddress() : "");
            preparedStatement.setInt(8, user.getUserId());

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Update successful.");
            } else {
                System.out.println("Update failed, no rows affected.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int updateUserPassword(int userId, String password) {
        String sql = "UPDATE users SET password=?, updated_at = ? WHERE user_id = ?";
        try ( PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setString(1, password);
            ptm.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ptm.setInt(3, userId);
            return ptm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update password: " + e);
        }
        return 0;
    }

    public int updateStatusUser(int userId, int status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";
        try ( PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setInt(1, status);
            ptm.setInt(2, userId);
            return ptm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update password: " + e);
        }
        return 0;
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try ( PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setInt(1, userId);
            try ( ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                } else {
                    System.out.println("User not found with ID: " + userId);

                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //////////////////
    public ArrayList<User> getAll(String sql) {
        ArrayList<User> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {

                int userId = rs.getInt("user_id");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String password = rs.getString("password");
                int roleId = rs.getInt("role_id");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String image = rs.getString("image");
                String address = rs.getString("address");
                java.sql.Timestamp createdAt = new java.sql.Timestamp(System.currentTimeMillis());
                java.sql.Timestamp updatedAt = new java.sql.Timestamp(System.currentTimeMillis());
                String status = rs.getString("status");
                String deleted = rs.getString("deleted");

                User c = new User(userId, email, phone, password, roleId, fullname, gender, address, createdAt, updatedAt, image, status, deleted);
                list.add(c);

            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int update(User obj) {
        int n = 0;

        String sql = "UPDATE users\n"
                + "SET\n"
                + "email = ?,\n"
                + "phone = ?,\n"
                + "password = ?,\n"
                + "role_id = ?,\n"
                + "fullname = ?,\n"
                + "gender = ?,\n"
                + "address = ?,\n"
                + "create_at = ?,\n"
                + "updated_at = ?,\n"
                + "image = ?,\n"
                + "status = ?,\n"
                + "deleted = ?\n"
                + "WHERE user_id = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setString(1, obj.getEmail());
            pre.setString(2, obj.getPhone());
            pre.setString(3, obj.getPassword());
            pre.setInt(4, obj.getRoleId());
            pre.setString(5, obj.getFullname());
            pre.setString(6, obj.getGender());
            pre.setString(7, obj.getAddress());
            pre.setTimestamp(8, obj.getCreateAt());
            pre.setTimestamp(9, obj.getUpdatedAt());
            pre.setString(10, obj.getImage());
            pre.setString(11, obj.getStatus());
            pre.setString(12, obj.getDeleted());
            pre.setInt(13, obj.getUserId());
            n = pre.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public void softDeleteUser(int userId) {
        String sql = "UPDATE users SET deleted = 'yes' WHERE user_id = ?";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Soft delete successful.");
            } else {
                System.out.println("Soft delete failed, no rows affected.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /*  public List<User> getActiveUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE deleted = 'no' AND role_id = 2";
        try ( PreparedStatement pstmt = conn.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getInt("role_id"),
                        rs.getString("fullname"),
                        rs.getString("gender"),
                        rs.getString("address"),
                        rs.getTimestamp("create_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getString("deleted")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }*/
    public List<User> searchUsersByName(String name) {

        String sql = "SELECT * FROM Users WHERE fullname LIKE ? LIMIT ?, ?";
        List<User> users = new ArrayList<>();
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(new User(rs.getInt("user_id"), rs.getString("fullname"), rs.getString("gender"),
                        rs.getString("email"), rs.getString("phone"), rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> getUsers(int currentPage, int usersPerPage) {
        int start = (currentPage - 1) * usersPerPage;
        String sql = "SELECT * FROM Users LIMIT ?, ?";
        List<User> users = new ArrayList<>();
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, start);
            ps.setInt(2, usersPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(new User(rs.getInt("user_id"), rs.getString("fullname"), rs.getString("gender"),
                        rs.getString("email"), rs.getString("phone"), rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public int countUsersByName(String name) {
        String sql = "SELECT COUNT(*) FROM Users WHERE fullname LIKE ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countAllUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE deleted = 'no'";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String status = rs.getString("status");
                String address = rs.getString("address");
                Timestamp updatedAt = rs.getTimestamp("updated_at");

                if ("no".equals(rs.getString("deleted"))) {
                    User user = new User(userId, fullname, gender, email, phone, status, address, updatedAt);
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<UserHistory> getUserHistory(int userId) {
        List<UserHistory> historyList = new ArrayList<>();
        String query = "SELECT * FROM UserHistory WHERE userId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    historyList.add(new UserHistory(
                            rs.getInt("historyId"),
                            rs.getInt("userId"),
                            rs.getString("updatedDate"),
                            rs.getString("updatedBy"),
                            rs.getString("email"),
                            rs.getString("fullname"),
                            rs.getString("gender"),
                            rs.getString("address")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historyList;
    }

    public int updateUserDetail(User user) {
        String query = "UPDATE Users SET fullname = ?, gender = ?, email = ?, phone = ?, address = ? WHERE userId = ?";
        int rowsAffected = 0;
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getGender());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getUserId());

            rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Save history record
                String historyQuery = "INSERT INTO UserHistory (userId, updatedDate, updatedBy, email, fullname, gender, address) VALUES (?, NOW(), ?, ?, ?, ?, ?)";
                try ( PreparedStatement historyPs = conn.prepareStatement(historyQuery)) {
                    historyPs.setInt(1, user.getUserId());
                    historyPs.setString(2, "Admin"); // Assuming 'Admin' is making the change, replace with actual user if needed
                    historyPs.setString(3, user.getEmail());
                    historyPs.setString(4, user.getFullname());
                    historyPs.setString(5, user.getGender());
                    historyPs.setString(6, user.getAddress());
                    historyPs.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowsAffected;
    }

    //Customer
    private User extractCustomerFromResultSet(ResultSet rs) throws SQLException {
        int userId = rs.getInt("user_id");
        String fullname = rs.getString("fullname");
        String gender = rs.getString("gender");
        String email = rs.getString("email");
        String phone = rs.getString("phone");
        String password = rs.getString("password");
        String address = rs.getString("address");
        String image = rs.getString("image");
        String status = rs.getString("status");
        Timestamp createdAt = rs.getTimestamp("create_at");
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        //String roleName = rs.getString("role_name"); 

        User user = new User(userId, fullname, gender, email, phone, status);
        user.setPassword(password);
        user.setAddress(address);
        user.setImage(image);
        user.setCreateAt(createdAt);
        user.setUpdatedAt(updatedAt);
        // user.setRoleName(roleName);
        return user;
    }

    public List<UserChangeHistory> getUserChangeHistory(int userId) {
        List<UserChangeHistory> historyList = new ArrayList<>();
        String query = "SELECT * FROM UserChangeHistory WHERE user_id = ? ORDER BY updated_date DESC";

        try ( PreparedStatement statement = conn.prepareStatement(query)) {

            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String fieldName = resultSet.getString("field_name");
                String oldValue = resultSet.getString("old_value");
                String newValue = resultSet.getString("new_value");
                Timestamp updatedDate = resultSet.getTimestamp("updated_date");

                UserChangeHistory history = new UserChangeHistory(userId, fieldName, oldValue, newValue, updatedDate);
                historyList.add(history);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return historyList;
    }

    public List<User> getCustomersWithPagination(int pageIndex, int pageSize, String sortField, String sortOrder) {
        String query = "SELECT * FROM users WHERE deleted = 'no' AND role_id = '4' ORDER BY "
                + (sortField != null ? sortField : "fullname") + " "
                + (sortOrder != null ? sortOrder : "asc") + " LIMIT ? OFFSET ?";
        List<User> users = new ArrayList<>();
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, (pageIndex - 1) * pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(extractCustomerFromResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return users;
    }

    public List<User> searchCustomerWithPagination(String searchQuery, int pageIndex, int pageSize, String sortField, String sortOrder) {
        String query = "SELECT * FROM users WHERE fullname LIKE ? AND deleted = 'no' AND role_id = '4' ORDER BY "
                + (sortField != null ? sortField : "fullname") + " "
                + (sortOrder != null ? sortOrder : "asc") + " LIMIT ? OFFSET ?";
        List<User> users = new ArrayList<>();
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + searchQuery + "%");
            ps.setInt(2, pageSize);
            ps.setInt(3, (pageIndex - 1) * pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(extractCustomerFromResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return users;
    }

    public int getCustomerCount() {
        String query = "SELECT COUNT(*) FROM users WHERE deleted = 'no' AND role_id = '4'";
        try ( PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

public int getCustomerCountByMonth(int month) {
    String sql = "SELECT COUNT(*) FROM users WHERE deleted = 'no' AND role_id = '4' AND MONTH(create_at) = ?";
    try (
            PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, month); // Set the month parameter
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) { // Use if since you're expecting one result
                return rs.getInt(1);
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0;
}

    
    public int getCustomerCountWithSearch(String searchQuery) {
        String query = "SELECT COUNT(*) FROM users WHERE fullname LIKE ? AND deleted = 'no' AND role_id = '4'";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + searchQuery + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

//User
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        int userId = rs.getInt("user_id");
        String fullname = rs.getString("fullname");
        String gender = rs.getString("gender");
        String email = rs.getString("email");
        String phone = rs.getString("phone");
        String password = rs.getString("password");
        String address = rs.getString("address");
        String image = rs.getString("image");
        String status = rs.getString("status");
        Timestamp createdAt = rs.getTimestamp("create_at");
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        int roleId = rs.getInt("role_id"); // Get role_id
        String roleName = rs.getString("role_name"); // Get role_name

        User user = new User(userId, fullname, gender, email, phone, status);
        user.setPassword(password);
        user.setAddress(address);
        user.setImage(image);
        user.setCreateAt(createdAt);
        user.setUpdatedAt(updatedAt);
        user.setRoleId(roleId); // Set role_id
        user.setRoleName(roleName); // Set role_name
        return user;
    }

    public List<User> getUsersWithPagination(int pageIndex, int pageSize, String sortField, String sortOrder, String gender, String role, String status) {
        String query = "SELECT u.*, r.role_name FROM users u JOIN roles r ON u.role_id = r.role_id "
                + "WHERE u.deleted = 'no' AND u.role_id != 1 "
                + (gender != null && !gender.isEmpty() ? "AND u.gender = ? " : "")
                + (role != null && !role.isEmpty() ? "AND r.role_name = ? " : "")
                + (status != null && !status.isEmpty() ? "AND u.status = ? " : "")
                + "ORDER BY " + (sortField != null ? sortField : "u.fullname") + " "
                + (sortOrder != null ? sortOrder : "asc") + " LIMIT ? OFFSET ?";
        List<User> users = new ArrayList<>();
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            int paramIndex = 1;
            if (gender != null && !gender.isEmpty()) {
                ps.setString(paramIndex++, gender);
            }
            if (role != null && !role.isEmpty()) {
                ps.setString(paramIndex++, role);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex, (pageIndex - 1) * pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return users;
    }

    public List<User> searchUsersWithPagination(String searchQuery, int pageIndex, int pageSize, String sortField, String sortOrder, String gender, String role, String status) {
        String query = "SELECT u.*, r.role_name FROM users u JOIN roles r ON u.role_id = r.role_id "
                + "WHERE u.fullname LIKE ? AND u.deleted = 'no' AND u.role_id != 1 "
                + (gender != null && !gender.isEmpty() ? "AND u.gender = ? " : "")
                + (role != null && !role.isEmpty() ? "AND r.role_name = ? " : "")
                + (status != null && !status.isEmpty() ? "AND u.status = ? " : "")
                + "ORDER BY " + (sortField != null ? sortField : "u.fullname") + " "
                + (sortOrder != null ? sortOrder : "asc") + " LIMIT ? OFFSET ?";
        List<User> users = new ArrayList<>();
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + searchQuery + "%");
            int paramIndex = 2;
            if (gender != null && !gender.isEmpty()) {
                ps.setString(paramIndex++, gender);
            }
            if (role != null && !role.isEmpty()) {
                ps.setString(paramIndex++, role);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex, (pageIndex - 1) * pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return users;
    }

    public int getUserCount(String gender, String role, String status) {
        String query = "SELECT COUNT(*) FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.deleted = 'no' AND u.role_id != 1"
                + (gender != null && !gender.isEmpty() ? "AND u.gender = ? " : "")
                + (role != null && !role.isEmpty() ? "AND r.role_name = ? " : "")
                + (status != null && !status.isEmpty() ? "AND u.status = ? " : "");
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            int paramIndex = 1;
            if (gender != null && !gender.isEmpty()) {
                ps.setString(paramIndex++, gender);
            }
            if (role != null && !role.isEmpty()) {
                ps.setString(paramIndex++, role);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int getUserCountWithSearch(String searchQuery, String gender, String role, String status) {
        String query = "SELECT COUNT(*) FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.fullname LIKE ? AND u.deleted = 'no' AND u.role_id != 1 "
                + (gender != null && !gender.isEmpty() ? "AND u.gender = ? " : "")
                + (role != null && !role.isEmpty() ? "AND r.role_name = ? " : "")
                + (status != null && !status.isEmpty() ? "AND u.status = ? " : "");
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + searchQuery + "%");
            int paramIndex = 2;
            if (gender != null && !gender.isEmpty()) {
                ps.setString(paramIndex++, gender);
            }
            if (role != null && !role.isEmpty()) {
                ps.setString(paramIndex++, role);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public boolean updateUsers(User user) {
        // Truy vấn để lấy role_id từ role_name
        String getRoleIdQuery = "SELECT role_id FROM roles WHERE role_name = ?";
        try ( PreparedStatement ps = conn.prepareStatement(getRoleIdQuery)) {
            ps.setString(1, user.getRoleName());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user.setRoleId(rs.getInt("role_id"));
            } else {
                // Nếu không tìm thấy role_name trong bảng roles, trả về false
                return false;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }

        // Truy vấn để cập nhật user trong bảng users
        String query = "UPDATE users SET fullname = ?, gender = ?, email = ?, phone = ?,  role_id = ?,status = ?, updated_at = ? WHERE user_id = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getGender());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setInt(5, user.getRoleId());
            ps.setString(6, user.getStatus());
            ps.setTimestamp(7, user.getUpdatedAt());
            ps.setInt(8, user.getUserId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean addUsers(User user) {
        // Query to find the role_id based on the role_name
        String getRoleIdQuery = "SELECT role_id FROM roles WHERE role_name = ?";
        try ( PreparedStatement ps = conn.prepareStatement(getRoleIdQuery)) {
            ps.setString(1, user.getRoleName());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user.setRoleId(rs.getInt("role_id"));
            } else {
                // If role_name not found, return false
                return false;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }

        // Query to insert a new user into the users table
        String query = "INSERT INTO users (fullname, gender, email, phone, password, status, role_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getGender());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getStatus());
            ps.setInt(7, user.getRoleId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<UserRole> getAllRoles() {
        List<UserRole> roles = new ArrayList<>();
        String sql = "SELECT * FROM roles";
        try ( Statement stmt = conn.createStatement();  ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                UserRole role = new UserRole();
                role.setRole_id(rs.getInt("role_id"));
                role.setRole_name(rs.getString("role_name"));
                role.setStatus_id(rs.getInt("status_id"));
                role.setCreate_at(rs.getTimestamp("create_at"));
                role.setUpdated_at(rs.getTimestamp("updated_at"));
                roles.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    public static void main(String[] args) {
        DAOUsers dao = new DAOUsers();
        // User user = dao.getAll("SELECT * FROM users where email = 'thanhtung2733@gmail.com';").get(0);
        //System.out.println(user);
        //user.setPassword("12345678Tung!");
        //if (dao.update(user) > 0) {
        //  System.out.println("ok");
        //} else {
        //  System.out.println("not ok");
        //}

        // User u = new User("Nguyễn Văn Nam", "Nữ", "nguyen.van.nam@gmail.com", "123456781", "password1", "Active");
        //u.setRoleId(4);
        // System.out.println(u);
        //dao.addUser(u);
        //User u = new User("Tom", "Nữ", "tom@gmail.com", "123456781", "password1", "Active");
        // Kiểm tra phương thức searchUsersWithPagination
      // Test data
        int userId = 130; // Example user ID
        String fullname = "Duy";
        String gender = "Nữ";
        String email = "duy@gmail.com";
        String phone = "1234567891";
        String status = "active";
        String roleName = "Customer";

        // Construct the user object with updated information
        User user = new User(fullname,  gender,userId, email, phone, roleName, status);
        user.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        // Try to update the user
        boolean isUpdated = dao.updateUsers(user);

        // Output the result
        if (isUpdated) {
            System.out.println("User updated successfully.");
        } else {
            System.out.println("Failed to update user.");
        }
        

        // Test getUsersWithPagination method
        //List<User> usersPage1 = dao.getUsersWithPagination(1, 10);
        //System.out.println("Users (Page 1):");
        //for (User user : usersPage1) {
        //  System.out.println(user);
        //}
        // Test searchUsersWithPagination method
        // List<User> searchResults = dao.searchUsersWithPagination("John", 1, 10);
        // System.out.println("Search Results:");
        // for (User user : searchResults) {
        //  System.out.println(user);
        // }
        // Test getUserCount method
        // int userCount = dao.getUserCount();
        //System.out.println("Total Users: " + userCount);
        // Test getUserCountWithSearch method
        //int searchUserCount = dao.getUserCountWithSearch("Nguyễn");
        //System.out.println("Total Users with 'Nguyễn': " + searchUserCount);
//        Vector<User> vector = dao.getAll("SELECT * FROM users WHERE user_id = 1;");
//        for (User user : vector) {
//            System.out.println(user);
//        }
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("user_id"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("password"),
                rs.getInt("role_id"),
                rs.getString("fullname"),
                rs.getString("gender"),
                rs.getString("address"),
                rs.getTimestamp("create_at"),
                rs.getTimestamp("updated_at"),
                rs.getString("image"),
                rs.getString("status"),
                rs.getString("deleted")
        );
    }

    public static String Sha256(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(message.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (UnsupportedEncodingException ex) {
            digest = "";
        } catch (NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

}
