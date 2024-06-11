/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Logger;
import java.util.logging.Level;
import models.Book;
/**
 *
 * @author TDG
 */
public class DAOBooks extends DBConnect{
    public ArrayList<Book> getAll(String sql) {
        ArrayList<Book> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                
                int bookId = rs.getInt("book_id");
                String title = rs.getString("title");
                String author = rs.getString("author");
                String image = rs.getString("image");
                int categoryId = rs.getInt("category_id");
                String publishingHouse = rs.getString("publishing_house");
                int publishedYear = rs.getInt("published_year");
                String size = rs.getString("size");
                String weight = rs.getString("weight");
                String summary = rs.getString("summary");
                BigDecimal price = rs.getBigDecimal("price");
                Integer rating = rs.getInt("rating");
                Integer discount = rs.getInt("discount");
                int stock = rs.getInt("stock");
                Timestamp createdAt = rs.getTimestamp("create_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                String format = rs.getString("format");
                int pages = rs.getInt("pages");

                 Book b = new Book(bookId, title, author, image, categoryId, publishingHouse, 
                         publishedYear, size, weight, summary, price, rating, discount, stock, createdAt, updatedAt, format, pages);
                 list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public static void main(String[] args) {
        DAOBooks dao = new DAOBooks();
        ArrayList<Book> list = dao.getAll("SELECT * FROM books WHERE discount > 0 ORDER BY discount DESC LIMIT 8;");
        for (Book books : list) {
            System.out.println(books);
        }
    }
}
