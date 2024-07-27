/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dal.DAOSlider;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import models.Slider;

/**
 *
 * @author TDG
 */
public class slider extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        DAOSlider daoSlider = new DAOSlider();
        
        String id = request.getParameter("id");
        int sliderID = (id!=null)? Integer.parseInt(id) : -1;
        
        String service = request.getParameter("service");
        
        ArrayList<Slider> listSlider = daoSlider.getAll("SELECT * FROM slider where status = 'Show' ORDER BY slider_id DESC limit 5;");
        request.setAttribute("listSlider", listSlider);
            
        if(service == null){
            service="listAll";
        }
        if(service.equals("listAll")){
            ArrayList<Slider> detailSlider = daoSlider.getAll("SELECT * FROM slider where status = 'Show' ORDER BY slider_id DESC;");
            request.setAttribute("detailSlider", detailSlider);
        }
        if(service.equals("backlink")){
            ArrayList<Slider> detailSlider = daoSlider.getAll("SELECT * FROM slider where status = 'Show' and slider_id = "+sliderID+" ORDER BY slider_id DESC;");
            request.setAttribute("detailSlider", detailSlider);
        }
        if(service.equals("search")){
            String title = request.getParameter("title");
            if(title != null){
                request.setAttribute("title", title);
                listSlider = daoSlider.getAll("SELECT * FROM slider where status = 'Show' and title like '%"+title+"%' ORDER BY slider_id DESC limit 5;");
                request.setAttribute("listSlider", listSlider);

                ArrayList<Slider> detailSlider = daoSlider.getAll("SELECT * FROM slider where status = 'Show' and title like '%"+title+"%' limit 1;");
                request.setAttribute("detailSlider", detailSlider);
            }
        }
        //select(jsp)   
        RequestDispatcher dispth = request.getRequestDispatcher("./views/slider.jsp");
        //run(view)
        dispth.forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
