/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author kobietkolam
 */
import dal.DAOBlog;
import dal.DBConnect;
import java.sql.SQLException;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        DBConnect dbConnect = new DBConnect();
        DAOBlog daoBlog = null;
        try {
            daoBlog = new DAOBlog(dbConnect);

            // Test getPostsByCategory
            String category = "hot_spot";
            int currentPage = 1;
            int pageSize = 5;
            String sortOrder = "desc";

            System.out.println("Fetching posts for category: " + category);
            List<Post> posts = daoBlog.getPostsByCategory(category, currentPage, pageSize, sortOrder);
            if (posts != null && !posts.isEmpty()) {
                for (Post post : posts) {
                    System.out.println(post);
                }
            } else {
                System.out.println("No posts found for category: " + category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
