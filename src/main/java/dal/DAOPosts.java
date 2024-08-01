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
import java.util.logging.Logger;
import java.util.logging.Level;
import models.Posts;

/**
 *
 * @author TDG
 */
public class DAOPosts extends DBConnect{
    public ArrayList<Posts> getAll(String sql) {
        ArrayList<Posts> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int postId = rs.getInt("post_id");
                String image = rs.getString("image");
                String title = rs.getString("title");
                String postType = rs.getString("post_type");
                int userId = rs.getInt("user_id");
                String description = rs.getString("description");
                String status = rs.getString("status");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");

                 Posts p = new Posts(postId, image, title, postType, userId, description, status, createdAt, updatedAt);
                 list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public int getPostsCount() {
        int totalPosts = 0;
        String sql = "SELECT COUNT(*) as totalPosts FROM posts";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalPosts = rs.getInt("totalPosts");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPosts;
    }
    public int getPostsCountByMonth(int month) {
    String sql = "SELECT COUNT(*) FROM posts WHERE MONTH(created_at) = ?";
    try (
            PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, month); // Set the month parameter
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) { // Use if since you're expecting one result
                return rs.getInt(1);
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0;
    }
    public static void main(String[] args) {
        DAOPosts dao = new DAOPosts();
        ArrayList<Posts> list = dao.getAll("SELECT * FROM posts WHERE status = 'Show' ORDER BY created_at DESC LIMIT 3;");
        for (Posts posts : list) {
            System.out.println(posts);
        }
    }
}