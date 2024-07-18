/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author HP
 */
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Book;
import models.Order;
import models.OrderItems;
import models.User;

public class OrderDAO extends DBConnect {

    private Connection connection;

    public OrderDAO() {
        connection = conn;
    }

    public Order getOrderById(int orderId) {
        Order order = null;
        try {
            String query = "SELECT "
                    + "orders.order_id, "
                    + "orders.cart_id, "
                    + "orders.total, "
                    + "order_status.order_status, "
                    + "orders.order_date, "
                    + "orders.updated_at, "
                    + "users.user_id, "
                    + "users.email, "
                    + "users.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "users.address "
                    + "FROM "
                    + "orders "
                    + "JOIN order_status ON orders.order_status_id = order_status.order_status_id "
                    + "JOIN cart ON orders.cart_id = cart.cart_id "
                    + "JOIN users ON cart.user_id = users.user_id "
                    + "WHERE orders.order_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCartId(rs.getInt("cart_id"));
                order.setTotal(rs.getDouble("total"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setUpdatedAt(rs.getDate("updated_at"));

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setFullname(rs.getString("fullname"));
                user.setGender(rs.getString("gender"));
                user.setImage(rs.getString("image"));
                user.setAddress(rs.getString("address"));

                order.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            String query = "SELECT "
                    + "orders.order_id, "
                    + "orders.cart_id, "
                    + "orders.total, "
                    + "order_status.order_status, "
                    + "orders.order_date, "
                    + "orders.updated_at, "
                    + "users.user_id, "
                    + "users.email, "
                    + "users.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "users.address "
                    + "FROM "
                    + "orders "
                    + "JOIN order_status ON orders.order_status_id = order_status.order_status_id "
                    + "JOIN cart ON orders.cart_id = cart.cart_id "
                    + "JOIN users ON cart.user_id = users.user_id";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCartId(rs.getInt("cart_id"));
                order.setTotal(rs.getDouble("total"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setUpdatedAt(rs.getDate("updated_at"));

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setFullname(rs.getString("fullname"));
                user.setGender(rs.getString("gender"));
                user.setImage(rs.getString("image"));
                user.setAddress(rs.getString("address"));
                order.setUser(user);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        try {
            String query = "SELECT "
                    + "orders.order_id, "
                    + "orders.cart_id, "
                    + "orders.total, "
                    + "order_status.order_status, "
                    + "orders.order_date, "
                    + "orders.updated_at, "
                    + "users.user_id, "
                    + "users.email, "
                    + "users.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "users.address "
                    + "FROM "
                    + "orders "
                    + "JOIN order_status ON orders.order_status_id = order_status.order_status_id "
                    + "JOIN cart ON orders.cart_id = cart.cart_id "
                    + "JOIN users ON cart.user_id = users.user_id "
                    + "where users.user_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCartId(rs.getInt("cart_id"));
                order.setTotal(rs.getDouble("total"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setUpdatedAt(rs.getDate("updated_at"));

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setFullname(rs.getString("fullname"));
                user.setGender(rs.getString("gender"));
                user.setImage(rs.getString("image"));
                user.setAddress(rs.getString("address"));
                order.setUser(user);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<OrderItems> getOrderItemsByOrderId(int orderId) {
        List<OrderItems> orderItems = new ArrayList<>();
        try {
            String query = "SELECT order_items.order_item_id,books.price, order_items.order_id, order_items.book_id, order_items.quantity, "
                    + "books.title, books.author, books.image "
                    + "FROM order_items "
                    + "JOIN books ON order_items.book_id = books.book_id "
                    + "WHERE order_items.order_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItems orderItem = new OrderItems();
                orderItem.setOrderItemId(rs.getInt("order_item_id"));
                orderItem.setOrderId(rs.getInt("order_id"));
                orderItem.setQuantity(rs.getInt("quantity"));

                Book book = new Book();
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setImage(rs.getString("image"));
                book.setPrice(rs.getBigDecimal("price"));
                orderItem.setBook(book);

                orderItems.add(orderItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    public List<OrderItems> getOrderItemsByOrderIdAndUser(int orderId) {
        List<OrderItems> orderItems = new ArrayList<>();
        try {
            String query = "SELECT order_items.order_item_id,books.price, order_items.order_id, order_items.book_id, order_items.quantity, "
                    + "books.title, books.author, books.image "
                    + "FROM order_items "
                    + "JOIN books ON order_items.book_id = books.book_id "
                    + "WHERE order_items.order_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItems orderItem = new OrderItems();
                orderItem.setOrderItemId(rs.getInt("order_item_id"));
                orderItem.setOrderId(rs.getInt("order_id"));
                orderItem.setQuantity(rs.getInt("quantity"));

                Book book = new Book();
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setImage(rs.getString("image"));
                book.setPrice(rs.getBigDecimal("price"));
                orderItem.setBook(book);

                orderItems.add(orderItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    public OrderItems getOrderItemById(int orderItemId) {
        OrderItems orderItem = null;
        try {
            String query = "SELECT order_items.order_item_id,books.price, order_items.order_id, order_items.book_id, order_items.quantity, "
                    + "books.title, books.author, books.image "
                    + "FROM order_items "
                    + "JOIN books ON order_items.book_id = books.book_id "
                    + "WHERE order_items.order_item_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderItemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                orderItem = new OrderItems();
                orderItem.setOrderItemId(rs.getInt("order_item_id"));
                orderItem.setOrderId(rs.getInt("order_id"));
                orderItem.setQuantity(rs.getInt("quantity"));
                Book book = new Book();
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setImage(rs.getString("image"));
                book.setPrice(rs.getBigDecimal("price"));
                orderItem.setBook(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItem;
    }

}
