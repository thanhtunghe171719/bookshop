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
import java.util.logging.Level;
import java.util.logging.Logger;
import models.ShippingInformations;

/**
 *
 * @author TDG
 */
public class DAOShipInfor extends DBConnect {

    public ArrayList<ShippingInformations> getAll(String sql) {
        ArrayList<ShippingInformations> list = new ArrayList<>();
        try {

            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {

                int shippingId = rs.getInt("shipping_Id");
                int userId = rs.getInt("user_Id");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                int action = rs.getInt("action");
                Timestamp createdAt = rs.getTimestamp("created_At");
                Timestamp updatedAt = rs.getTimestamp("updated_At");

                ShippingInformations b = new ShippingInformations(shippingId, userId, phone, address, action, createdAt, updatedAt);
                list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOShipInfor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int deleteBook(int shipId) {
        String sql = "DELETE FROM shipping_info WHERE shipping_id = ?";
        try (PreparedStatement state = conn.prepareStatement(sql)) {
            state.setInt(1, shipId);
            return state.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Delete error: " + ex);
        }
        return 0;
    }

    public int updateBook(ShippingInformations infor) {
        String sql = "UPDATE `shipping_info` SET`user_id` = ?,`phone` = ?,`address` = ?,`action` = ?,\n"
                + "`created_at` = ?,`updated_at` = ?WHERE `shipping_id` = ?;";
        try (PreparedStatement state = conn.prepareStatement(sql)) {
            state.setInt(1, infor.getUserId());
            state.setString(2, infor.getPhone());
            state.setString(3, infor.getAddress());
            state.setInt(4, infor.getAction());
            state.setTimestamp(5, infor.getCreatedAt());
            state.setTimestamp(6, infor.getUpdatedAt());
            state.setInt(7, infor.getShippingId());

            return state.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Update book error: " + ex);
        }
        return 0;
    }

    public int insert(ShippingInformations obj) {
        int n = 0;
        String sql = "INSERT INTO shipping_info (user_id, phone, address) VALUES (?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, obj.getUserId()); 
            pstmt.setString(2, obj.getPhone()); 
            pstmt.setString(3, obj.getAddress()); 

            n = pstmt.executeUpdate(); 
        } catch (SQLException ex) {
            Logger.getLogger(DAOShipInfor.class.getName()).log(Level.SEVERE, "SQL Error: ", ex);
        }

        System.out.println(n);
        return n;
    }

    public static void main(String[] args) {
        DAOShipInfor dao = new DAOShipInfor();
//        ArrayList<ShippingInformations> list = dao.getAll("select * from shipping_info");
//        for (ShippingInformations shippingInformations : list) {
//            System.out.println(shippingInformations);
//        }
//        ShippingInformations ship = dao.getAll("Select * from shipping_info;").get(0);
//        ship.setAction(0);
//        if (dao.updateBook(ship) > 0) {
//            System.out.println("oke");
//        } else {
//            System.out.println("not ok");
//        }
        ShippingInformations ship = new ShippingInformations();
        ship.setUserId(4);
        ship.setAddress("091214981374102");
        System.out.println(ship);
        if (dao.insert(ship) > 0) {
            System.out.println("oke");
        } else {
            System.out.println("not oke");
        }
    }
}
