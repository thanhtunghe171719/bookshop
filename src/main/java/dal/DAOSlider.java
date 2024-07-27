/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import models.Slider;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;


public class DAOSlider extends DBConnect{
    public ArrayList<Slider> getAll(String sql) {
        ArrayList<Slider> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                
                int sliderId = rs.getInt("slider_id");
                int userId = rs.getInt("user_id");
                String title = rs.getString("title");
                String image = rs.getString("image");
                String status = rs.getString("status");
                String description = rs.getString("description");

                 Slider c = new Slider(sliderId, userId, title, image, status, description);
                 list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public int updateSlider(Slider slider) {
        String sql = "UPDATE `slider` SET `user_id` = ?,`title` = ?,\n"
                + "`image` = ?,`status` = ?,`description` = ?WHERE `slider_id` = ?;";
        try (PreparedStatement state = conn.prepareStatement(sql)) {
            state.setInt(1, slider.getUserId());
            state.setString(2, slider.getTitle());
            state.setString(3, slider.getImage());
            state.setString(4, slider.getStatus());
            state.setString(5, slider.getDescription());
            state.setInt(6, slider.getSliderId());

            return state.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Update book error: " + ex);
        }
        return 0;
    }

    public int deleteSlider(int sliderId) {
        String sql = "DELETE FROM slider WHERE slider_id = ?";
        try (PreparedStatement state = conn.prepareStatement(sql)) {
            state.setInt(1, sliderId);
            return state.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Delete book error: " + ex);
        }
        return 0;
    }

    public int insert(Slider obj) {
        int n = 0;
        String sql = "INSERT INTO `slider`\n"
                + "(`user_id`,`title`,`image`,`status`,`description`)\n"
                + "VALUES ("+obj.getUserId()+",'"+obj.getTitle()+"','"+obj.getImage()+"','"+obj.getStatus()+"','"+obj.getDescription()+"');";
        System.out.println(sql);
        Statement state;
        try {
            state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public int getSlidersCount() {
        int totalSliders = 0;
        String sql = "SELECT COUNT(*) as totalSliders FROM slider";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalSliders= rs.getInt("totalSliders");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSliders;
    }
    public static void main(String[] args) {
        DAOSlider dao = new DAOSlider();
        String title = "er 1";
        ArrayList<Slider> list  = dao.getAll("SELECT * FROM slider where title like '%"+title+"%' limit 1;");
        for (Slider slider : list) {
            System.out.println(slider);
        }
    }
}