/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import static com.mysql.cj.conf.PropertyKey.logger;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;
import java.util.logging.Logger;
import java.util.logging.Level;
import models.User;
import models.UserChangeHistory;

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

        String sql = "UPDATE checksql.users\n"
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
                            rs.getString("deleted")
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

    public int getRoleIdByRoleName(String roleName) {
        String query = "SELECT role_id FROM roles WHERE role_name = ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, roleName);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("role_id");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1; // Return an invalid role ID if not found or in case of an error
    }

    public boolean addUserList(User user) {
        String query = "INSERT INTO users (email, phone, password, role_id, fullname, gender, address, create_at, updated_at, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            // Fetch the role_id based on role_name
            int roleId = getRoleIdByRoleName(user.getRoleName());
            if (roleId == -1) {
                throw new SQLException("Role not found for role name: " + user.getRoleName());
            }

            try ( PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, user.getEmail());
                ps.setString(2, user.getPhone());
                ps.setString(3, user.getPassword() != null ? user.getPassword() : "defaultPassword"); // Handle default or null password
                ps.setInt(4, roleId); // Use the fetched role ID
                ps.setString(5, user.getFullname());
                ps.setString(6, user.getGender());
                ps.setString(7, user.getAddress() != null ? user.getAddress() : ""); // Handle default or null address
                ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
                ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
                ps.setString(10, user.getImage() != null ? user.getImage() : ""); // Handle default or null image
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
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
        String sql = "UPDATE users SET fullname=?, gender=?, email=?, phone=?, status=?, updated_at=? WHERE user_id=?";

        try ( PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, user.getFullname());
            preparedStatement.setString(2, user.getGender());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getStatus());
            preparedStatement.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            preparedStatement.setInt(7, user.getUserId());

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
                    User user = mapResultSetToUser(rs);
                    Logger.getLogger(DAOUsers.class.getName()).log(Level.INFO, "Fetched user address: " + user.getAddress());
                    return user;
                } else {
                    System.out.println("User not found with ID: " + userId);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
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

        String sql = "UPDATE checksql.users\n"
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
                + "image = ?,\n"
                + "status = ?,\n"
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
            pre.setInt(12, obj.getUserId());
            n = pre.executeUpdate();

            Logger.getLogger(DAOUsers.class.getName()).log(Level.INFO, "User updated successfully: " + obj.getUserId());
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, "Error updating user: " + obj.getUserId(), ex);
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

    public List<User> getCustomersWithPagination(int pageIndex, int pageSize, String sortField, String sortOrder) {
        String query = "SELECT * FROM users WHERE deleted = 'no' AND role_id = '2' ORDER BY "
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
        String query = "SELECT * FROM users WHERE fullname LIKE ? AND deleted = 'no' AND role_id = '2' ORDER BY "
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
        String query = "SELECT COUNT(*) FROM users WHERE deleted = 'no' AND role_id = '2'";
        try ( PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int getCustomerCountWithSearch(String searchQuery) {
        String query = "SELECT COUNT(*) FROM users WHERE fullname LIKE ? AND deleted = 'no' AND role_id = '2'";
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
                + "WHERE u.deleted = 'no' "
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
                + "WHERE u.fullname LIKE ? AND u.deleted = 'no' "
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
        String query = "SELECT COUNT(*) FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.deleted = 'no' "
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
        String query = "SELECT COUNT(*) FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.fullname LIKE ? AND u.deleted = 'no' "
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

    public static void main(String[] args) {
        DAOUsers dao = new DAOUsers();

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

}
