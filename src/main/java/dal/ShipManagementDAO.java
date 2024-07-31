/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import models.ShipManagement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShipManagementDAO extends DBConnect {

    private static final String INSERT_SHIP_SQL = "INSERT INTO ship_management (order_id, user_id, created_at, updated_at) VALUES (?, ?, ?, ?)";
    private static final String SELECT_SHIP_BY_ID = "SELECT ship_id, order_id, user_id, created_at, updated_at FROM ship_management WHERE ship_id = ?";
    private static final String SELECT_ALL_SHIPS = "SELECT * FROM ship_management";
    private static final String DELETE_SHIP_SQL = "DELETE FROM ship_management WHERE ship_id = ?";
    private static final String UPDATE_SHIP_SQL = "UPDATE ship_management SET order_id = ?, user_id = ?, created_at = ?, updated_at = ? WHERE ship_id = ?";

    public void insertShip(ShipManagement ship) throws SQLException {
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SHIP_SQL)) {
            preparedStatement.setInt(1, ship.getOrderId());
            preparedStatement.setInt(2, ship.getUserId());
            preparedStatement.setTimestamp(3, ship.getCreatedAt());
            preparedStatement.setTimestamp(4, ship.getUpdatedAt());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error: " + e);
        }
    }

    public ShipManagement selectShip(int shipId) {
        ShipManagement ship = null;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_SHIP_BY_ID)) {
            preparedStatement.setInt(1, shipId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                ship = new ShipManagement(shipId, orderId, userId, createdAt, updatedAt);
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e);
        }
        return ship;
    }

    public List<ShipManagement> selectAllShips() {
        List<ShipManagement> ships = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_SHIPS)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int shipId = rs.getInt("ship_id");
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                ships.add(new ShipManagement(shipId, orderId, userId, createdAt, updatedAt));
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e);
        }
        return ships;
    }

    public boolean deleteShip(int shipId) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(DELETE_SHIP_SQL)) {
            preparedStatement.setInt(1, shipId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateShip(ShipManagement ship) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SHIP_SQL)) {
            preparedStatement.setInt(1, ship.getOrderId());
            preparedStatement.setInt(2, ship.getUserId());
            preparedStatement.setTimestamp(3, ship.getCreatedAt());
            preparedStatement.setTimestamp(4, ship.getUpdatedAt());
            preparedStatement.setInt(5, ship.getShipId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    public void updateOrInsertShipForOrder(int orderId, int userId) {
        String checkSql = "SELECT COUNT(*) FROM ship_management WHERE order_id = ?";
        String insertSql = "INSERT INTO ship_management (order_id, user_id, created_at, updated_at) VALUES (?, ?, NOW(), NOW())";
        String updateSql = "UPDATE ship_management SET user_id = ?, updated_at = NOW() WHERE order_id = ?";

        try {
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, orderId);
            ResultSet rs = checkPs.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setInt(1, userId);
                updatePs.setInt(2, orderId);
                updatePs.executeUpdate();
            } else {
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setInt(1, orderId);
                insertPs.setInt(2, userId);
                insertPs.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
    }
}
