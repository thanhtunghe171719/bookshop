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
public class DAOBooks extends DBConnect {

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

    public int addBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (title, author, image, category_id, publishing_house, "
                + "published_year, size, weight, summary, price, rating, discount, stock,"
                + " create_at, format, pages) VALUES (?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            int i = 1;
            stmt.setString(i++, book.getTitle());
            stmt.setString(i++, book.getAuthor());
            stmt.setString(i++, book.getImage());
            stmt.setInt(i++, book.getCategoryId());
            stmt.setString(i++, book.getPublishingHouse());
            stmt.setInt(i++, book.getPublishedYear());
            stmt.setString(i++, book.getSize());
            stmt.setString(i++, book.getWeight());
            stmt.setString(i++, book.getSummary());
            stmt.setBigDecimal(i++, book.getPrice());
            stmt.setInt(i++, book.getRating());
            stmt.setInt(i++, book.getDiscount());
            stmt.setInt(i++, book.getStock());
            stmt.setTimestamp(i++, book.getCreatedAt());
            stmt.setString(i++, book.getFormat());
            stmt.setInt(i++, book.getPages());
            return stmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("Add new error: " + e);
        }
        return 0;
    }

    public int updateBook(Book book) {
        String sql = "UPDATE books SET title = ?, author = ?, image = ?, category_id = ?, publishing_house = ?, published_year = ?, size = ?, weight = ?, summary = ?, price = ?, rating = ?, discount = ?, stock = ?, updated_at = ?, format = ?, pages = ? WHERE book_id = ?";
        try (PreparedStatement state = conn.prepareStatement(sql)) {
            state.setString(1, book.getTitle());
            state.setString(2, book.getAuthor());
            state.setString(3, book.getImage());
            state.setInt(4, book.getCategoryId());
            state.setString(5, book.getPublishingHouse());
            state.setInt(6, book.getPublishedYear());
            state.setString(7, book.getSize());
            state.setString(8, book.getWeight());
            state.setString(9, book.getSummary());
            state.setBigDecimal(10, book.getPrice());
            state.setInt(11, book.getRating());
            state.setInt(12, book.getDiscount());
            state.setInt(13, book.getStock());
            state.setTimestamp(14, book.getUpdatedAt());
            state.setString(15, book.getFormat());
            state.setInt(16, book.getPages());
            state.setInt(17, book.getBookId());

            return state.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Update book error: " + ex);
        }
        return 0;
    }
    
    public int updateQuantityBook(int book_id, int quantity) {
        String sql = "UPDATE books SET stock = stock + ? WHERE book_id = ?";
        try (PreparedStatement state = conn.prepareStatement(sql)) {
            state.setInt(1, quantity);
            state.setInt(2, book_id);
            return state.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Update book error: " + ex);
        }
        return 0;
    }

    public int deleteBook(int bookId) {
        String sql = "DELETE FROM books WHERE book_id = ?";
        try (PreparedStatement state = conn.prepareStatement(sql)) {
            state.setInt(1, bookId);
            return state.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Delete book error: " + ex);
        }
        return 0;
    }

    public List<Book> getBooks(String title, String category, String sortTitle, String sortListPrice, String sortPriceSale, int page, int pageSize) {
        List<Book> books = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String query = "SELECT b.book_id, b.title, b.author, b.image, c.category_id, b.publishing_house, "
                + "b.published_year, b.size, b.weight, b.summary, b.price, b.rating, b.discount, b.stock, "
                + "b.create_at, b.updated_at, b.format, b.pages "
                + "FROM books b JOIN categories c ON b.category_id = c.category_id where 1=1";
        if (title != null) {
            query += " AND b.title LIKE ?";
        }
        if (category != null && category.length() != 0) {
            query += " AND b.category_id = ?";
        }
        if (sortTitle != null && sortTitle.length() != 0) {
            query += " ORDER BY b.title " + sortTitle;
        }
        if (sortListPrice != null && sortListPrice.length() != 0) {
            query += (sortTitle.length() == 0 ? " ORDER BY" : ",") + " b.price " + sortListPrice;
        }
        if (sortPriceSale != null && !sortPriceSale.isEmpty()) {
            query += ((sortTitle.length() == 0 && sortListPrice.length() == 0) ? " ORDER BY" : ",") + " b.discount " + sortPriceSale;
        }
        query += " LIMIT ? OFFSET ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int index = 1;
            if (title != null) {
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
        if (title != null) {
            query += " AND title LIKE ?";
        }
        if (category != null && !category.isEmpty()) {
            query += " AND category_id = ?";
        }
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            int index = 1;
            if (title != null) {
                stmt.setString(index++, "%" + title + "%");
            }
            if (category != null && !category.isEmpty()) {
                stmt.setString(index++, category);
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Count: " + e);
        }
        return 0;
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
    public int getBooksCount() {
        int totalBooks = 0;
        String sql = "SELECT COUNT(*) as totalBooks FROM books";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalBooks = rs.getInt("totalBooks");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalBooks;
    }
    public static void main(String[] args) {
        DAOBooks dao = new DAOBooks();
        ArrayList<Book> list = dao.getAll("SELECT * FROM books WHERE discount > 0 ORDER BY discount DESC LIMIT 8;");
        for (Book books : list) {
            System.out.println(books);
        }
    }

}
