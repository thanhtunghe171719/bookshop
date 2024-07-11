/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author kobietkolam
 */
public class Post {

    private int postId;
    private String image;
    private String title;
    private int userId;
    private String description;
    private String postType;
    private String status;
    private Date createdAt;
    private Date updateAt;
    private String authorName;

    public Post() {
    }
    public boolean isHidden() {
    return "Hide".equals(this.status);
}

    public Post(int postId, String image, String title, int userId, String description, String postType, String status, Date createdAt, Date updateAt, String authorName) {
        this.postId = postId;
        this.image = image;
        this.title = title;
        this.userId = userId;
        this.description = description;
        this.postType = postType;
        this.status = status;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
        this.authorName = authorName;
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

    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    @Override
    public String toString() {
        return "Post{" + "postId=" + postId + ", image=" + image + ", title=" + title + ", userId=" + userId + ", description=" + description + ", postType=" + postType + ", status=" + status + ", createdAt=" + createdAt + ", updateAt=" + updateAt + ", authorName=" + authorName + '}';
    }

}