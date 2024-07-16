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
import models.Orders;

/**
 *
 * @author skyfc
 */
public class DAOOrders extends DBConnect {

    public ArrayList<Orders> getOrders(int cartID) {
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
                    + "    CASE WHEN rn = 1 THEN order_status ELSE '' END as order_status\n"
                    + "FROM OrderDetails\n"
                    + "ORDER BY order_date DESC;";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, cartID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {

                int orderID = rs.getInt("order_id");
                Timestamp orderDate = rs.getTimestamp("order_date");
                double total = rs.getDouble("total");
                String status = rs.getString("order_status");

                Orders o = new Orders(orderID, orderDate, total, status);
                List<Items> items = getOrderItemsForOrder(orderID);
                o.setOrderItems(items);
                list.add(o);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrders.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
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

    public ArrayList<Orders> getOrdersByID(String id) {
        ArrayList<Orders> list = new ArrayList<>();
        try {
            String sql = "SELECT o.order_id, o.order_date, o.total, ot.order_status \n"
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

                Orders o = new Orders(orderID, orderDate, total, status);
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

    public static void main(String[] args) {
        DAOOrders order = new DAOOrders();
//        ArrayList<Items> re = order.getOrderItemsForOrder(1);
        int cancel = order.cancelOrder(2);
        System.out.println(cancel);
    }
}
