/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.UserRole;

/**
 *
 * @author ADMIN
 */
public class DAOUserRole extends DBConnect{
    public List<UserRole> getAllUserRoles() {
        List<UserRole> roles = new ArrayList<>();
        String sql = "SELECT * FROM roles";

        try (
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                UserRole role = new UserRole(
                    rs.getInt("role_id"),
                    rs.getString("role_name"),
                    rs.getInt("status_id"),
                    rs.getTimestamp("create_at"),
                    rs.getTimestamp("updated_at")
                );
                roles.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roles;
    }
    public boolean updateRoleStatus(int roleId, int newStatus) {
    String sql = "UPDATE roles SET status_id = ? WHERE role_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, newStatus);
        ps.setInt(2, roleId);
        int affectedRows = ps.executeUpdate();
        return affectedRows > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
     public boolean addRole(String roleName) {
        String sql = "INSERT INTO roles (role_name, status_id) VALUES (?, 1)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roleName);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
