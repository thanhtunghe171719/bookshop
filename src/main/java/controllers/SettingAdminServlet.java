package controllers;

import dal.DAOCategories;
import dal.DAORole;
import dal.DAOSlider;
import dal.DAOUserRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import models.Categorie;
import models.Role;
import models.User;
import models.UserRole;

public class SettingAdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        HttpSession session = request.getSession();
//        DAOUserRole userroleDAO = new DAOUserRole();
//        User user = (User) session.getAttribute("user");
//        String service = request.getParameter("service");
//        
//        if (service.equals("updateStatus")) {
//            String stringUserRoleId = request.getParameter("role_id");
//            String newStatus = request.getParameter("newStatus");
//            if (stringUserRoleId != null && !stringUserRoleId.isEmpty()) {
//                int roleId = Integer.parseInt(stringUserRoleId);
//                ArrayList<UserRole> listUserRole = (ArrayList<UserRole>) session.getAttribute("listUserRole");
//                for (UserRole roles: listUserRole) {
//                    if (roles.getRole_id() ==  roleId) {
//                        roles.setStatus_id(newStatus);
//                        break;
//                    }
//                }
//                session.setAttribute("listSlider", listSlider);
//
//            }
//        }
//        HttpSession session = request.getSession();
//
//
//        DAORole dao = new DAORole();
//
//        String service = request.getParameter("service");
//        if (service == null) {
//            service = "listAll";
//        }
//        if (service.equals("listAll")) {
//             int role_id = Integer.parseInt("role_id");
//            String role_name = request.getParameter("role_name");
//            int status_id = Integer.parseInt("status_id");
//
//
//            session.setAttribute("role_id", role_id);
//            session.setAttribute("role_name", role_name);
//            session.setAttribute("status_id", status_id);
//
//        }
//        if (service.equals("addRole")) {
//            int role_id = Integer.parseInt("newId");
//            String role_name = request.getParameter("newName");
//            int status_id = Integer.parseInt("newStatus");
//            Role role = new Role();
//            role.setRole_id(role_id);
//            role.setRole_name(role_name);
//            role.setStatus_id(status_id);
//            int result = dao.insert(role);
//
//            if (result > 0) {
//                session.setAttribute("messageRole", "Thêm Role Thành Công");
//            } else {
//                session.setAttribute("messageRole", "Thêm Role Thất Bại");
//            }
//
//            ArrayList<Role> listRole = (ArrayList<Role>) session.getAttribute("listRole");
//            listRole.add(role);
//
//            session.setAttribute("listRole", listRole);
//            response.sendRedirect("settingadmin");
//        }
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
        return "Mô tả ngắn gọn";
    }
}
