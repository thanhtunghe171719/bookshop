/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import models.Slider;
import models.Book;
import models.Categorie;
import models.Posts;
import dal.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import models.User;

/**
 *
 * @author TDG
 */
public class HomePage extends HttpServlet {

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

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // User chưa đăng nhập
            session.setAttribute("user", null);
        } else {
            // User đã đăng nhập
            session.setAttribute("user", user);
        }

        DAOSlider daoSlider = new DAOSlider();
        DAOCategories daoCategories = new DAOCategories();
        DAOBooks daoBooks = new DAOBooks();
        DAOPosts daoPosts = new DAOPosts();
        DAOOrderItems daoOrderItems = new DAOOrderItems();

        ArrayList<Slider> listSlider = daoSlider.getAll("SELECT * FROM slider WHERE status = 'show' ORDER BY slider_id DESC LIMIT 3;");
        request.setAttribute("listSlider", listSlider);

        ArrayList<Categorie> listCategory = daoCategories.getAll("SELECT * FROM categories;");
        request.setAttribute("listCategory", listCategory);

        ArrayList<Posts> listPost = daoPosts.getAll("SELECT * FROM posts WHERE status = 'Show' ORDER BY created_at DESC LIMIT 3;");
        request.setAttribute("listPost", listPost);

        ArrayList<Book> listBook = new ArrayList<>();;
        String service = (String) request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }
        if (service.equals("listAll")) {
            String currentOption = "Giảm Giá Mạnh";
            String selectedOption = (String) request.getParameter("selectedOption");
            if (selectedOption != null) {
                // sách Giảm Giá Mạnh"
                if (selectedOption.equals("discount")) {
                    listBook = daoBooks.getAll("SELECT * FROM books WHERE discount > 0 AND stock > 0 ORDER BY discount DESC LIMIT 8;");
                    currentOption = "Giảm Giá Mạnh";
                    //    Sản Phẩm Bán Chạy
                } else if (selectedOption.equals("sold")) {
                    List<Integer> listBookId = daoOrderItems.getBookId("SELECT oi.book_id FROM order_items oi  GROUP BY oi.book_id  ORDER BY SUM(oi.quantity) DESC limit 8;");
                    for (int i = 0; i < listBookId.size(); i++) {
                        Book bookItem = daoBooks.getBookById("SELECT * FROM books WHERE stock > 0 and book_id = " + listBookId.get(i));
                        if (bookItem != null) {
                            listBook.add(bookItem);  // Now listBook is initialized, so this will work fine
                        }
                    }
                    currentOption = "Sản Phẩm Bán Chạy";
                    //  Sản Phẩm Mới  
                } else if (selectedOption.equals("new-product")) {
                    listBook = daoBooks.getAll("SELECT * FROM books WHERE stock > 0 ORDER BY book_id DESC LIMIT 8;");
                    currentOption = "Sản Phẩm Mới";
                }

            } else {
                listBook = daoBooks.getAll("SELECT * FROM books WHERE discount > 0 AND stock > 0 ORDER BY discount DESC LIMIT 8;");
            }

            request.setAttribute("listBook", listBook);
            request.setAttribute("currentOption", currentOption);

        }

        //select(jsp)   
        RequestDispatcher dispth = request.getRequestDispatcher("./views/homepage.jsp");
        //run(view)
        dispth.forward(request, response);
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
