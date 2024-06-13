/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import controllers.CartDetails;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.CartItems;

/**
 *
 * @author TDG
 */
public class DAOCartDetails extends DBConnect{
    public ArrayList<CartItems> getAll(String sql) {
        ArrayList<CartItems> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                
                int cartItemId = rs.getInt("cart_item_id");
                int cartId = rs.getInt("cart_id");
                int bookId = rs.getInt("book_id");
                int quantity = rs.getInt("quantity");


                 CartItems c = new CartItems(cartItemId, cartId, bookId, quantity);
                 list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public boolean updateQuantity(int cartItemId, int quantity) {
        String query = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartItemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DAOCartDetails.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }
    
    public double getCartSubtotal(int cartId) {
        String query = "SELECT SUM(ci.quantity * b.price) AS subtotal "
                     + "FROM cart_items ci "
                     + "JOIN books b ON ci.book_id = b.book_id "
                     + "WHERE ci.cart_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("subtotal");
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOCartDetails.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public static void main(String[] args) {
        DAOCartDetails dao = new DAOCartDetails();
        int cartId = 2;
        ArrayList<CartItems> list = dao.getAll("Select * from cart_items where cart_id = "+cartId);
        for (CartItems cartItems : list) {
            System.out.println(cartItems);
        }
    }
}
