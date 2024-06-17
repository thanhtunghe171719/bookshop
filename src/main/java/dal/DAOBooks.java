/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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

/**
 *
 * @author TDG
 */
public class DAOBooks extends DBConnect {

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

    public List<Book> getBooks(String title, String category, String sortTitle, String sortListPrice, String sortPriceSale, int page, int pageSize) {
        List<Book> books = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String query = "SELECT b.book_id, b.title, b.author, b.image, c.category_id, b.publishing_house, "
                + "b.published_year, b.size, b.weight, b.summary, b.price, b.rating, b.discount, b.stock, "
                + "b.create_at, b.updated_at, b.format, b.pages "
                + "FROM books b JOIN categories c ON b.category_id = c.category_id where 1 = 1 ";
        if (title != null && !title.isEmpty()) {
            query += " AND b.title LIKE ?";
        }
        if (category != null && !category.isEmpty()) {
            query += " AND b.category_id = ?";
        }
        if (sortTitle != null && !sortTitle.isEmpty()) {
            query += " ORDER BY b.title " + sortTitle;
        }
        if (sortListPrice != null && !sortListPrice.isEmpty()) {
            query += (sortTitle.isEmpty() ? " ORDER BY" : ",") + " b.price " + sortListPrice;
        }
        if (sortPriceSale != null && !sortPriceSale.isEmpty()) {
            query += ((sortTitle.isEmpty() && sortListPrice.isEmpty()) ? " ORDER BY" : ",") + " b.discount " + sortPriceSale;
        }
        query += " LIMIT ? OFFSET ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int index = 1;
            if (title != null && !title.isEmpty()) {
                stmt.setString(index++, "%" + title + "%");
            }
            if (category != null && !category.isEmpty()) {
                stmt.setString(index++, category);
            }
            stmt.setInt(index++, pageSize);
            stmt.setInt(index, (page - 1) * pageSize);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setImage(rs.getString("image"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setPublishingHouse(rs.getString("publishing_house"));
                book.setPublishedYear(rs.getInt("published_year"));
                book.setSize(rs.getString("size"));
                book.setWeight(rs.getString("weight"));
                book.setSummary(rs.getString("summary"));
                book.setPrice(rs.getBigDecimal("price"));
                book.setRating(rs.getInt("rating"));
                book.setDiscount(rs.getInt("discount"));
                book.setStock(rs.getInt("stock"));
                book.setCreatedAt(rs.getTimestamp("create_at"));
                book.setUpdatedAt(rs.getTimestamp("updated_at"));
                book.setFormat(rs.getString("format"));
                book.setPages(rs.getInt("pages"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public int getBookCount(String title, String category) {
        String query = "SELECT COUNT(*) FROM books where 1 = 1 ";
        if (title != null && !title.isEmpty()) {
            query += " AND b.title LIKE ?";
        }
        if (category != null && !category.isEmpty()) {
            query += " AND b.category_id = ?";
        }
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            int index = 1;
            if (title != null && !title.isEmpty()) {
                stmt.setString(index++, "%" + title + "%");
            }
            if (category != null && !category.isEmpty()) {
                stmt.setString(index++, category);
            }
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Count: " + e);
        }
        return 0;
    }

    public Book getById(int id) {
        String sql = "select * from books where book_id =?";
        try {
            PreparedStatement state = conn.prepareStatement(sql);
            state.setInt(1, id);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
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
            System.out.println("Get by id: " + ex);
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
