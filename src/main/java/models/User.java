/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
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
    private String status;
    private String deleted;
    private String roleName;

    public User() {
    }

    public User(int userId, String email, String phone, String password, int roleId, String fullname, String gender, String address, Timestamp createAt, Timestamp updatedAt, String image, String status, String deleted) {
        this.userId = userId;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.roleId = roleId;
        this.fullname = fullname;
        this.gender = gender;
        this.address = address;
        this.createAt = createAt;
        this.updatedAt = updatedAt;
        this.image = image;
        this.status = status;
        this.deleted = deleted;
    }

    public User(String fullname, String gender, String email, String phone, String status) {
        this.fullname = fullname;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.status = status;
    }

    public User(int userId, String fullname, String gender, String email, String phone, String status) {
        this.userId = userId;
        this.fullname = fullname;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.status = status;
    }

    public User(String fullname, int userId, String gender, String email, String phone, String address) {
        this.userId = userId;
        this.fullname = fullname;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    public User(int userId, String fullname, String gender, String email, String phone, String address, String status, Timestamp updatedAt) {
        this.userId = userId;
        this.phone = phone;
        this.fullname = fullname;
        this.gender = gender;
        this.address = address;
        this.updatedAt = updatedAt;
        this.status = status;
    }

    public User(String fullname, String gender, String email, String password, String phone, String status) {
        this.fullname = fullname;
        this.gender = gender;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.status = status;
    }
//userId, fullname, gender, email, phone, roleName, status
    public User(int userId, String fullname, String gender, String email, String phone, String address, String status) {
        this.userId = userId;
        this.email = email;
        this.phone = phone;
        this.fullname = fullname;
        this.gender = gender;
        this.address = address;
        this.status = status;
    }
     public User( String fullname,int userId, String gender, String email, String phone, String address, String image) {
        this.userId = userId;
        this.email = email;
        this.phone = phone;
        this.fullname = fullname;
        this.gender = gender;
        this.address = address;
        this.image = image;
    }
     //fullname,  gender,userId, email, phone, roleName, status
     public User(String fullname, String gender, int userId,  String email, String phone, String roleName, String status) {
        this.userId = userId;
        this.email = email;
        this.phone = phone;
        this.fullname = fullname;
        this.gender = gender;
        this.roleName = roleName;
        this.status = status;
    }

    public User(String fullname, String gender, String email, String password, String phone, String status, String roleName) {
       this.fullname = fullname;
        this.gender = gender;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.status = status;
        this.roleName = roleName;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", email=" + email + ", phone=" + phone + ", password=" + password + ", roleId=" + roleId + ", fullname=" + fullname + ", gender=" + gender + ", address=" + address + ", createAt=" + createAt + ", updatedAt=" + updatedAt + ", image=" + image + ", status=" + status + ", deleted=" + deleted + ", roleName=" + roleName + '}';
    }

}
