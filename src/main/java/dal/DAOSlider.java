/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import models.Slider;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author TDG
 */
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
    
    public static void main(String[] args) {
        DAOSlider dao = new DAOSlider();
        String title = "er 1";
        ArrayList<Slider> list  = dao.getAll("SELECT * FROM slider where title like '%"+title+"%' limit 1;");
        for (Slider slider : list) {
            System.out.println(slider);
        }
    }
}