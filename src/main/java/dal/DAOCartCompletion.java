/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author skyfc
 */
public class DAOCartCompletion extends DBConnect {

    public int newOrder(int cartID, double total, int orderStatusID, String address, String phone) {
        String sql = "INSERT INTO `orders` (`cart_id`, `total`, `order_status_id`, `address`, `phone`)\n"
                + "VALUES\n"
                + "(?, ?, ?, ?, ?)";
        try {
            PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setInt(1, cartID);
            statement.setDouble(2, total);
            statement.setInt(3, orderStatusID);
            statement.setString(4, address);
            statement.setString(5, phone);
            statement.executeUpdate();

            // Lấy order_id mới tạo
            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
            return -1; // Trả về -1 nếu có lỗi
        }
    }

    public void addOrderItems(int orderID) {
        String sql = "INSERT INTO order_items (order_id, book_id, quantity)\n"
                + "SELECT \n"
                + "    ?,\n" // Sử dụng order_id đã truyền vào
                + "    ci.book_id,\n"
                + "    ci.quantity\n"
                + "FROM \n"
                + "    cart_items ci\n"
                + "JOIN \n"
                + "    orders o ON ci.cart_id = o.cart_id\n"
                + "WHERE o.order_id = ?;";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, orderID); // Truyền order_id vào câu lệnh SQL
            statement.setInt(2, orderID); // Truyền order_id vào câu lệnh SQL
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void removeOrderedBooks(int orderID) {
        String sql = "UPDATE books b\n"
                + "JOIN (\n"
                + "    SELECT book_id, SUM(quantity) as total_sold\n"
                + "    FROM order_items\n"
                + "    WHERE order_id = ?\n" // Sử dụng order_id đã truyền vào
                + "    GROUP BY book_id\n"
                + ") oi ON b.book_id = oi.book_id\n"
                + "SET b.stock = b.stock - oi.total_sold;";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, orderID); // Truyền order_id vào câu lệnh SQL
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        DAOCartCompletion cart = new DAOCartCompletion();
        int cart_id = 1;
        int re = cart.newOrder(29, 200, 1, "Minh Khai", "0828734612");
        System.out.println(re);
    }
}
