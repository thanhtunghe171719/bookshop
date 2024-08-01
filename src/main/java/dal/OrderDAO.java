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
import models.OrderStatus;
import models.SalesRepresentative;
import models.ShipManagement;
import models.User;
import models.users;

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
                    + "orders.order_status_id, "
                    + "orders.order_date, "
                    + "orders.updated_at, "
                    + "users.user_id, "
                    + "users.email, "
                    + "orders.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "orders.address "
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
                order.setStatusId(rs.getInt("order_status_id"));
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
    
    public Order getOrderByIdUser(int orderId, int userId) {
        Order order = null;
        try {
            String query = "SELECT "
                    + "orders.order_id, "
                    + "orders.cart_id, "
                    + "orders.total, "
                    + "order_status.order_status, "
                    + "orders.order_status_id, "
                    + "orders.order_date, "
                    + "orders.updated_at, "
                    + "users.user_id, "
                    + "users.email, "
                    + "orders.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "orders.address "
                    + "FROM "
                    + "orders "
                    + "JOIN order_status ON orders.order_status_id = order_status.order_status_id "
                    + "JOIN cart ON orders.cart_id = cart.cart_id "
                    + "JOIN users ON cart.user_id = users.user_id "
                    + "JOIN sale_management as sm on sm.order_id = orders.order_id "
                    + "WHERE orders.order_id = ? and sm.user_id=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCartId(rs.getInt("cart_id"));
                order.setStatusId(rs.getInt("order_status_id"));
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
    
    public Order getOrderByIdShipper(int orderId, int userId) {
        Order order = null;
        try {
            String query = "SELECT "
                    + "orders.order_id, "
                    + "orders.cart_id, "
                    + "orders.total, "
                    + "order_status.order_status, "
                    + "orders.order_status_id, "
                    + "orders.order_date, "
                    + "orders.updated_at, "
                    + "users.user_id, "
                    + "users.email, "
                    + "orders.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "orders.address "
                    + "FROM "
                    + "orders "
                    + "JOIN order_status ON orders.order_status_id = order_status.order_status_id "
                    + "JOIN cart ON orders.cart_id = cart.cart_id "
                    + "JOIN users ON cart.user_id = users.user_id "
                    + "JOIN ship_management as sm on sm.order_id = orders.order_id "
                    + "WHERE orders.order_id = ? and sm.user_id=?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCartId(rs.getInt("cart_id"));
                order.setStatusId(rs.getInt("order_status_id"));
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
                    + "orders.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "orders.address "
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
                    + "orders.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "orders.address "
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

    public List<Order> getAllOrdersByUserStaff(int userId) {
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
                    + "orders.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "orders.address "
                    + "FROM "
                    + "orders "
                    + "JOIN order_status ON orders.order_status_id = order_status.order_status_id "
                    + "JOIN cart ON orders.cart_id = cart.cart_id "
                    + "JOIN users ON cart.user_id = users.user_id "
                    + "JOIN sale_management as sm on sm.order_id = orders.order_id "
                    + "where sm.user_id = ?";
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
    
    public List<Order> getAllOrdersByUserShipper(int shipper) {
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
                    + "orders.phone, "
                    + "users.fullname, "
                    + "users.gender, "
                    + "users.image, "
                    + "orders.address "
                    + "FROM "
                    + "orders "
                    + "JOIN order_status ON orders.order_status_id = order_status.order_status_id "
                    + "JOIN cart ON orders.cart_id = cart.cart_id "
                    + "JOIN users ON cart.user_id = users.user_id "
                    + "JOIN ship_management as sm on sm.order_id = orders.order_id "
                    + "where sm.user_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, shipper);
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

    public List<OrderStatus> getAllOrderStatuses() {
        List<OrderStatus> statuses = new ArrayList<>();
        String sql = "SELECT order_status_id, order_status, create_at, updated_at FROM order_status";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrderStatus status = new OrderStatus();
                status.setOrderStatusId(rs.getInt("order_status_id"));
                status.setOrderStatus(rs.getString("order_status"));
                status.setCreatedAt(rs.getDate("create_at"));
                status.setUpdatedAt(rs.getDate("updated_at"));
                statuses.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statuses;
    }

    public void updateOrderStatus(int orderId, int statusId) {
        String sql = "UPDATE orders SET order_status_id = ?, updated_at = NOW() WHERE order_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, statusId);
            ps.setInt(2, orderId);
            int result = ps.executeUpdate();
            if(result >= 1 && statusId == 5) {
                OrderDAO orderDao = new OrderDAO();
                List<OrderItems> orderItems = orderDao.getOrderItemsByOrderId(orderId);
                DAOBooks bookDao = new DAOBooks();
                for (OrderItems orderItem : orderItems) {
                    bookDao.updateQuantityBook(orderItem.getBookId(), orderItem.getQuantity());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderItems> getOrderItemsByOrderId(int orderId) {
        List<OrderItems> orderItems = new ArrayList<>();
        try {
            String query = "SELECT order_items.order_item_id,books.price, order_items.order_id, order_items.book_id, order_items.quantity, "
                    + "books.title, books.author, books.image, books.book_id "
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
                orderItem.setBookId(rs.getInt("book_id"));

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

    public List<OrderItems> getOrderItemsByOrderIdUser(int orderId, int userId) {
        List<OrderItems> orderItems = new ArrayList<>();
        try {
            String query = "SELECT order_items.order_item_id,books.price, order_items.order_id, order_items.book_id, order_items.quantity, "
                    + "books.title, books.author, books.image "
                    + "FROM order_items "
                    + "JOIN books ON order_items.book_id = books.book_id "
                    + "JOIN sale_management as sm on sm.order_id = order_items.order_id "
                    + "WHERE order_items.order_id = ? and userId = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
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

    public ArrayList<User> getAllSale() {
        ArrayList<User> list = new ArrayList<>();
        String sqlGet = "select * from Users where role_id = 3";
        try {

            PreparedStatement st = conn.prepareStatement(sqlGet);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                int userId = rs.getInt("user_id");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String password = rs.getString("password");
                int roleId = rs.getInt("role_id");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String image = rs.getString("image");
                String address = rs.getString("address");
                java.sql.Timestamp createdAt = new java.sql.Timestamp(System.currentTimeMillis());
                java.sql.Timestamp updatedAt = new java.sql.Timestamp(System.currentTimeMillis());
                String status = rs.getString("status");
                String deleted = "";
                User c = new User(userId, email, phone, password, roleId, fullname, gender, address, createdAt, updatedAt, image, status, deleted);
                list.add(c);
            }
        } catch (SQLException ex) {
            System.out.println("Ex: " + ex);
        }
        return list;
    }
    
    public ArrayList<User> getAllShip() {
        ArrayList<User> list = new ArrayList<>();
        String sqlGet = "select * from Users where role_id = 6";
        try {

            PreparedStatement st = conn.prepareStatement(sqlGet);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                int userId = rs.getInt("user_id");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String password = rs.getString("password");
                int roleId = rs.getInt("role_id");
                String fullname = rs.getString("fullname");
                String gender = rs.getString("gender");
                String image = rs.getString("image");
                String address = rs.getString("address");
                java.sql.Timestamp createdAt = new java.sql.Timestamp(System.currentTimeMillis());
                java.sql.Timestamp updatedAt = new java.sql.Timestamp(System.currentTimeMillis());
                String status = rs.getString("status");
                String deleted = "";
                User c = new User(userId, email, phone, password, roleId, fullname, gender, address, createdAt, updatedAt, image, status, deleted);
                list.add(c);
            }
        } catch (SQLException ex) {
            System.out.println("Ex: " + ex);
        }
        return list;
    }

    public void updateOrInsertSaleForOrder(int orderId, int saleId) {
        String checkSql = "SELECT COUNT(*) FROM sale_management WHERE order_id = ?";
        String insertSql = "INSERT INTO sale_management (order_id, user_id, updated_at) VALUES (?, ?, NOW())";
        String updateSql = "UPDATE sale_management SET user_id = ?, updated_at = NOW() WHERE order_id = ?";

        try {
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, orderId);
            ResultSet rs = checkPs.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setInt(1, saleId);
                updatePs.setInt(2, orderId);
                updatePs.executeUpdate();
            } else {
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setInt(1, orderId);
                insertPs.setInt(2, saleId);
                insertPs.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
    }

    public SalesRepresentative getAssignedSalesForOrder(int orderId) {
        String sql = "SELECT u.user_id, u.fullname, u.email, u.phone, u.address "
                + "FROM sale_management sm "
                + "JOIN users u ON sm.user_id = u.user_id "
                + "WHERE sm.order_id = ?";
        SalesRepresentative salesRep = null;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                salesRep = new SalesRepresentative();
                salesRep.setUserId(rs.getInt("user_id"));
                salesRep.setFullname(rs.getString("fullname"));
                salesRep.setEmail(rs.getString("email"));
                salesRep.setPhone(rs.getString("phone"));
                salesRep.setAddress(rs.getString("address"));
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return salesRep;
    }
    
    public ShipManagement getAssignedShipForOrder(int orderId) {
        String sql = "SELECT u.user_id, u.fullname, u.email, u.phone, u.address "
                + "FROM ship_management sm "
                + "JOIN users u ON sm.user_id = u.user_id "
                + "WHERE sm.order_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            DAOUsers userDao = new DAOUsers();
            if (rs.next()) {
                ShipManagement shipManagement = new ShipManagement();
                User user = userDao.getUserById(rs.getInt("user_id"));
                shipManagement.setShipper(user);
                return shipManagement;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

}
