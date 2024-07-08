package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;
import models.Book;
import models.Books;
/**
 *
 * @author TDG
 */
public class DAOBooks extends DBConnect{
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
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return book;
    }
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
            Logger.getLogger(DAOBooks.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Book getBookById(String sql) {
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
                 return b;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOBooks.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static void main(String[] args) {
        DAOBooks dao = new DAOBooks();
        ArrayList<Book> list = dao.getAll("SELECT * FROM books WHERE discount > 0 ORDER BY discount DESC LIMIT 8;");
        for (Book books : list) {
            System.out.println(books);
        }
    }
    
    
}
