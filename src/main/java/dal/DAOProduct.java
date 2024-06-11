package dal;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import models.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOProduct extends DBConnect {

public Books getBookById(int pid) {
        Books book = null;
        try {
            String sql = "SELECT * FROM books WHERE book_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, pid);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("book_id");
                String title = rs.getString("title");
                String author = rs.getString("author");
                String image = rs.getString("image");
                int categoryId = rs.getInt("category_id");
                String publishingHouse = rs.getString("publishing_house");
                int publishedYear = rs.getInt("published_year");
                String size = rs.getString("size");
                String weight = rs.getString("weight");
                String summary = rs.getString("summary");
                Double price = rs.getDouble("price");
                Integer rating = rs.getObject("rating") != null ? rs.getInt("rating") : null;
                Integer discount = rs.getObject("discount") != null ? rs.getInt("discount") : null;
                int stock = rs.getInt("stock");
                Timestamp createAt = rs.getTimestamp("create_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                book = new Books(id, title, author, image, categoryId, publishingHouse,
                        publishedYear, size, weight, summary, price, rating, discount, stock, createAt, updatedAt);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return book;
    }
}
