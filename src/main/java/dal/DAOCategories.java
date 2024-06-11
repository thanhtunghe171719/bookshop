/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import models.Categorie;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author TDG
 */
public class DAOCategories extends DBConnect{
    public ArrayList<Categorie> getAll(String sql) {
        ArrayList<Categorie> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                
                 int sliderId = rs.getInt("category_id");
                 String categoryName = rs.getString("category_name");
                 String image = rs.getString("image");
                 Timestamp createdAt = rs.getTimestamp("create_at");
                 Timestamp updatedAt = rs.getTimestamp("updated_at");


                 Categorie c = new Categorie(sliderId, categoryName, image, createdAt, updatedAt);
                 list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public static void main(String[] args) {
        DAOCategories dao = new DAOCategories();
        ArrayList<Categorie> list  = dao.getAll("SELECT * FROM categories;");
        for (Categorie categories : list) {
            System.out.println(categories);
        }
    }
}
