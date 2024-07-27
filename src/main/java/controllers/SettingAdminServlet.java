package controllers;

import dal.DAOCategories;
import dal.DAOUserRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import models.Categorie;
import models.Slider;
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
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        DAOUserRole userroleDAO = new DAOUserRole();
        DAOCategories categoryDAO = new DAOCategories();
        List<UserRole> roles = userroleDAO.getAllUserRoles();
        List<Categorie> categories = categoryDAO.getAllCategory();
        request.setAttribute("roles", roles);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/settingadmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            updateRoleStatus(request, response);
        } else if ("addRole".equals(action)) {
            addNewRole(request, response);
        }
    }

    private void updateRoleStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DAOUserRole userroleDAO = new DAOUserRole();
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        int newStatus = Integer.parseInt(request.getParameter("newStatus"));

        boolean success = userroleDAO.updateRoleStatus(roleId, newStatus);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\": " + success + "}");
    }

    private void addNewRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DAOUserRole userroleDAO = new DAOUserRole();
        String roleName = request.getParameter("roleName");

        boolean success = userroleDAO.addRole(roleName);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\": " + success + "}");
    }

    @Override
    public String getServletInfo() {
        return "Mô tả ngắn gọn";
    }
}
