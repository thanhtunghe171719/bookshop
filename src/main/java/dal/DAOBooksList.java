/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import models.Books;
import models.Categories;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ngdin
 */
public class DAOBooksList extends DBConnect {

    public ArrayList<Books> getListBooks(String grid, int index, String sort) {
        try {
            ArrayList<Books> ListBooks = new ArrayList<Books>();
            String sql = "SELECT * FROM books ";
            switch (sort) {
                case "newest":
                    sql += "ORDER BY published_year DESC ";
                    break;
                case "price_asc":
                    sql += "ORDER BY price - (price * discount / 100) ASC ";
                    break;
                case "price_desc":
                    sql += "ORDER BY price - (price * discount / 100) DESC ";
                    break;
                default:
                    // Default sorting logic, if needed
                    break;
            }
            sql += "LIMIT ? OFFSET ?;";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(grid));
            statement.setInt(2, (index - 1) * Integer.parseInt(grid));
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int book_id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                String image = rs.getString(4);
                int category_id = rs.getInt(5);
                String publishing_house = rs.getString(6);
                int published_year = rs.getInt(7);
                String size = rs.getString(8);
                String weight = rs.getString(9);
                String summary = rs.getString(10);
                double price = rs.getDouble(11);
                int rating = rs.getInt(12);
                int discount = rs.getInt(13);
                int stock = rs.getInt(14);
                Date create_at = rs.getDate(15);
                Date update_at = rs.getDate(16);

                Books b = new Books(book_id, title, author, image, category_id, publishing_house, published_year, size, weight, summary, price, rating, discount, stock, create_at, update_at);

                ListBooks.add(b);

            }
            return ListBooks;
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

    }

    public ArrayList<Books> getListBooksByCategory(int categoryId, String grid, int index, String sort) {
        try {
            ArrayList<Books> ListBooksByCategory = new ArrayList<Books>();
            String sql = "SELECT * FROM books WHERE category_id = ? ";
            switch (sort) {
                case "newest":
                    sql += "ORDER BY published_year DESC ";
                    break;
                case "price_asc":
                    sql += "ORDER BY price - (price * discount / 100) ASC ";
                    break;
                case "price_desc":
                    sql += "ORDER BY price - (price * discount / 100) DESC ";
                    break;
                default:
                    // Default sorting logic, if needed
                    break;
            }
            sql += "LIMIT ? OFFSET ?;";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, categoryId);
            statement.setInt(2, Integer.parseInt(grid));
            statement.setInt(3, (index - 1) * Integer.parseInt(grid));
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int book_id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                String image = rs.getString(4);
                int category_id = rs.getInt(5);
                String publishing_house = rs.getString(6);
                int published_year = rs.getInt(7);
                String size = rs.getString(8);
                String weight = rs.getString(9);
                String summary = rs.getString(10);
                double price = rs.getDouble(11);
                int rating = rs.getInt(12);
                int discount = rs.getInt(13);
                int stock = rs.getInt(14);
                Date create_at = rs.getDate(15);
                Date update_at = rs.getDate(16);

                Books b = new Books(book_id, title, author, image, category_id, publishing_house, published_year, size, weight, summary, price, rating, discount, stock, create_at, update_at);

                ListBooksByCategory.add(b);

            }
            return ListBooksByCategory;
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

    }

    public ArrayList<Books> getBookBySearch(String searchText, String grid, int index, String sort) {
        try {
            ArrayList<Books> ListBooks = new ArrayList<Books>();
            String sql = "SELECT * FROM books\n"
                    + "WHERE books.title like ?";

            switch (sort) {
                case "newest":
                    sql += "ORDER BY published_year DESC ";
                    break;
                case "price_asc":
                    sql += "ORDER BY price - (price * discount / 100) ASC ";
                    break;
                case "price_desc":
                    sql += "ORDER BY price - (price * discount / 100) DESC ";
                    break;
                default:
                    // Default sorting logic, if needed
                    break;
            }
            sql += "LIMIT ? OFFSET ?;";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, "%" + searchText + "%");
            statement.setInt(2, Integer.parseInt(grid));
            statement.setInt(3, (index - 1) * Integer.parseInt(grid));
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int book_id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                String image = rs.getString(4);
                int category_id = rs.getInt(5);
                String publishing_house = rs.getString(6);
                int published_year = rs.getInt(7);
                String size = rs.getString(8);
                String weight = rs.getString(9);
                String summary = rs.getString(10);
                double price = rs.getDouble(11);
                int rating = rs.getInt(12);
                int discount = rs.getInt(13);
                int stock = rs.getInt(14);
                Date create_at = rs.getDate(15);
                Date update_at = rs.getDate(16);

                Books b = new Books(book_id, title, author, image, category_id, publishing_house, published_year, size, weight, summary, price, rating, discount, stock, create_at, update_at);

                ListBooks.add(b);

            }
            return ListBooks;
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

    }

    public ArrayList<Categories> getListCategories() {
        try {
            ArrayList<Categories> ListCategories = new ArrayList<Categories>();
            String sql = "SELECT * FROM categories;";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt(1);
                String categoryName = rs.getString(2);
                String image = rs.getString(3);
                Date create_at = rs.getDate(4);
                Date updated_at = rs.getDate(5);

                Categories c = new Categories(categoryId, categoryName, image, create_at, updated_at);

                ListCategories.add(c);

            }
            return ListCategories;
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

    }

    public int getTotalBooks() {
        try {
            String sql = "SELECT COUNT(*) FROM books;";
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;

    }

    public int getTotalBooksByCategory(int categoryId) {
        try {
            String sql = "SELECT COUNT(*) FROM books\n"
                    + "WHERE books.category_id = ?;";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, categoryId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;

    }
    
    public static void main(String[] args) {
        DAOBooksList book = new DAOBooksList();
//        ArrayList<Books> b = book.getListBooks("6", 1, "newest");
        int count = book.getTotalBooksByCategory(1);
        System.out.println(count);
    }
}