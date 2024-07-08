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
public class Posts {
    private int postId;
    private String image;
    private String title;
    private String postType;
    private int userId;
    private String description;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Posts() {
    }

    public Posts(int postId, String image, String title, String postType, int userId, String description, String status, Timestamp createdAt, Timestamp updatedAt) {
        this.postId = postId;
        this.image = image;
        this.title = title;
        this.postType = postType;
        this.userId = userId;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
        return "Posts{" + "postId=" + postId + ", image=" + image + ", title=" + title + ", postType=" + postType + ", userId=" + userId + ", description=" + description + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
}