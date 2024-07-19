/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author kobietkolam
 */
public class UserHistory {

    private String email;
    private String fullname;
    private String gender;
    private String mobile;
    private String address;
    private String updatedBy;
    private Timestamp updatedDate;

    public UserHistory() {
    }

    public UserHistory(String email, String fullname, String gender, String mobile, String address, String updatedBy, Timestamp updatedDate) {
        this.email = email;
        this.fullname = fullname;
        this.gender = gender;
        this.mobile = mobile;
        this.address = address;
        this.updatedBy = updatedBy;
        this.updatedDate = updatedDate;
    }

    public UserHistory(int aInt, int aInt0, String string, String string0, String string1, String string2, String string3, String string4) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Timestamp getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }

}
