package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import models.User;

public class AuthorizationFilter implements Filter {

    private boolean debug = true;

    private static final Map<String, Integer> urlRoleMap = new HashMap<>();

    static {
        urlRoleMap.put("/admin_dashboard", 1);
        urlRoleMap.put("/userList", 1);
        urlRoleMap.put("/settingadmin", 1);

        urlRoleMap.put("/marketing_dashboard", 2);
        urlRoleMap.put("/marketing-product", 2);
        urlRoleMap.put("/managerpost", 2);
        urlRoleMap.put("/createrpost", 2);
        urlRoleMap.put("/marketingslider", 2);
        urlRoleMap.put("/customers", 2);
        urlRoleMap.put("/manage-feedback", 2);
        urlRoleMap.put("/createrpost", 2);

        urlRoleMap.put("/manage-order-sale", 3);

        urlRoleMap.put("/cartdetails", 4);
        urlRoleMap.put("/cartcontact", 4);
        urlRoleMap.put("/myorders", 4);
        urlRoleMap.put("/orderinformation", 4);
        urlRoleMap.put("/thankyou", 4);

        urlRoleMap.put("/sale_dashboard", 5);
        urlRoleMap.put("/manage-sale", 5);
        
        urlRoleMap.put("/manage-shipper", 6);

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("AuthorizationFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        String url = req.getServletPath();
        User user = (User) session.getAttribute("user");
        log(url);
        if (user != null) {
            // Prevent direct access to login and register pages for logged-in users
            if (url.equals("/login") || url.equals("/register")) {
                res.sendRedirect("home");
                return;
            } else {
                Integer requiredRole = urlRoleMap.get(url);
                if (requiredRole != null) {
                    if (user.getRoleId() == requiredRole) {
                        chain.doFilter(request, response);
                    } else {
                        res.sendRedirect("error404");
                    }
                } else {
                    // Allow access for URLs not in the map
                    chain.doFilter(request, response);
                }
            }
        } else {
            // If the user is not logged in, allow access to login and register pages
            if (url.equals("/login") || url.equals("/register")) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect("login");
            }
        }

//        Throwable problem = null;
//        try {
//            chain.doFilter(request, response);
//        } catch (Throwable t) {
//            problem = t;
//            t.printStackTrace();
//        }
//        doAfterProcessing(request, response);
//
//        if (problem != null) {
//            if (problem instanceof ServletException) {
//                throw (ServletException) problem;
//            }
//            if (problem instanceof IOException) {
//                throw (IOException) problem;
//            }
//            sendProcessingError(problem, response);
//        }
    }

    @Override
    public void init(FilterConfig filterConfig) {
        // Any filter initialization code
    }

    @Override
    public void destroy() {
        // Any filter cleanup code
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        // Any pre-processing code
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        // Any post-processing code
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        // Error handling code
    }

    private void log(String msg) {
        System.out.println(msg);
    }
}
