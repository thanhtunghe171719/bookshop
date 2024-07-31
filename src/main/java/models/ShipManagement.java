/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package models;
import java.sql.Timestamp;

public class ShipManagement {
    private int shipId;
    private int orderId;
    private int userId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private User shipper;

    public ShipManagement() {}

    public ShipManagement(int shipId, int orderId, int userId, Timestamp createdAt, Timestamp updatedAt) {
        this.shipId = shipId;
        this.orderId = orderId;
        this.userId = userId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getShipId() {
        return shipId;
    }

    public void setShipId(int shipId) {
        this.shipId = shipId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public User getShipper() {
        return shipper;
    }

    public void setShipper(User shipper) {
        this.shipper = shipper;
    }
}