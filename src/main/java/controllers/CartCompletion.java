/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.DAOCart;
import dal.DAOCartCompletion;
import dal.DAOCartDetails;
import dal.DAOUsers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import models.CartItems;
import models.User;

/**
 *
 * @author skyfc
 */
@WebServlet(name = "CartCompletion", urlPatterns = {"/cart"})
public class CartCompletion extends HttpServlet {

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

        DAOUsers daoUsers = new DAOUsers();
        DAOCart daoCart = new DAOCart();
        DAOCartCompletion cartCompletion = new DAOCartCompletion();
        DAOCartDetails daoCartDetails = new DAOCartDetails();

        String amount = request.getParameter("subTotal");
        String paymentMethod = request.getParameter("paymentMethod"); // Lấy giá trị của phương thức thanh toán
        String address = request.getParameter("address"); // Get the address value from the form
        String phone = request.getParameter("phone"); // Get the address value from the form

        User user = (User) session.getAttribute("user");
        session.setAttribute("user", user);
        if (user == null) {
            response.sendRedirect("login");
        } else {
            int userId = user.getUserId();

//            int userId = 1;
//            User user = daoUsers.getAll("Select * from users where user_id = " + userId).get(0);
//            session.setAttribute("user", user);
            int cartId = daoCart.getCartId(userId);

            // Kiểm tra xem người dùng đã chọn phương thức thanh toán hay chưa
            if (paymentMethod == null || paymentMethod.isEmpty()) {
                // Nếu chưa chọn, hiển thị thông báo lỗi và không điều hướng
                request.setAttribute("errorMessage", "Please select a payment method.");
                request.getRequestDispatcher("views/cartcontact.jsp").forward(request, response);
                return;
            }

            // Tạo đơn hàng mới và lấy order_id
            int newOrderID = cartCompletion.newOrder(cartId, Double.parseDouble(amount), 1, address, phone);
            if (newOrderID != -1) {
                cartCompletion.addOrderItems(newOrderID); // Gọi phương thức với order_id cụ thể
                cartCompletion.removeOrderedBooks(newOrderID); // Gọi phương thức với order_id cụ thể

                ArrayList<CartItems> listItems = daoCartDetails.getAll("SELECT * FROM cart_items WHERE cart_id = " + cartId);

                for (CartItems listItem : listItems) {
                    daoCartDetails.delete(listItem.getCartItemId());
                }

                // Xử lý phương thức thanh toán
                if ("Direct Payment".equals(paymentMethod)) {
                    // Xử lý thanh toán trực tiếp
                    request.getRequestDispatcher("views/homepage.jsp").forward(request, response);
                } else if ("Pay with Banking App".equals(paymentMethod)) {
                    // Xử lý thanh toán qua ứng dụng ngân hàng
                    request.setAttribute("amount", amount);

                    request.getRequestDispatcher("views/thankyou.jsp").forward(request, response);
                }
            }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
