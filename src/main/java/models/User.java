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
public class User {
    private int userId;
    private String email;
    private String phone;
    private String password;
    private int roleId;
    private String fullname;
    private String gender;
    private String image;
    private String address;
    private Timestamp createAt;
    private Timestamp updatedAt;    

    public User() {
    }

    public User(int userId, String email, String phone, String password, int roleId, String fullname, String gender, String image, String address, Timestamp createAt, Timestamp updatedAt) {
        this.userId = userId;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.roleId = roleId;
        this.fullname = fullname;
        this.gender = gender;
        this.image = image;
        this.address = address;
        this.createAt = createAt;
        this.updatedAt = updatedAt;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Users{" + "userId=" + userId + ", email=" + email + ", phone=" + phone + ", password=" + password + ", roleId=" + roleId + ", fullname=" + fullname + ", gender=" + gender + ", image=" + image + ", address=" + address + ", createAt=" + createAt + ", updatedAt=" + updatedAt + '}';
    }
    
    
}
