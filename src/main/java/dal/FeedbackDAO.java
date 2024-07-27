/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import models.Book;
import models.Feedback;
import models.User;

/**
 *
 * @author HP
 */
public class FeedbackDAO extends DBConnect {

    private Connection connection;

    public FeedbackDAO() {
        connection = conn;
    }

    public boolean hasFeedback(int orderItemId) {
        try {
            String query = "SELECT COUNT(*) AS count FROM feedback WHERE order_item_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderItemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public int getFeedbacksCount() {
        int totalFeedbacks = 0;
        String sql = "SELECT COUNT(*) as totalFeedbacks FROM feedback";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalFeedbacks = rs.getInt("totalFeedbacks");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalFeedbacks;
    }
    public void addFeedback(Feedback feedback) {
        try {
            String query = "INSERT INTO feedback (order_item_id, rating, comment, created_at) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, feedback.getOrderItemId());
            ps.setInt(2, feedback.getRating());
            ps.setString(3, feedback.getComment());
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateFeedback(Feedback feedback) {
        try {
            String query = "UPDATE feedback SET rating = ?, comment = ?, created_at = ? WHERE feedback_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, feedback.getRating());
            ps.setString(2, feedback.getComment());
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.setInt(4, feedback.getFeedbackId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Feedback getFeedbackByOrderItemId(int orderItemId) {
        Feedback feedback = null;
        try {
            String query = "SELECT * FROM feedback WHERE order_item_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderItemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setOrderItemId(rs.getInt("order_item_id"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedback;
    }

    public List<Feedback> getFeedbackByProductId(int productId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.feedback_id, f.order_item_id, f.rating, f.comment, f.created_at, "
                + "b.book_id, b.title, b.author, b.image, "
                + "u.user_id, u.fullname "
                + "FROM feedback f "
                + "JOIN order_items oi ON f.order_item_id = oi.order_item_id "
                + "JOIN books b ON oi.book_id = b.book_id "
                + "JOIN `orders` o ON o.order_id = oi.order_id "
                + "JOIN cart ca ON ca.cart_id = o.cart_id "
                + "JOIN users u ON ca.user_id = u.user_id "
                + "WHERE b.book_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setOrderItemId(rs.getInt("order_item_id"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getDate("created_at"));

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                user.setImage(rs.getString("image"));
                feedback.setUser(user);

                feedbackList.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.feedback_id, f.order_item_id, f.rating, f.comment, f.created_at, "
                + "b.book_id, b.title, b.author, b.image, "
                + "u.user_id, u.fullname "
                + "FROM feedback f "
                + "JOIN order_items oi ON f.order_item_id = oi.order_item_id "
                + "JOIN books b ON oi.book_id = b.book_id "
                + "JOIN `orders` o ON o.order_id = oi.order_id "
                + "JOIN cart ca ON ca.cart_id = o.cart_id "
                + "JOIN users u ON ca.user_id = u.user_id";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setOrderItemId(rs.getInt("order_item_id"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getDate("created_at"));

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                // Assume image is in User class
                user.setImage(rs.getString("image"));
                feedback.setUser(user);

                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setImage(rs.getString("image"));
                feedback.setBook(book);

                feedbackList.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public Feedback getFeedbackById(int feedbackId) {
        Feedback feedback = null;
        String sql = "SELECT f.feedback_id, f.order_item_id, f.rating, f.comment, f.created_at, "
                + "b.book_id, b.title, b.author, b.image, "
                + "u.user_id, u.fullname "
                + "FROM feedback f "
                + "JOIN order_items oi ON f.order_item_id = oi.order_item_id "
                + "JOIN books b ON oi.book_id = b.book_id "
                + "JOIN `orders` o ON o.order_id = oi.order_id "
                + "JOIN cart ca ON ca.cart_id = o.cart_id "
                + "JOIN users u ON ca.user_id = u.user_id "
                + "WHERE f.feedback_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedbackId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setOrderItemId(rs.getInt("order_item_id"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getDate("created_at"));

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                feedback.setUser(user);

                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setImage(rs.getString("image"));
                feedback.setBook(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedback;
    }

}
