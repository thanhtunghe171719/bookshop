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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import models.Slider;
import models.User;

/**
 *
 * @author TDG
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class MarketingSlider extends HttpServlet {

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

        DAOSlider daoSlider = new DAOSlider();

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }
        if (service.equals("listAll")) {
            String title = request.getParameter("title");
            String status = request.getParameter("status");

            ArrayList<Slider> listAllSlider;
            ArrayList<Slider> listSlider;

            int pageSize = 4;
            String stringPage = request.getParameter("page");
            int page = 1;
            if (stringPage != null) {
                page = Integer.parseInt(stringPage);
            }
            int offset = (page - 1) * pageSize;

            if ((title == null || title.isEmpty()) && (status == null || status.isEmpty())) {
                listAllSlider = daoSlider.getAll("SELECT * FROM slider");
                listSlider = daoSlider.getAll("SELECT * FROM slider ORDER BY slider_id DESC LIMIT " + offset + "," + pageSize);
            } else {
                if (status == null || status.isEmpty()) {
                    listAllSlider = daoSlider.getAll("SELECT * FROM slider where title like '%" + title + "%';");
                    listSlider = daoSlider.getAll("SELECT * FROM slider where title like '%" + title + "%' ORDER BY slider_id DESC LIMIT " + offset + "," + pageSize);
                } else {
                    listAllSlider = daoSlider.getAll("SELECT * FROM slider where title like '%" + title + "%' and status like '" + status + "' ;");
                    listSlider = daoSlider.getAll("SELECT * FROM slider where title like '%" + title + "%' and status like '" + status + "' ORDER BY slider_id DESC LIMIT " + offset + "," + pageSize);
                }
            }

            session.setAttribute("title", title);
            session.setAttribute("status", status);
            session.setAttribute("pageSize", pageSize);
            session.setAttribute("page", page);
            session.setAttribute("listSlider", listSlider);

            int totalPage = 1;
            if (listAllSlider.size() % pageSize == 0) {
                totalPage = listAllSlider.size() / pageSize;
            } else {
                totalPage = (listAllSlider.size() / pageSize) + 1;
            }

            session.setAttribute("totalPage", totalPage);
        }
//        if (service.equals("searchTitle")) {
//            String title = request.getParameter("title");
//            String status = request.getParameter("status");
//            ArrayList<Slider> listSlider;
//            if ((title == null || title.isEmpty()) && (status == null || status.isEmpty())) {
//                listSlider = daoSlider.getAll("SELECT * FROM slider");
//            } else {
//                if (status == null || status.isEmpty()) {
//                    listSlider = daoSlider.getAll("SELECT * FROM slider where title like '%" + title + "%';");
//                } else {
//                    listSlider = daoSlider.getAll("SELECT * FROM slider where title like '%" + title + "%' and status like '" + status + "' ;");
//                }
//            }
//            request.setAttribute("title", title);
//            request.setAttribute("status", status);
//            session.setAttribute("listSlider", listSlider);
//        }

        if (service.equals("updateStatus")) {
            String stringSliderId = request.getParameter("sliderId");
            String newStatus = request.getParameter("newStatus");
            if (stringSliderId != null && !stringSliderId.isEmpty()) {
                int sliderId = Integer.parseInt(stringSliderId);
                ArrayList<Slider> listSlider = (ArrayList<Slider>) session.getAttribute("listSlider");
                for (Slider slider : listSlider) {
                    if (slider.getSliderId() == sliderId) {
                        slider.setStatus(newStatus);
                        daoSlider.updateSlider(slider);
                        break;
                    }
                }
                session.setAttribute("listSlider", listSlider);

            }
        }

        if (service.equals("updateSlider")) {
            int sliderId = Integer.parseInt(request.getParameter("sliderId"));
            ArrayList<Slider> findSlider = daoSlider.getAll("SELECT * FROM slider where slider_id = " + sliderId);
            Slider sliderToUpdate = findSlider.get(0);

            // Update slider information
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String status = request.getParameter("status");

            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            if (!fileName.isEmpty()) {
                // If a new image is uploaded, save it and update slider image path
//                InputStream fileContent = filePart.getInputStream();
//                File uploads = new File("E:\\Summer2024\\SWP391\\bookshop11\\src\\main\\webapp\\img\\slider");
//                File uploads = new File("C:\\Users\\TDG\\Documents\\NetBeansProjects\\ban\\bookshop\\src\\main\\webapp\\img\\slider");
//                File file = new File(uploads, fileName);
//                try (OutputStream out = new FileOutputStream(file)) {
//                    byte[] buffer = new byte[1024];
//                    int bytesRead;
//                    while ((bytesRead = fileContent.read(buffer)) != -1) {
//                        out.write(buffer, 0, bytesRead);
//                    }
//                }
//                sliderToUpdate.setImage("img/slider/" + fileName);
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
            }
            sliderToUpdate.setImage("uploads/" + fileName);
            sliderToUpdate.setTitle(title);
            sliderToUpdate.setDescription(description);
            sliderToUpdate.setStatus(status);

            // Update slider in database
            daoSlider.updateSlider(sliderToUpdate);

            ArrayList<Slider> listSlider = daoSlider.getAll("SELECT * FROM slider");
            session.setAttribute("listSlider", listSlider);
            response.sendRedirect("marketingslider");
            return;
        }

        if (service.equals("delete")) {
            ArrayList<Slider> listSlider = (ArrayList<Slider>) session.getAttribute("listSlider");
            String stringSliderId = request.getParameter("sliderId");
            if (stringSliderId != null && !stringSliderId.isEmpty()) {
                int sliderId = Integer.parseInt(stringSliderId);
                for (Slider slider : listSlider) {
                    if (slider.getSliderId() == sliderId) {
                        listSlider.remove(slider);
                        daoSlider.deleteSlider(sliderId);
                        break;
                    }
                }
            }
            session.setAttribute("listSlider", listSlider);

        }

        if (service.equals("addSlider")) {
            String title = request.getParameter("newTitle");
            String description = request.getParameter("newDescription");
            String status = request.getParameter("newStatus");

            Part filePart = request.getPart("newImage");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            InputStream fileContent = filePart.getInputStream();

//            File uploads = new File("E:\\Summer2024\\SWP391\\bookshop11\\src\\main\\webapp\\img\\slider");
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            Slider slider = new Slider();
            slider.setUserId(user.getUserId());
            slider.setTitle(title);
            slider.setDescription(description);
//            slider.setImage("img/slider/" + fileName);
            slider.setImage("uploads/" + fileName);
            slider.setStatus(status);
            int result = daoSlider.insert(slider);

            if (result > 0) {
                session.setAttribute("messageSlider", "Thêm Slider Thành Công");
            } else {
                session.setAttribute("messageSlider", "Thêm Slider Thất Bại");
            }

            ArrayList<Slider> listSlider = (ArrayList<Slider>) session.getAttribute("listSlider");
            listSlider.add(slider);

            session.setAttribute("listSlider", listSlider);
            response.sendRedirect("marketingslider");
            return;
        }

        //select(jsp)   
        RequestDispatcher dispth = request.getRequestDispatcher("./views/sliderlist.jsp");
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
