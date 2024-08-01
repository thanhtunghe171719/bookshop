/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import config.Config;
import dal.DAOCart;
import dal.DAOCartCompletion;
import dal.DAOCartDetails;
import dal.DAOUsers;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import models.CartItems;
import models.User;

/**
 *
 * @author CTT VNPAY
 */
public class PaymentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession(true);

        DAOUsers daoUsers = new DAOUsers();
        DAOCart daoCart = new DAOCart();
        DAOCartCompletion cartCompletion = new DAOCartCompletion();
        DAOCartDetails daoCartDetails = new DAOCartDetails();

        String amount = req.getParameter("subTotal");
        String paymentMethod = req.getParameter("paymentMethod"); // Lấy giá trị của phương thức thanh toán
        String address = req.getParameter("address"); // Get the address value from the form
        String phone = req.getParameter("phone"); // Get the address value from the form

        User user = (User) session.getAttribute("user");
        session.setAttribute("user", user);
        if (user == null) {
            resp.sendRedirect("login");
        } else {
            int userId = user.getUserId();

//            int userId = 1;
//            User user = daoUsers.getAll("Select * from users where user_id = " + userId).get(0);
//            session.setAttribute("user", user);
            int cartId = daoCart.getCartId(userId);

            // Kiểm tra xem người dùng đã chọn phương thức thanh toán hay chưa
            if (paymentMethod == null || paymentMethod.isEmpty()) {
                // Nếu chưa chọn, hiển thị thông báo lỗi và không điều hướng
                req.setAttribute("errorMessage", "Please select a payment method.");
                req.getRequestDispatcher("views/cartcontact.jsp").forward(req, resp);
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
                if ("International card".equals(paymentMethod)) {
                    // Xử lý thanh toán trực tiếp

                    String vnp_Version = "2.1.0";
                    String vnp_Command = "pay";
                    String orderType = "other";
                    String total = req.getParameter("subTotal");

                    double subtotal = Double.parseDouble(total);

                    long totalAmount = (long) (subtotal * 100000);
                    String bankCode = "INTCARD";

                    String vnp_TxnRef = Integer.toString(newOrderID);
                    String vnp_IpAddr = Config.getIpAddress(req);

                    String vnp_TmnCode = Config.vnp_TmnCode;

                    Map<String, String> vnp_Params = new HashMap<>();
                    vnp_Params.put("vnp_Version", vnp_Version);
                    vnp_Params.put("vnp_Command", vnp_Command);
                    vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                    vnp_Params.put("vnp_Amount", String.valueOf(totalAmount));
                    vnp_Params.put("vnp_CurrCode", "VND");
                    vnp_Params.put("vnp_BankCode", bankCode);
                    vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                    vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
                    vnp_Params.put("vnp_OrderType", orderType);
                    vnp_Params.put("vnp_Locale", "vn");
                    vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
                    vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                    Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                    String vnp_CreateDate = formatter.format(cld.getTime());
                    vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                    cld.add(Calendar.MINUTE, 15);
                    String vnp_ExpireDate = formatter.format(cld.getTime());
                    vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

                    List fieldNames = new ArrayList(vnp_Params.keySet());
                    Collections.sort(fieldNames);
                    StringBuilder hashData = new StringBuilder();
                    StringBuilder query = new StringBuilder();
                    Iterator itr = fieldNames.iterator();
                    while (itr.hasNext()) {
                        String fieldName = (String) itr.next();
                        String fieldValue = (String) vnp_Params.get(fieldName);
                        if ((fieldValue != null) && (fieldValue.length() > 0)) {
                            //Build hash data
                            hashData.append(fieldName);
                            hashData.append('=');
                            hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                            //Build query
                            query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                            query.append('=');
                            query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                            if (itr.hasNext()) {
                                query.append('&');
                                hashData.append('&');
                            }
                        }
                    }
                    String queryUrl = query.toString();
                    String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
                    queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                    String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

                    resp.sendRedirect(paymentUrl);
                } else if ("Pay with Banking App".equals(paymentMethod)) {
                    // Xử lý thanh toán qua ứng dụng ngân hàng

                    String vnp_Version = "2.1.0";
                    String vnp_Command = "pay";
                    String orderType = "other";
                    String total = req.getParameter("subTotal");

                    double subtotal = Double.parseDouble(total);

                    long totalAmount = (long) (subtotal * 100000);
                    String bankCode = "VNBANK";

                    String vnp_TxnRef = Integer.toString(newOrderID);
                    String vnp_IpAddr = Config.getIpAddress(req);

                    String vnp_TmnCode = Config.vnp_TmnCode;

                    Map<String, String> vnp_Params = new HashMap<>();
                    vnp_Params.put("vnp_Version", vnp_Version);
                    vnp_Params.put("vnp_Command", vnp_Command);
                    vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                    vnp_Params.put("vnp_Amount", String.valueOf(totalAmount));
                    vnp_Params.put("vnp_CurrCode", "VND");
                    vnp_Params.put("vnp_BankCode", bankCode);
                    vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                    vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
                    vnp_Params.put("vnp_OrderType", orderType);
                    vnp_Params.put("vnp_Locale", "vn");
                    vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
                    vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                    Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                    String vnp_CreateDate = formatter.format(cld.getTime());
                    vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                    cld.add(Calendar.MINUTE, 15);
                    String vnp_ExpireDate = formatter.format(cld.getTime());
                    vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

                    List fieldNames = new ArrayList(vnp_Params.keySet());
                    Collections.sort(fieldNames);
                    StringBuilder hashData = new StringBuilder();
                    StringBuilder query = new StringBuilder();
                    Iterator itr = fieldNames.iterator();
                    while (itr.hasNext()) {
                        String fieldName = (String) itr.next();
                        String fieldValue = (String) vnp_Params.get(fieldName);
                        if ((fieldValue != null) && (fieldValue.length() > 0)) {
                            //Build hash data
                            hashData.append(fieldName);
                            hashData.append('=');
                            hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                            //Build query
                            query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                            query.append('=');
                            query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                            if (itr.hasNext()) {
                                query.append('&');
                                hashData.append('&');
                            }
                        }
                    }
                    String queryUrl = query.toString();
                    String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
                    queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                    String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

                    resp.sendRedirect(paymentUrl);
                }
            }

        }
    }
}
