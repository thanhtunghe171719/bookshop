/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import models.Categorie;
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
public class DAOCategories extends DBConnect {

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

    public List<Categorie> getAllCategory() {
        List<Categorie> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories";

        try (
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                Categorie category = new Categorie(
                    rs.getInt("category_id"),
                    rs.getString("category_name"),
                    rs.getString("image"),
                    rs.getTimestamp("create_at"),
                    rs.getTimestamp("updated_at")
                );
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
    public int addCategory(Categorie category) throws SQLException {
        String sql = "INSERT INTO categories (category_name, image, created_at, updated_at) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category.getCategoryName());
            stmt.setString(2, category.getImage());
            stmt.setTimestamp(3, category.getCreatedAt());
            stmt.setTimestamp(4, category.getUpdatedAt());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Add category error: " + e);
            return 0;
        }
    }

    public int updateCategory(Categorie category) {
        String sql = "UPDATE categories SET category_name = ?, image = ?, updated_at = ? WHERE category_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category.getCategoryName());
            stmt.setString(2, category.getImage());
            stmt.setTimestamp(3, category.getUpdatedAt());
            stmt.setInt(4, category.getCategoryId());
            return stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Update category error: " + e);
            return 0;
        }
    }

    public int deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Delete category error: " + e);
            return 0;
        }
    }

    public List<Categorie> getCategories(String categoryName, int page, int pageSize) {
        List<Categorie> categories = new ArrayList<>();
        String query = "SELECT category_id, category_name, image, created_at, updated_at FROM categories WHERE 1=1";
        if (categoryName != null && !categoryName.isEmpty()) {
            query += " AND category_name LIKE ?";
        }
        query += " LIMIT ? OFFSET ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int index = 1;
            if (categoryName != null && !categoryName.isEmpty()) {
                stmt.setString(index++, "%" + categoryName + "%");
            }
            stmt.setInt(index++, pageSize);
            stmt.setInt(index, (page - 1) * pageSize);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Categorie category = new Categorie();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setImage(rs.getString("image"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                category.setUpdatedAt(rs.getTimestamp("updated_at"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Get categories error: " + e);
        }
        return categories;
    }

    public int getCategoryCount(String categoryName) {
        String query = "SELECT COUNT(*) FROM categories WHERE 1=1";
        if (categoryName != null && !categoryName.isEmpty()) {
            query += " AND category_name LIKE ?";
        }
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            int index = 1;
            if (categoryName != null && !categoryName.isEmpty()) {
                stmt.setString(index++, "%" + categoryName + "%");
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get category count error: " + e);
        }
        return 0;
    }

    public Categorie getCategoryById(int categoryId) {
        String query = "SELECT category_id, category_name, image, created_at, updated_at FROM categories WHERE category_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Categorie category = new Categorie();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setImage(rs.getString("image"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                category.setUpdatedAt(rs.getTimestamp("updated_at"));
                return category;
            }
        } catch (SQLException e) {
            System.out.println("Get category by id error: " + e);
        }
        return null;
    }

    public ArrayList<Categorie> getAll() {
        ArrayList<Categorie> list = new ArrayList<>();
        String sql = "select * from categories";
        try {
            PreparedStatement state = conn.prepareStatement(sql);
            ResultSet rs = state.executeQuery();
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

    public Categorie getById(int category) {
        String sql = "select * from categories where category_id =?";
        try {
            PreparedStatement state = conn.prepareStatement(sql);
            state.setInt(1, category);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                int sliderId = rs.getInt("category_id");
                String categoryName = rs.getString("category_name");
                String image = rs.getString("image");
                Timestamp createdAt = rs.getTimestamp("create_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                Categorie c = new Categorie(sliderId, categoryName, image, createdAt, updatedAt);
                return c;
            }
        } catch (SQLException ex) {
            System.out.println("Get category: " + ex);
        }
        return null;
    }

    public List<Categorie> getCategories() {
        List<Categorie> categories = new ArrayList<>();
        String query = "SELECT c.category_id, c.category_name, c.image, c.create_at, c.updated_at "
                + "FROM categories c";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Categorie categorie = new Categorie();
                categorie.setCategoryId(rs.getInt("category_id"));
                categorie.setCategoryName(rs.getString("category_name"));
                categorie.setImage(rs.getString("image"));
                categorie.setCreatedAt(rs.getTimestamp("create_at"));
                categorie.setUpdatedAt(rs.getTimestamp("updated_at"));
                categories.add(categorie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public static void main(String[] args) {
        DAOCategories dao = new DAOCategories();
        ArrayList<Categorie> list = dao.getAll("SELECT * FROM categories;");
        for (Categorie categories : list) {
            System.out.println(categories);
        }
    }
}
