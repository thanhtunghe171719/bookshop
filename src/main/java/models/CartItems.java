/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author TDG
 */
public class CartItems {
    private int cartItemId;
    private int cartId;
    private int bookId;
    private int quantity;

    public CartItems() {
    }

    public CartItems(int cartItemId, int cartId, int bookId, int quantity) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.bookId = bookId;
        this.quantity = quantity;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "CartItems{" + "cartItemId=" + cartItemId + ", cartId=" + cartId + ", bookId=" + bookId + ", quantity=" + quantity + '}';
    }
    
}