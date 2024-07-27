/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Cart;
import models.Orders;

/**
 *
 * @author TDG
 */
public class DAOCart extends DBConnect {

    public ArrayList<Cart> getAll(String sql) {
        ArrayList<Cart> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int cartId = rs.getInt("cart_id");
                int userId = rs.getInt("user_id");
                String promotionId = rs.getString("promotion_id");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                String note = rs.getString("note");

                Cart p = new Cart(cartId, userId, promotionId, createdAt, updatedAt, note);
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int insert(Cart obj) {
        int n = 0;
        String sql = "INSERT INTO cart (user_id, promotion_id, note) VALUES \n"
                + "(" + obj.getUserId() + ", null, 'Đã Insert.')";
        System.out.println(sql);
        Statement state;
        try {
            state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int getCartId(int userId) {
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery("Select cart_id from cart where user_id = " + userId);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSlider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public static void main(String[] args) {
        DAOCart dao = new DAOCart();
        int userId = 9;
        int cartId = dao.getCartId(userId);
        if (cartId != 0) {
            System.out.println(cartId);
        } else {
            System.out.println("no output");
        }
    }
}
