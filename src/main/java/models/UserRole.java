/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author ADMIN
 */
public class UserRole {
    private int role_id;
    private String role_name;
    private int status_id;
    private Timestamp create_at;
    private Timestamp updated_at;
    public UserRole(){
    }

    public UserRole(int role_id, String role_name, int status_id, Timestamp create_at, Timestamp updated_at) {
        this.role_id = role_id;
        this.role_name = role_name;
        this.status_id = status_id;
        this.create_at = create_at;
        this.updated_at = updated_at;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name;
    }

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public Timestamp getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Timestamp create_at) {
        this.create_at = create_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }
    
}
