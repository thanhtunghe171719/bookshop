/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

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
import models.users;


public class DAOUsers extends DBConnect {
    
    public Vector<users> getAll(String sql) {
        Vector<users> vector = new Vector<>();
        try (Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); ResultSet rs = state.executeQuery(sql)) {
            
            while (rs.next()) {
                users u = mapResultSetToUser(rs);
                vector.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }
    
    public int changePassWord(users obj) {
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
            pre.setTimestamp(8, obj.getCreateAt());
            pre.setTimestamp(9, obj.getUpdatedAt());
            pre.setInt(10, obj.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public users getUserByUsername(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public int addUser(users user) {
        String query = "INSERT INTO users (email, password, phone, fullname, address, gender, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getFullname());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getGender());
            ps.setInt(7, 0);
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;        
    }
    
    public void updateUser(users user) throws SQLException {
        String sql = "UPDATE users SET fullname = ?, gender = ?, address = ?, phone = ?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setString(1, user.getFullname());
            ptm.setString(2, user.getGender());
            ptm.setString(3, user.getAddress());
            ptm.setString(4, user.getPhone());
            ptm.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            ptm.setInt(6, user.getUserId());
            ptm.executeUpdate();
        }
    }
    
    public int updateUserPassword(int userId, String password) {
        String sql = "UPDATE users SET password=?, updated_at = ? WHERE user_id = ?";
        try (PreparedStatement ptm = conn.prepareStatement(sql)) {
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
        try (PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setInt(1, status);
            ptm.setInt(2, userId);
            return ptm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update password: " + e);
        }
        return 0;
    }
    
    public users getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setInt(1, userId);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    private users mapResultSetToUser(ResultSet rs) throws SQLException {
        return new users(
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
                rs.getInt("status")
        );
    }
    
    private void setPreparedStatementForUser(PreparedStatement ps, users user) throws SQLException {
        ps.setString(1, user.getEmail());
        ps.setString(2, user.getPhone());
        ps.setString(3, user.getPassword());
        ps.setInt(4, user.getRoleId());
        ps.setString(5, user.getFullname());
        ps.setString(6, user.getGender());
        ps.setString(7, user.getAddress());
        ps.setTimestamp(8, user.getCreateAt());
        ps.setTimestamp(9, user.getUpdatedAt());
        ps.setInt(10, user.getUserId());
    }
    
    public static void main(String[] args) {
        DAOUsers dao = new DAOUsers();
        Vector<users> vector = dao.getAll("SELECT * FROM users WHERE user_id = 1;");
        for (users user : vector) {
            System.out.println(user);
        }
    }
}
