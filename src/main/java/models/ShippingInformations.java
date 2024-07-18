/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author TDG
 */
public class ShippingInformations {
    private int shippingId;
    private int userId;
    private String phone;
    private String address;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public ShippingInformations() {
    }

    public ShippingInformations(int shippingId, int userId, String phone, String address, Timestamp createdAt, Timestamp updatedAt) {
        this.shippingId = shippingId;
        this.userId = userId;
        this.phone = phone;
        this.address = address;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getShippingId() {
        return shippingId;
    }

    public void setShippingId(int shippingId) {
        this.shippingId = shippingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    @Override
    public String toString() {
        return "shipping_info{" + "shippingId=" + shippingId + ", userId=" + userId + ", phone=" + phone + ", address=" + address + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
    
    
}
