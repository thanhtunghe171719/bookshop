/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dal.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import models.*;

public class CartDetails extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        
        DAOCart daoCart = new DAOCart();
        DAOBooks daoBook = new DAOBooks();
        DAOCartDetails daoCartDetails = new DAOCartDetails();
        
        
        User user = (User) session.getAttribute("user");
        session.setAttribute("user", user);
        if(user==null){
            response.sendRedirect("login");
        }else{
            int userId = user.getUserId();

//            int userId = 1;

            int cartId = daoCart.getCartId(userId);

            String service = request.getParameter("service");
            
            
            Map<CartItems, Book> cartItemBookMap = new HashMap<>();
            
            if(service == null){
                service = "listAll";
            }
           if(service.equals("addCart")){
                ArrayList<CartItems> listItems = daoCartDetails.getAll("SELECT * FROM cart_items WHERE cart_id = " + cartId);
                String stringBookId = request.getParameter("bookId");
                String test="";
                if(stringBookId!=null && !stringBookId.isEmpty()){
                    int bookId = Integer.parseInt(stringBookId);
                    if(listItems != null) {
                        boolean check = true;
                       for (CartItems listItem : listItems) {
                           if(listItem.getBookId() == bookId){
                               int quantity = listItem.getQuantity();
                               listItem.setQuantity(quantity + 1);
                               daoCartDetails.updateQuantity(listItem.getCartItemId(), listItem.getQuantity());
                               test = "có book và tăng quantity";
                               check = false; 
                               break;
                           }
                       }
                       if(check){
                           CartItems cartItems = new CartItems();
                           cartItems.setCartId(cartId);
                           cartItems.setBookId(bookId);
                           cartItems.setQuantity(1);
                           daoCartDetails.insert(cartItems);
                           test = "có cart nhưng không có book";
                       }
                    }else{
                        CartItems cartItems = new CartItems();
                        cartItems.setCartId(cartId);
                        cartItems.setBookId(bookId);
                        cartItems.setQuantity(1);
                        daoCartDetails.insert(cartItems);
                        test = "chưa từng có cart";
                    }
                }else{
                    test = "không có stringBookId ";
                }
                session.setAttribute("test", test);
                response.sendRedirect("cartdetails");
                return;
            }
            
            if(service.equals("listAll")){
                if(cartId != 0){
                    ArrayList<CartItems> listItems = daoCartDetails.getAll("SELECT * FROM cart_items WHERE cart_id = " + cartId);
                    if(listItems != null) {
                        for (CartItems listItem : listItems) {

                            ArrayList<Book> bookItem = daoBook.getAll("SELECT * FROM books WHERE book_id = " + listItem.getBookId());
                            if (bookItem != null && !bookItem.isEmpty()) {
                                cartItemBookMap.put(listItem, bookItem.get(0)); 
                            }
                        }
                    }
                    session.setAttribute("cartItemBookMap", cartItemBookMap);
                }
            }


    //        PrintWriter out = response.getWriter();
            if(service.equals("updateQuantity")){
                String stringCartItemId = request.getParameter("cartItemId");
                String stringQuantity = request.getParameter("quantity");

                if(stringCartItemId != null && stringQuantity != null){
                    int cartItemId = Integer.parseInt(stringCartItemId);
                    int quantity = Integer.parseInt(stringQuantity);

                    boolean checkUpdate = daoCartDetails.updateQuantity(cartItemId, quantity);

                    cartItemBookMap = (Map<CartItems, Book>) session.getAttribute("cartItemBookMap");

                    if(checkUpdate){
                        for (Map.Entry<CartItems, Book> entry : cartItemBookMap.entrySet()) {
                            CartItems key = entry.getKey();
                            if(key.getCartItemId() == cartItemId){
                                key.setQuantity(quantity);
                            }
                        }
                    }
                    session.setAttribute("cartItemBookMap", cartItemBookMap);

                }
            }
            
            if(service.equals("delete")){
                String stringCartItemId = request.getParameter("cartItemId");
                if(stringCartItemId != null){
                    int cartItemId = Integer.parseInt(stringCartItemId);
                    int checkDelete = daoCartDetails.delete(cartItemId);

                    cartItemBookMap = (Map<CartItems, Book>) session.getAttribute("cartItemBookMap");

                    if(checkDelete != 0){
                        cartItemBookMap.entrySet().removeIf(entry -> entry.getKey().getCartItemId() == cartItemId);
                    }
                    session.setAttribute("cartItemBookMap", cartItemBookMap);
                }
            }

            RequestDispatcher dispth = request.getRequestDispatcher("./views/cartdetails.jsp");
            dispth.forward(request, response);
            
        }        
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
