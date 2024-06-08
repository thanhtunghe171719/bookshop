/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author TDG
 */
public class Categories {
    private int categoryId;
    private String categoryName;
    private String image;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Categories() {
    }

    public Categories(int categoryId, String categoryName, String image, Timestamp createdAt, Timestamp updatedAt) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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
        return "Categories{" + "categoryId=" + categoryId + ", categoryName=" + categoryName + ", image=" + image + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
}
