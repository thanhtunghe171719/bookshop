/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Vector;
import java.util.logging.Logger;
import java.util.logging.Level;
import models.User;

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

        String sql = "UPDATE `checksql`.`users`\n"
                + "SET\n"
                + "`email` = ?,\n"
                + "`phone` = ?,\n"
                + "`password` = ?,\n"
                + "`role_id` = ?,\n"
                + "`fullname` = ?,\n"
                + "`gender` = ?,\n"
                + "`address` = ?,\n"
                + "`create_at` = ?,\n"
                + "`updated_at` = ?\n"
                + "WHERE `user_id` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setString(1, obj.getEmail());
            pre.setString(2, obj.getPhone());
            pre.setString(3, obj.getPassword());
            pre.setInt(4, obj.getRoleId());
            pre.setString(5, obj.getFullname());
            pre.setString(6, obj.getGender());
            pre.setString(7, obj.getAddress());
            pre.setDate(8, obj.getCreateAt());
            pre.setDate(9, obj.getUpdatedAt());
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
                            rs.getDate("create_at"),
                            rs.getDate("updated_at"),
                            rs.getString("image"),
                            rs.getString("status")
                    );
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
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
                rs.getDate("create_at"),
                rs.getDate("updated_at"),
                rs.getString("image"),
                rs.getString("status")
        );
    }

    public boolean addUser(User user) {

        String query = "INSERT INTO users (email, phone, password, role_id, fullname, gender, address, create_at, updated_at, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getPassword());
            ps.setInt(4, user.getRoleId());
            ps.setString(5, user.getFullname());
            ps.setString(6, user.getGender());
            ps.setString(7, user.getAddress());
            ps.setDate(8, new Date(System.currentTimeMillis()));
            ps.setDate(9, new Date(System.currentTimeMillis()));
            ps.setString(10, user.getImage());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET fullname = ?, gender = ?, address = ?, phone = ?, image = ?, updated_at = ?, status = ?, WHERE user_id = ?";
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

    public int updateUserPassword(int userId, String password) {
        String sql = "UPDATE users SET password=?, updated_at = ? WHERE user_id = ?";
        try ( PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setString(1, password);
            ptm.setDate(2, new Date(System.currentTimeMillis()));
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
                java.sql.Date createdAt = new java.sql.Date(System.currentTimeMillis());
                java.sql.Date updatedAt = new java.sql.Date(System.currentTimeMillis());
                String status = rs.getString("status");
                User c = new User(userId, email, phone, password, roleId, fullname, gender, address, createdAt, updatedAt, image, status);
                list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int update(User obj) {
        int n = 0;

        String sql = "UPDATE `bookshop`.`users`\n"
                + "SET\n"
                + "`email` = ?,\n"
                + "`phone` = ?,\n"
                + "`password` = ?,\n"
                + "`role_id` = ?,\n"
                + "`fullname` = ?,\n"
                + "`gender` = ?,\n"
                + "`address` = ?,\n"
                + "`create_at` = ?,\n"
                + "`updated_at` = ?\n"
                + "`image` = ?\n"
                + "`status` = ?,\n"
                + "WHERE `user_id` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setString(1, obj.getEmail());
            pre.setString(2, obj.getPhone());
            pre.setString(3, obj.getPassword());
            pre.setInt(4, obj.getRoleId());
            pre.setString(5, obj.getFullname());
            pre.setString(6, obj.getGender());
            pre.setString(7, obj.getAddress());
            pre.setDate(8, obj.getCreateAt());
            pre.setDate(9, obj.getUpdatedAt());
            pre.setString(10, obj.getImage());
            pre.setString(11, obj.getStatus());
            pre.setInt(12, obj.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public boolean deleteUser(int userId) {
    String query = "DELETE FROM users WHERE user_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, userId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException ex) {
        ex.printStackTrace();
        return false;
    }
}


    public static void main(String[] args) {
        DAOUsers dao = new DAOUsers();
//        Vector<User> vector = dao.getAll("SELECT * FROM users WHERE user_id = 1;");
//        for (User user : vector) {
//            System.out.println(user);
//        }
    }

}
