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
import java.util.logging.Level;
import java.util.logging.Logger;
import models.ShippingInformations;

/**
 *
 * @author TDG
 */
public class DAOShipInfor extends DBConnect{
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
                Timestamp createdAt = rs.getTimestamp("created_At");
                Timestamp updatedAt = rs.getTimestamp("updated_At");


                 ShippingInformations b = new ShippingInformations(shippingId, userId, phone, address, createdAt, updatedAt);
                 list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOShipInfor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public static void main(String[] args) {
        DAOShipInfor dao = new DAOShipInfor();
        ArrayList<ShippingInformations> list = dao.getAll("select * from shipping_info");
        for (ShippingInformations shippingInformations : list) {
            System.out.println(shippingInformations);
        }
    }
}
