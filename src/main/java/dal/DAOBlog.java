package dal;

import models.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.User;

public class DAOBlog {

    private Connection conn;

    // Constructor to initialize the database connection
    public DAOBlog(DBConnect dbConnect) throws SQLException {
        this.conn = dbConnect.getConnection();
    }

    // Method to get a list of posts with sorting and pagination
    public List<Post> getPosts(int pageIndex, int pageSize, String sortField, String sortOrder) throws SQLException {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname AS author_name FROM posts p JOIN users u ON p.user_id = u.user_id WHERE p.status = 'Show' ORDER BY p.created_at " + sortOrder + " LIMIT ? OFFSET ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, (pageIndex - 1) * pageSize);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setPostId(rs.getInt("post_id"));
                    post.setTitle(rs.getString("title"));
                    post.setDescription(rs.getString("description"));
                    post.setImage(rs.getString("image"));
                    post.setAuthorName(rs.getString("author_name"));
                    post.setCreatedAt(rs.getDate("created_at"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // Method to search posts with a query, sorting, and pagination
    public List<Post> searchPosts(String searchQuery, int pageIndex, int pageSize, String sortOrder) throws SQLException {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.fullname FROM posts p JOIN users u ON p.user_id = u.user_id WHERE p.title LIKE ? AND p.status = 'Show' ORDER BY p.created_at " + sortOrder + " LIMIT ? OFFSET ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + searchQuery + "%");          
            ps.setInt(2, pageSize);
            ps.setInt(3, (pageIndex - 1) * pageSize);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setPostId(rs.getInt("post_id"));
                    post.setTitle(rs.getString("title"));
                    post.setDescription(rs.getString("description"));
                    post.setImage(rs.getString("image"));
                    post.setAuthorName(rs.getString("fullname"));
                    post.setCreatedAt(rs.getDate("created_at"));
                    post.setPostType(rs.getString("post_type"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public int getTotalPostsByCategory(String category) throws SQLException {
        String sql = "SELECT COUNT(*) FROM posts WHERE post_type = ? AND status = 'Show'";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public Post getPostById(int postId) {
        Post post = null;
        String sql = "SELECT p.*, u.fullname AS author_name FROM posts p JOIN users u ON  p.user_id = u.user_id WHERE p.post_id = ? ORDER BY p.created_at";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    post = new Post();
                    post.setPostId(rs.getInt("post_id"));
                    post.setImage(rs.getString("image"));
                    post.setTitle(rs.getString("title"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setDescription(rs.getString("description"));
                    post.setPostType(rs.getString("post_type"));
                    post.setStatus(rs.getString("status"));
                    post.setCreatedAt(rs.getDate("created_at"));
                    post.setUpdateAt(rs.getDate("updated_at"));
                    post.setAuthorName(rs.getString("author_name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post;
    }

    // Method to get the total number of posts
    public int getTotalPosts() {
        int totalPosts = 0;
        String sql = "SELECT COUNT(*) FROM posts WHERE status = 'show'";
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalPosts = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPosts;
    }

    // Method to get all distinct post categories
    public List<String> getPostCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT post_type FROM posts";
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("post_type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Post> getPostsByCategory(String category, int pageIndex, int pageSize, String sortField, String sortOrder) throws SQLException {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT p.*, u.fullname FROM posts p JOIN users u ON p.user_id = u.user_id WHERE p.post_type LIKE ? AND p.status = 'Show' ORDER BY p.created_at " + sortOrder + " LIMIT ? OFFSET ?";
        try ( PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, category);
            ps.setInt(2, pageSize);
            ps.setInt(3, (pageIndex - 1) * pageSize);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setImage(rs.getString("image"));
                    post.setTitle(rs.getString("title"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setDescription(rs.getString("description"));
                    post.setPostType(rs.getString("post_type"));
                    post.setStatus(rs.getString("status"));
                    post.setCreatedAt(rs.getDate("created_at"));
                    post.setAuthorName(rs.getString("fullname"));
                    posts.add(post);
                }
            }
        }
        return posts;
    }

    public int getTotalPostsBySearch(String searchQuery) throws SQLException {
        String sql = "SELECT COUNT(*) FROM posts WHERE title LIKE ? AND status = 'Show'";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + searchQuery + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    
    // Method to get a post by its ID
    

    // Method to get a post by its ID
    public List<Post> getAllPosts(String sql) {
        List<Post> posts = new ArrayList<>();
        sql = "SELECT * FROM posts";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setImage(rs.getString("image"));
                post.setTitle(rs.getString("title"));
                post.setUserId(rs.getInt("user_id"));
                post.setDescription(rs.getString("description"));
                post.setPostType(rs.getString("post_type"));
                post.setStatus(rs.getString("status"));
                post.setCreatedAt(rs.getDate("created_at"));
                post.setUpdateAt(rs.getDate("updated_at"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }

    public void updateStatus(int postId, String newStatus) throws SQLException {
        String query = "UPDATE posts SET status = ?, updated_at = NOW() WHERE post_id = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, postId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Log and rethrow the exception for higher-level handling
            System.err.println("Error updating status: " + e.getMessage());
            throw e;
        }
    }

    public int insertPost(Post post) throws SQLException {
        // Adjusted SQL to include user_id
        String sql = "INSERT INTO posts (title, description, post_type, status, image, user_id) VALUES (?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getDescription());
            stmt.setString(3, post.getPostType());
            stmt.setString(4, post.getStatus());
            stmt.setString(5, post.getImage());
            // Use a hardcoded user_id for testing purposes
            stmt.setInt(6, post.getUserId());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating post failed, no rows affected.");
            }

            try ( ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating post failed, no ID obtained.");
                }
            }
        }
    }

    public void updatePost(Post post) throws SQLException {
        String query = "UPDATE posts SET title = ?, description = ?, post_type = ?, status = ?, image = ?, updated_at = NOW() WHERE post_id = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getDescription());
            stmt.setString(3, post.getPostType());
            stmt.setString(4, post.getStatus());
            stmt.setString(5, post.getImage());
            stmt.setInt(6, post.getPostId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Log and rethrow the exception for higher-level handling
            System.err.println("Error updating post: " + e.getMessage());
            throw e;
        }
    }

      public void deletePost(int postId) throws SQLException {
        String query = "DELETE FROM posts WHERE post_id = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            stmt.executeUpdate();
        }
    }

    public void toggleStatus(int postId) throws SQLException {
        String sql = "UPDATE posts SET status = CASE WHEN status = 'Show' THEN 'Hide' ELSE 'Show' END WHERE post_id = ?";
        try ( PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, postId);
            statement.executeUpdate();
        }
    }

    public boolean postIdExists(int postId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM posts WHERE post_id = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public int getNextPostId() throws SQLException {
        int nextPostId = 0;
        String sql = "SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'checksql' AND TABLE_NAME = 'posts'";

        try ( PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                nextPostId = rs.getInt("AUTO_INCREMENT");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Handle or rethrow exception as necessary
        }

        return nextPostId;
    }

    public boolean savePost(Post post) {
        boolean success = false;
        String sql = "INSERT INTO posts (post_id, image, title, user_id, description, post_type, status, created_at, updated_at, author_name) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, post.getPostId());
            stmt.setString(2, post.getImage());
            stmt.setString(3, post.getTitle());
            stmt.setInt(4, post.getUserId());
            stmt.setString(5, post.getDescription());
            stmt.setString(6, post.getPostType());
            stmt.setString(7, post.getStatus());
            stmt.setDate(8, post.getCreatedAt());
            stmt.setDate(9, post.getUpdateAt());
            stmt.setString(10, post.getAuthorName());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    public User authenticateUser(String username, String password) throws SQLException {
        User user = null;
        String query = "SELECT id, username, password FROM users WHERE username = ? AND password = ?";
        try ( PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setFullname(resultSet.getString("fullname"));
                user.setPassword(resultSet.getString("password"));
            }
        }
        return user;
    }

    public List<Post> getVisiblePosts() throws SQLException {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE status = 'Show'";
        try (
                 PreparedStatement statement = conn.prepareStatement(sql);  ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setDescription(rs.getString("description"));
                post.setPostType(rs.getString("post_type"));
                post.setStatus(rs.getString("status"));
                post.setImage(rs.getString("image"));
                post.setUserId(rs.getInt("user_id"));
                post.setCreatedAt(rs.getDate("created_at"));
                post.setUpdateAt(rs.getDate("updated_at"));
                posts.add(post);
            }
        }
        return posts;
    }

    public List<Post> searchAndSortPosts(String title, String category, String status, String sortOrder) throws SQLException {
        List<Post> posts = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT p.*, u.fullname as authorName FROM posts p JOIN users u ON p.user_id = u.user_id WHERE 1=1");

        if (title != null && !title.isEmpty()) {
            query.append(" AND LOWER(p.title) LIKE ?");
        }
        if (category != null && !category.isEmpty()) {
            query.append(" AND p.post_type = ?");
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND p.status = ?");
        }

        // Sắp xếp theo post_id
        //query.append(" ORDER BY p.post_id ").append(sortOrder);
        try ( PreparedStatement preparedStatement = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;

            if (title != null && !title.isEmpty()) {
                preparedStatement.setString(paramIndex++, "%" + title.toLowerCase() + "%");
            }
            if (category != null && !category.isEmpty()) {
                preparedStatement.setString(paramIndex++, category);
            }
            if (status != null && !status.isEmpty()) {
                preparedStatement.setString(paramIndex++, status);
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Post post = new Post();
                post.setPostId(resultSet.getInt("post_id"));
                post.setImage(resultSet.getString("image"));
                post.setTitle(resultSet.getString("title"));
                post.setUserId(resultSet.getInt("user_id"));
                post.setPostType(resultSet.getString("post_type"));
                post.setStatus(resultSet.getString("status"));
                post.setCreatedAt(resultSet.getDate("created_at"));
                post.setUpdateAt(resultSet.getDate("updated_at"));
                post.setAuthorName(resultSet.getString("authorName"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

        return posts;
    }

}