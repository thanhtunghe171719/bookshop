/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package models;

/**
 *
 * @author HP
 */
public class SalesRepresentative {
    private int userId;
    private String fullname;
    private String email;
    private String phone;
    private String address;

    public SalesRepresentative() {
    }

    public SalesRepresentative(int userId, String fullname, String email, String phone, String address) {
        this.userId = userId;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
}
