/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOShipInfor;
import dal.DAOUsers;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Map;
import models.Book;
import models.CartItems;
import models.ShippingInformations;
import models.User;

/**
 *
 * @author TDG
 */
public class CartContact extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);

        DAOShipInfor daoShipInfor = new DAOShipInfor();
//        DAOUsers daoUsers = new DAOUsers();

        User user = (User) session.getAttribute("user");
        session.setAttribute("user", user);
        if (user == null) {
            response.sendRedirect("login");
        } else {

//            int userId = 1;
//            User user = daoUsers.getAll("Select * from users where user_id = "+userId).get(0);
//            session.setAttribute("user", user);
            Map<CartItems, Book> cartItemBookMap = (Map<CartItems, Book>) session.getAttribute("cartItemBookMap");

            if (cartItemBookMap == null || cartItemBookMap.isEmpty()) {
                // If cartItemBookMap is null, redirect to the cartdetails page to ensure it's set
                response.sendRedirect("cartdetails");
                return;
            }

            //
            ArrayList<ShippingInformations> listShipInfor = new ArrayList<>();

            String service = request.getParameter("service");
            if (service == null) {
                service = "listAll";
            }
            if (service.equals("listAll")) {
                listShipInfor = daoShipInfor.getAll("select * from shipping_info where action = 1 and user_id =" + user.getUserId());
                session.setAttribute("listShipInfor", listShipInfor);
            }

            if (service.equals("delete")) {
                String stringShipId = request.getParameter("shipId");
                if (stringShipId != null) {
                    try {
                        int shipId = Integer.parseInt(stringShipId);
                        ShippingInformations ship = daoShipInfor.getAll("Select * from shipping_info where shipping_id = " + shipId + ";").get(0);
                        ship.setAction(0);
                        daoShipInfor.updateBook(ship);
                        listShipInfor = (ArrayList<ShippingInformations>) session.getAttribute("listShipInfor");
                        listShipInfor.remove(shipId);
                        session.setAttribute("listShipInfor", listShipInfor);
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                }
            }
            PrintWriter out = response.getWriter();
            if (service.equals("update")) {
                String stringShipId = request.getParameter("shipId");
                if (stringShipId != null) {
                    int shipId = Integer.parseInt(stringShipId.trim());
                    //
                    String newAddress = request.getParameter("newAddress");
                    if (newAddress != null) {
                        ShippingInformations ship = daoShipInfor.getAll("Select * from shipping_info where shipping_id = " + shipId + ";").get(0);
                        ArrayList<ShippingInformations> addressExit = daoShipInfor.getAll("Select * from shipping_info where shipping_id != " + shipId + " and address = '" + newAddress + "'and action = 1;");
                        for (ShippingInformations shippingInformations : addressExit) {
                            return;
                        }
                        if(user.getAddress().equals(newAddress)){
                            return;
                        }
                        ship.setAddress(newAddress);
                        daoShipInfor.updateBook(ship);
                        listShipInfor = (ArrayList<ShippingInformations>) session.getAttribute("listShipInfor");
                        for (ShippingInformations shippingInformations : listShipInfor) {
                            if (shippingInformations.getShippingId() == ship.getShippingId()) {
                                shippingInformations.setAddress(newAddress);
                            }
                        }
                        session.setAttribute("listShipInfor", listShipInfor);
                    }
                    
                    //
                    String newPhone = request.getParameter("newPhone");
                    if (newPhone != null) {
                        ShippingInformations ship1 = daoShipInfor.getAll("Select * from shipping_info where shipping_id = " + shipId + ";").get(0);
                        out.println("before : " + ship1);
                        ArrayList<ShippingInformations> phoneExit = daoShipInfor.getAll("Select * from shipping_info where shipping_id != " + shipId + " and phone = '" + newPhone + "'and action = 1;");
                        for (ShippingInformations shippingInformations : phoneExit) {
                            out.println(shippingInformations);
                            return;
                        }
                        if(user.getPhone().equals(newPhone)){
                            return;
                        }
                        ship1.setPhone(newPhone);
                        out.println("after : " + ship1);
                        int n = daoShipInfor.updateBook(ship1);
                        out.println(n);
                        return;
                    }
                }

            }

            if (service.equals("add")) {
                String address = request.getParameter("address");
                if (address != null) {
                    try {
                        ArrayList<ShippingInformations> addressExit = daoShipInfor.getAll("Select * from shipping_info where address = '" + address + "'and action = 1;");
                        for (ShippingInformations shippingInformations : addressExit) {
                            return;
                        }
                        if(user.getAddress().equals(address)){
                            return;
                        }
                        ShippingInformations newInfor = new ShippingInformations();
                        newInfor.setUserId(user.getUserId());
                        newInfor.setAddress(address);
                        daoShipInfor.insert(newInfor);
                        return;
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                }
                String phone = request.getParameter("phone");
                if (phone != null) {
                    try {
                        ArrayList<ShippingInformations> addressExit = daoShipInfor.getAll("Select * from shipping_info where phone = '" + phone + "'and action = 1;");
                        for (ShippingInformations shippingInformations : addressExit) {
                            return;
                        }
                        if(user.getPhone().equals(phone)){
                            return;
                        }
                        ShippingInformations newInfor = new ShippingInformations();
                        newInfor.setUserId(user.getUserId());
                        newInfor.setPhone(phone);
                        daoShipInfor.insert(newInfor);
                        return;
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                }
            }

            RequestDispatcher dispth = request.getRequestDispatcher("./views/cartcontact.jsp");
            dispth.forward(request, response);

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
