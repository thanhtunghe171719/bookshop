/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.OrderItems;

/**
 *
 * @author TDG
 */
public class DAOOrderItems extends DBConnect{
    public ArrayList<OrderItems> getAll(String sql) {
        ArrayList<OrderItems> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                
                int orderItemId = rs.getInt("order_item_id");
                int orderId = rs.getInt("order_id");
                int bookId = rs.getInt("book_id");
                int quantity = rs.getInt("quantity");

                 OrderItems b = new OrderItems(orderItemId, orderId, bookId, quantity);
                 list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOBooks.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<Integer> getBookId(String sql) {
        List<Integer> list = new ArrayList<>();
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                
                int bookId = rs.getInt("book_id");

                 list.add(bookId);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOBooks.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
