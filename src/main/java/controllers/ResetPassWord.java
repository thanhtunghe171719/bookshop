/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dal.DAOUsers;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;
import models.MailConfig;
import models.User;

public class ResetPassWord extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        HttpSession sessionS = request.getSession();
        
        DAOUsers daoUsers = new DAOUsers();
        String service = request.getParameter("service");
        String indexScreen = (String) sessionS.getAttribute("indexScreen");
        
        if (service == null) {
            service = "listAll";
        }
        
        if (service.equals("listAll")) {            
            indexScreen = "first";
        }
        
        if (service.equals("sendEmail")) {
            String emailReset = request.getParameter("emailReset");
            sessionS.setAttribute("emailReset", emailReset);
            ArrayList<User> listUser = new ArrayList<>();
            if (emailReset != null && !emailReset.isEmpty()) {
                listUser = daoUsers.getAll("SELECT * FROM users where email = '"+emailReset+"'");
            }
            if (listUser != null && !listUser.isEmpty()) {
                String subject = "Mã OTP để thay đổi mật khẩu";

                String Capital_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                String Small_chars = "abcdefghijklmnopqrstuvwxyz";
                String numbers = "0123456789";
                String symbols = "!@";

                String values = Capital_chars + Small_chars + numbers + symbols;

                Random rndm_method = new Random();
                StringBuilder otp = new StringBuilder();
                otp.append(Capital_chars.charAt(rndm_method.nextInt(values.length())));
                for (int i = 0; i < 7; i++) {
                    otp.append(values.charAt(rndm_method.nextInt(values.length())));
                }
                
                sessionS.setAttribute("otp", otp.toString());
                String messageContent = "Mã OTP của bạn là: " + otp;

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.host", MailConfig.HOST_NAME);
                props.put("mail.smtp.socketFactory.port", MailConfig.SSL_PORT);
                props.put("mail.smtp.socketFactory.class", "jakarta.net.ssl.SSLSocketFactory");
                props.put("mail.smtp.port", MailConfig.SSL_PORT);
                props.put("mail.smtp.ssl.enable", "true");

                Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(MailConfig.APP_EMAIL, MailConfig.APP_PASSWORD);
                    }
                });

                try {
                    MimeMessage message = new MimeMessage(session);
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailReset));
                    message.setSubject(subject, "UTF-8");
                    message.setText(messageContent, "UTF-8");
                    Transport.send(message);
                    System.out.println("Message sent successfully");
                } catch (MessagingException e) {
                    e.printStackTrace();
                    throw new RuntimeException(e);
                }   
                indexScreen = "second";
            } else {
                String messageErrorEmail = "Email không tồn tại";
                out.print(messageErrorEmail);
                request.setAttribute("messageErrorEmail", messageErrorEmail);
            }
        }
        
        if (service.equals("checkOtp")) {
            String otpInput = request.getParameter("otpInput");
            String otp = (String) sessionS.getAttribute("otp");
            if (otp.equals(otpInput)) {
                indexScreen = "three";
            } else {
                indexScreen = "second";
                String messageEnrrorOtp = "OTP không chính xác";
                request.setAttribute("messageEnrrorOtp", messageEnrrorOtp);
            }
            sessionS.setAttribute("otp", otp);
        }
        
        if(service.equals("updatePassWord")){
            String messageUpdate;
            String newPassWord = (String) request.getParameter("newPassword");
            if(newPassWord!=null && !newPassWord.isEmpty()){
                String emailReset = (String)sessionS.getAttribute("emailReset");
                if(emailReset!=null && !emailReset.isEmpty()){
                    ArrayList<User> listUser = daoUsers.getAll("SELECT * FROM users where email = '"+emailReset+"'");
                    if(listUser!=null){
                        User user = listUser.get(0);
                        String encryptNew = daoUsers.Sha256(newPassWord);
                        user.setPassword(encryptNew);
                        daoUsers.update(user);
                        indexScreen = "";
                        messageUpdate = "Đổi mật khẩu thành công";
                    }else{
                        indexScreen = "";
                        messageUpdate = "Đổi mật khẩu không thành công";
                    }
                }else{
                    messageUpdate = "emailReset không thành công";
                }
            }else{
                messageUpdate = "newPassWord không thành công";
            }
            request.setAttribute("messageUpdate", messageUpdate);
        }

        sessionS.setAttribute("indexScreen", indexScreen);
        RequestDispatcher dispth = request.getRequestDispatcher("./views/resetpassword.jsp");
        dispth.forward(request, response);
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
