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
import java.util.logging.Logger;
import java.util.logging.Level;
import models.User;

/**
 *
 * @author TDG
 */
public class DAOUsers extends DBConnect{
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
                Timestamp createAt = rs.getTimestamp("create_At");
                Timestamp updatedAt = rs.getTimestamp("updated_At");

                 User c = new User(userId, email, phone, password, roleId, fullname, gender, image, address, createAt, updatedAt);
                 list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public int update(User obj) {
        int n = 0;

        String sql = "UPDATE `bookshop`.`users`\n" +
                        "SET\n" +
                        "`email` = ?,\n" +
                        "`phone` = ?,\n" +
                        "`password` = ?,\n" +
                        "`role_id` = ?,\n" +
                        "`fullname` = ?,\n" +
                        "`gender` = ?,\n" +
                        "`image` = ?,\n" +
                        "`address` = ?,\n" +
                        "`create_at` = ?,\n" +
                        "`updated_at` = ?\n" +
                        "WHERE `user_id` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setString(1, obj.getEmail());
            pre.setString(2, obj.getPhone());
            pre.setString(3, obj.getPassword());
            pre.setInt(4, obj.getRoleId());
            pre.setString(5, obj.getFullname());
            pre.setString(6, obj.getGender());
            pre.setString(7, obj.getImage());
            pre.setString(8, obj.getAddress());
            pre.setTimestamp(9, obj.getCreateAt());
            pre.setTimestamp(10, obj.getUpdatedAt());
            pre.setInt(11, obj.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUsers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public static void main(String[] args) {
        DAOUsers dao = new DAOUsers();
        ArrayList<User> list  = dao.getAll("SELECT * FROM users limit 1;");
        User user = list.get(0);
        user.setPassword("123456");
        int n = dao.update(user);
        if(n!=0){
            System.out.println("oke");
        }
    }
}
