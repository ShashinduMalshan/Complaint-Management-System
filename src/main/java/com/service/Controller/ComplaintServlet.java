package com.service.Controller;

import com.service.DAO.CompliantDao;
import com.service.model.Complain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/submitComplaint")

public class ComplaintServlet extends HttpServlet {

    CompliantDao complainDao = new CompliantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        try {
            HttpSession session = request.getSession();
            String name = (String) session.getAttribute("name");
            String id = (String) session.getAttribute("id");

            if (id == null) {
                request.getRequestDispatcher("/LoginPage.jsp").forward(request, response);
                return;
            }

            List<Complain> complains = complainDao.getComplaintsByUserId(id);
            request.setAttribute("complaints", complains);
            request.getRequestDispatcher("/Complain.jsp").forward(request, response);
        } catch (Exception e) {
            request.getRequestDispatcher("/LogingPage.jsp").forward(request, response);
        }

    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null) {
            response.getWriter().println("No action specified");
            return;
        }

        switch (action) {
            case "create":
                addComplain(req, response);
                break;
            case "update":
                updateComplain(req, response);
                break;
            case "delete":
                deleteComplain(req, response);
                break;
            default:
                response.getWriter().println("Invalid action: " + action);
                break;
        }

    }

    public void addComplain(HttpServletRequest req, HttpServletResponse response) throws IOException {


         String id = "";
         String userId = req.getParameter("userId");
         String subject = req.getParameter("subject");
         String description = req.getParameter("description");

        Complain complain = new Complain(id ,userId,subject, description, "pending", "none","Not Work");

        boolean result = complainDao.saveCompliant(complain);
            response.setContentType("text/html");

        if (result) {
            req.getSession().setAttribute("swal", "success|Complaint Create!|Your complaint has been successfully Create.");
        } else {
            req.getSession().setAttribute("swal", "error|Failed!|Complaint could not be Create.");
        }
        
        response.sendRedirect(req.getContextPath() + "/submitComplaint");


    }


    public void updateComplain(HttpServletRequest req, HttpServletResponse response) throws IOException, ServletException {


         String id = req.getParameter("id");
         String userId = req.getParameter("userId");
         String subject = req.getParameter("subject");
         String status = req.getParameter("status");
         String description = req.getParameter("description");

        if (!status.equals("Pending")) {
            response.getWriter().println("<script>alert('You cannot update complaint in " + status + " status!'); window.location.href='submitComplaint';</script>");
//            req.getSession().setAttribute("swal", "error|Complaint Updated!|You cannot update complaint in status!");
            return;
        }

        Complain complain = new Complain(id, userId, subject, description, status, "none", "Not Work");

        boolean result = complainDao.updateCompliant(complain);
        response.setContentType("text/html");

        if (result) {
            req.getSession().setAttribute("swal", "success|Complaint Updated!|Your complaint has been successfully updated.");
        } else {
            req.getSession().setAttribute("swal", "error|Failed!|Complaint could not be Update.");
        }
            response.sendRedirect(req.getContextPath() + "/submitComplaint");

    }


    public void deleteComplain(HttpServletRequest req, HttpServletResponse response) throws IOException {
        String id = req.getParameter("id");
        String status = req.getParameter("status");

        response.setContentType("text/html");

        if (!status.equals("Pending")) {
            response.getWriter().println("<script>alert('You cannot delete complaint in " + status + " status!'); window.location.href='submitComplaint';</script>");
            return;
        }
        boolean result = complainDao.deleteComplain(id);
        if (result) {
            req.getSession().setAttribute("swal", "success|Complaint Deleted!|Your complaint has been successfully deleted.");
        } else {
            req.getSession().setAttribute("swal", "error|Failed!|Complaint could not be delete.");
        }
        response.sendRedirect(req.getContextPath() + "/submitComplaint");

    }
}
