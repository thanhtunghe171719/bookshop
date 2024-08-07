/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;
import java.text.DecimalFormat;


/**
 *
 * @author skyfc
 */
public class Books {
    private DecimalFormat df = new DecimalFormat("#.000");
    
    int book_id;
    String title;
    String author;
    String image;
    int category_id;
    String publishing_house;
    int published_year;
    String size;
    String weight;
    String summary;
    double price;
    int rating;
    int discount;
    int stock;
    Date create_at;
    Date update_at;

    public Books() {
    }

    public Books(int book_id, String title, String author, String image, int category_id, String publishing_house, int published_year, String size, String weight, String summary, double price, int rating, int discount, int stock, Date create_at, Date update_at) {
        this.book_id = book_id;
        this.title = title;
        this.author = author;
        this.image = image;
        this.category_id = category_id;
        this.publishing_house = publishing_house;
        this.published_year = published_year;
        this.size = size;
        this.weight = weight;
        this.summary = summary;
        this.price = price;
        this.rating = rating;
        this.discount = discount;
        this.stock = stock;
        this.create_at = create_at;
        this.update_at = update_at;
    }
    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
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

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getPublishing_house() {
        return publishing_house;
    }

    public void setPublishing_house(String publishing_house) {
        this.publishing_house = publishing_house;
    }

    public int getPublished_year() {
        return published_year;
    }

    public void setPublished_year(int published_year) {
        this.published_year = published_year;
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

    public String getPrice() {
        return df.format(price);
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Date getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Date create_at) {
        this.create_at = create_at;
    }

    public Date getUpdate_at() {
        return update_at;
    }

    public void setUpdate_at(Date update_at) {
        this.update_at = update_at;
    }
}
