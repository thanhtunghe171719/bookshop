/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    Connection conn=null;
    public DBConnect(String url,String userName,String password){
        try {
            //drive
            Class.forName("com.mysql.cj.jdbc.Driver");
            //connection
            conn=DriverManager.getConnection(url,userName, password);
            System.out.println("connected");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }        
    }
    public Connection getConnection() {
        return conn;
    }
    public DBConnect(){
        this("jdbc:mysql://localhost:3306/bookshop","root","123456");
    }
    public static void main(String[] args){
        new DBConnect();
    }
}
