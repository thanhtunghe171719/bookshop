/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author TDG
 */
public class Book {
    private int bookId;
    private String title;
    private String author;
    private String image;
    private int categoryId;
    private String publishingHouse;
    private int publishedYear;
    private String size;
    private String weight;
    private String summary;
    private BigDecimal price;
    private Integer rating;
    private Integer discount;
    private int stock;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String format;
    private int pages;

    public Book() {
    }

    public Book(int bookId, String title, String author, String image, int categoryId, String publishingHouse, int publishedYear, String size, String weight, String summary, BigDecimal price, Integer rating, Integer discount, int stock, Timestamp createdAt, Timestamp updatedAt, String format, int pages) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.image = image;
        this.categoryId = categoryId;
        this.publishingHouse = publishingHouse;
        this.publishedYear = publishedYear;
        this.size = size;
        this.weight = weight;
        this.summary = summary;
        this.price = price;
        this.rating = rating;
        this.discount = discount;
        this.stock = stock;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.format = format;
        this.pages = pages;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getPublishingHouse() {
        return publishingHouse;
    }

    public void setPublishingHouse(String publishingHouse) {
        this.publishingHouse = publishingHouse;
    }

    public int getPublishedYear() {
        return publishedYear;
    }

    public void setPublishedYear(int publishedYear) {
        this.publishedYear = publishedYear;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
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

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    @Override
    public String toString() {
        return "Books{" + "bookId=" + bookId + ", title=" + title + ", author=" + author + ", image=" + image + ", categoryId=" + categoryId + ", publishingHouse=" + publishingHouse + ", publishedYear=" + publishedYear + ", size=" + size + ", weight=" + weight + ", summary=" + summary + ", price=" + price + ", rating=" + rating + ", discount=" + discount + ", stock=" + stock + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", format=" + format + ", pages=" + pages + '}';
    }

    
}