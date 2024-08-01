/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Role;
import models.Slider;

/**
 *
 * @author ADMIN
 */
public class DAORole extends DBConnect{
    public ArrayList<Role> getAll(String sql) {
        ArrayList<Role> listRole = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                
                int role_id = rs.getInt("role_id");
                String role_name = rs.getString("role_name");
                int status_id = rs.getInt("status_id");
                Timestamp create_at = rs.getTimestamp("create_at");
                Timestamp updated_at = rs.getTimestamp("updated_at");

                 Role c = new Role(role_id, role_name, status_id, create_at, updated_at);
                 listRole.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAORole.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listRole;
    }
    
    
    public int insert(Role obj) {
        int n = 0;
        String sql = "INSERT INTO `role`\n"
                + "(`role_id`,`role_name`,`status_id`)\n"
                + "VALUES ("+obj.getRole_id()+",'"+obj.getRole_name()+"','"+obj.getStatus_id()+"');";
        System.out.println(sql);
        Statement state;
        try {
            state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAORole.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
