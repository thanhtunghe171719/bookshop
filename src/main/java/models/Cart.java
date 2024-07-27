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
public class Cart {
    private int cartId;
    private int userId;
    private String promotionId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String note;

    public Cart() {
    }

    public Cart(int cartId, int userId, String promotionId, Timestamp createdAt, Timestamp updatedAt, String note) {
        this.cartId = cartId;
        this.userId = userId;
        this.promotionId = promotionId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.note = note;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(String promotionId) {
        this.promotionId = promotionId;
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

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "cart{" + "cartId=" + cartId + ", userId=" + userId + ", promotionId=" + promotionId + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", note=" + note + '}';
    }
    
    
}