/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Items;
import models.Order;
import models.Orders;
import models.User;

/**
 *
 * @author skyfc
 */
public class DAOOrders extends DBConnect {

    public ArrayList<Orders> getOrders(int cartID, int index) {
        ArrayList<Orders> list = new ArrayList<>();
        try {
            String sql = "WITH OrderDetails AS (\n"
                    + "    SELECT \n"
                    + "        o.order_id, \n"
                    + "        o.order_date, \n"
                    + "        b.title, \n"
                    + "        oi.quantity, \n"
                    + "        o.total, \n"
                    + "        ot.order_status,\n"
                    + "        o.address,\n"
                    + "        o.phone,\n"
                    + "        ROW_NUMBER() OVER (PARTITION BY o.order_id ORDER BY b.title) as rn\n"
                    + "    FROM orders o\n"
                    + "    JOIN order_items oi on oi.order_id = o.order_id\n"
                    + "    JOIN books b on oi.book_id = b.book_id\n"
                    + "    JOIN order_status ot on o.order_status_id = ot.order_status_id\n"
                    + "    WHERE o.cart_id = ?\n"
                    + ")\n"
                    + "SELECT\n"
                    + "    CASE WHEN rn = 1 THEN order_id ELSE '' END as order_id,\n"
                    + "    CASE WHEN rn = 1 THEN order_date ELSE '' END as order_date,\n"
                    + "    title,\n"
                    + "    quantity,\n"
                    + "    CASE WHEN rn = 1 THEN total ELSE '' END as total,\n"
                    + "    CASE WHEN rn = 1 THEN order_status ELSE '' END as order_status,\n"
                    + "    CASE WHEN rn = 1 THEN address ELSE '' END as address,\n"
                    + "    CASE WHEN rn = 1 THEN phone ELSE '' END as phone\n"
                    + "FROM OrderDetails\n"
                    + "ORDER BY order_date DESC\n" // Keep orders sorted by date
                    + "LIMIT 3 OFFSET ?;";

            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, cartID);
            statement.setInt(2, (index - 1) * 3);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt("order_id");
                Timestamp orderDate = rs.getTimestamp("order_date");
                double total = rs.getDouble("total");
                String status = rs.getString("order_status");
                String address = rs.getString("address");
                String phone = rs.getString("phone");

                Orders o = new Orders(orderID, orderDate, total, status, address, phone);
                List<Items> items = getOrderItemsForOrder(orderID);
                o.setOrderItems(items);
                list.add(o);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrders.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Orders> getOrdersByStatus(int cartID, int index, String statusFilter) {
        ArrayList<Orders> list = new ArrayList<>();
        try {
            // Validate status filter
            String statusCondition = "";
            if (!statusFilter.equals("all")) {
                statusCondition = "AND ot.order_status = ?";
            }

            String sql = "WITH OrderDetails AS (\n"
                    + "    SELECT \n"
                    + "        o.order_id, \n"
                    + "        o.order_date, \n"
                    + "        b.title, \n"
                    + "        oi.quantity, \n"
                    + "        o.total, \n"
                    + "        ot.order_status,\n"
                    + "        o.address,\n"
                    + "        o.phone,\n"
                    + "        ROW_NUMBER() OVER (PARTITION BY o.order_id ORDER BY b.title) as rn\n"
                    + "    FROM orders o\n"
                    + "    JOIN order_items oi on oi.order_id = o.order_id\n"
                    + "    JOIN books b on oi.book_id = b.book_id\n"
                    + "    JOIN order_status ot on o.order_status_id = ot.order_status_id\n"
                    + "    WHERE o.cart_id = ? " + statusCondition + "\n"
                    + ")\n"
                    + "SELECT\n"
                    + "    CASE WHEN rn = 1 THEN order_id ELSE '' END as order_id,\n"
                    + "    CASE WHEN rn = 1 THEN order_date ELSE '' END as order_date,\n"
                    + "    title,\n"
                    + "    quantity,\n"
                    + "    CASE WHEN rn = 1 THEN total ELSE '' END as total,\n"
                    + "    CASE WHEN rn = 1 THEN order_status ELSE '' END as order_status,\n"
                    + "    CASE WHEN rn = 1 THEN address ELSE '' END as address,\n"
                    + "    CASE WHEN rn = 1 THEN phone ELSE '' END as phone\n"
                    + "FROM OrderDetails\n"
                    + "ORDER BY order_date DESC\n" // Keep orders sorted by date
                    + "LIMIT 2 OFFSET ?;";

            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, cartID);
            int paramIndex = 2;
            if (!statusFilter.equals("all")) {
                statement.setString(paramIndex++, statusFilter);
            }
            statement.setInt(paramIndex, (index - 1) * 2);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt("order_id");
                Timestamp orderDate = rs.getTimestamp("order_date");
                double total = rs.getDouble("total");
                String status = rs.getString("order_status");
                String address = rs.getString("address");
                String phone = rs.getString("phone");

                Orders o = new Orders(orderID, orderDate, total, status, address, phone);
                List<Items> items = getOrderItemsForOrder(orderID);
                o.setOrderItems(items);
                list.add(o);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrders.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getOrderCount(int cartID) {
        String query = "SELECT COUNT(*) FROM orders o\n"
                + "WHERE o.cart_id = ?;";
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, cartID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Count: " + e);
        }
        return 0;
    }

    // Add this method to your DAOOrders class
    public int getOrderCountByStatus(String status, int cartID) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM orders o "
                + "JOIN order_status os ON o.order_status_id = os.order_status_id "
                + "WHERE os.order_status = ? AND o.cart_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, cartID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public ArrayList<Items> getOrderItemsForOrder(int orderId) {
        ArrayList<Items> orderItems = new ArrayList<>();

        String sql = "SELECT oi.order_item_id, b.title, oi.quantity, b.price, b.discount\n"
                + "FROM order_items oi\n"
                + "JOIN books b ON oi.book_id = b.book_id\n"
                + "WHERE oi.order_id = ?";

        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Items item = new Items();
                    item.setItemId(resultSet.getInt("order_item_id"));
                    item.setTitle(resultSet.getString("title"));
                    item.setQuantity(resultSet.getInt("quantity"));
                    item.setPrice(resultSet.getDouble("price"));
                    item.setDiscount(resultSet.getInt("discount"));
                    orderItems.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    public int getOrdersCount() {
        int totalOrders = 0;
        String sql = "SELECT COUNT(*) as totalOrders FROM orders";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt("totalOrders");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalOrders;
    }

    public int getTotalPendingOrder() {
        int totalPendingOrder = 0;
        String sql = "SELECT COUNT(*) as totalPendingOrder FROM orders\n"
                + "where order_status_id = 1;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalPendingOrder = rs.getInt("totalPendingOrder");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPendingOrder;
    }

    public int getTotalShippingOrder() {
        int totalShippingOrder = 0;
        String sql = "SELECT COUNT(*) as totalShippingOrder FROM orders\n"
                + "where order_status_id = 3;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalShippingOrder = rs.getInt("totalShippingOrder");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalShippingOrder;
    }

    public int getTotalDeliveredOrder() {
        int totalDeliveredOrder = 0;
        String sql = "SELECT COUNT(*) as totalDeliveredOrder FROM orders\n"
                + "where order_status_id = 4;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalDeliveredOrder = rs.getInt("totalDeliveredOrder");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalDeliveredOrder;
    }

    public int getTotalCanceledOrder() {
        int totalCanceledOrder = 0;
        String sql = "SELECT COUNT(*) as totalCanceledOrder FROM orders\n"
                + "where order_status_id = 5;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalCanceledOrder = rs.getInt("totalCanceledOrder");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCanceledOrder;
    }

    public double getTotalProfit() {
        double totalProfit = 0.0;
        String sql = "SELECT SUM(total) as total FROM orders WHERE order_status_id = 4";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalProfit = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProfit;
    }

    public ArrayList<Orders> getOrdersByID(String id) {
        ArrayList<Orders> list = new ArrayList<>();
        try {
            String sql = "SELECT o.order_id, o.order_date, o.total, ot.order_status, o.address, o.phone \n"
                    + "FROM orders o\n"
                    + "JOIN order_status ot ON o.order_status_id = ot.order_status_id\n"
                    + "WHERE o.order_id = ?\n"
                    + "ORDER BY o.order_date DESC;";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {

                int orderID = rs.getInt("order_id");
                Timestamp orderDate = rs.getTimestamp("order_date");
                double total = rs.getDouble("total");
                String status = rs.getString("order_status");
                String address = rs.getString("address");
                String phone = rs.getString("phone");

                Orders o = new Orders(orderID, orderDate, total, status, address, phone);
                list.add(o);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrders.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int cancelOrder(int orderID) {
        String sql = "UPDATE orders SET order_status_id = 5\n"
                + "WHERE order_id = ?";
        try (PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setInt(1, orderID);
            return ptm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrders.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int updateInventoryOnCancel(int orderId) {
        String selectSql = "SELECT book_id, quantity FROM order_items WHERE order_id = ?";
        String updateStockSql = "UPDATE books b SET b.stock = b.stock + ? WHERE b.book_id = ?";
        int updatedCount = 0; // Count of successfully updated items

        try (PreparedStatement selectStmt = conn.prepareStatement(selectSql); PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSql)) {
            selectStmt.setInt(1, orderId);
            try (ResultSet rs = selectStmt.executeQuery()) {
                // Check if the result set contains data
                if (!rs.isBeforeFirst()) {
                    System.out.println("No order items found for order ID: " + orderId);
                    return updatedCount; // No items found, return 0
                }

                // Loop through each item in the order
                while (rs.next()) {
                    int bookId = rs.getInt("book_id");
                    int quantity = rs.getInt("quantity");

                    // Log retrieved book details
                    System.out.println("Updating stock for book ID: " + bookId + ", quantity: " + quantity);

                    // Update the stock for each book in the order
                    updateStockStmt.setInt(1, quantity);
                    updateStockStmt.setInt(2, bookId);
                    int rowsAffected = updateStockStmt.executeUpdate();

                    // Increment the count if the stock was updated successfully
                    if (rowsAffected > 0) {
                        updatedCount++;
                        System.out.println("Stock updated successfully for book ID: " + bookId);
                    } else {
                        System.out.println("Failed to update stock for book ID: " + bookId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updatedCount; // Return the number of successfully updated items
    }

    public double getTotalProfitByMonth(int month) {
        double totalProfit = 0.0;
        String sql = "SELECT SUM(total) as total FROM orders WHERE order_status_id = 4 and month(order_date)=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, month);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProfit;
    }
    public int getOrderSuccessfulCountByMonth(int month) {
    String sql = "SELECT COUNT(*) as total_successful_orders FROM orders WHERE order_status_id = 4 AND MONTH(order_date) = ?";
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

// public List<Order> selectNewOrders() {
//        List<Order> orders = new ArrayList<>();
//        String sql = "SELECT * FROM orders where create_at = ?";
//        try (
//             PreparedStatement preparedStatement = conn.prepareStatement(sql);) {
//            ResultSet rs = preparedStatement.executeQuery();
//
//            while (rs.next()) {
//                int id = rs.getInt("id");
//                String orderStatus = rs.getString("order_status");
//                TimeStamp orderDate = rs.getDate("order_date");
//                orders.add(new Order(id, orderStatus, orderDate));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return orders;
//    }

    public static void main(String[] args) {
        DAOOrders order = new DAOOrders();
//        ArrayList<Items> re = order.getOrderItemsForOrder(1);
//        int cancel = order.cancelOrder(2);
//        int count = order.getOrderCountByStatus("Canceled");
        ArrayList<Orders> o = order.getOrders(29, 1);
//        ArrayList<Items> o = order.getOrderItemsForOrder(9);

//        int update = order.updateInventoryOnCancel(66);
        System.out.println(o);
    }
}
