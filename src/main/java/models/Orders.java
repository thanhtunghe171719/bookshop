/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author skyfc
 */
public class Orders {

    private int orderID;
    private Timestamp orderDate;
    private List<Items> orderItems;
    private double total;
    private String status;
    private int statusId;
    private String address;
    private String phone;

    public Orders() {
    }

    public Orders(int orderID, Timestamp orderDate, double total, String status, String address, String phone) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.status = status;
        this.address = address;
        this.phone = phone;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public List<Items> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<Items> orderItems) {
        this.orderItems = orderItems;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    
}
