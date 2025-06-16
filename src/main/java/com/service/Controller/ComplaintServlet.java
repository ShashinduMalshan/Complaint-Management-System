package com.service.Controller;

import com.service.DAO.CompliantDao;
import com.service.model.Complain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/submitComplaint")

public class ComplaintServlet extends HttpServlet {
    CompliantDao complainDao = new CompliantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Complain> complains = complainDao.getAllComplaints();
        request.setAttribute("complaints", complains);
        request.getRequestDispatcher("/Complain.jsp").forward(request, response);

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
            response.getWriter().println("<script>alert('Complaint saved successfully!'); window.location.href='submitComplaint';</script>");
        } else {
            response.getWriter().println("<h3>complain failed!</h3>");
        }
            System.out.println("saved");


    }


    public void updateComplain(HttpServletRequest req, HttpServletResponse response) throws IOException {


         String id = req.getParameter("id");
         String userId = req.getParameter("userId");
         String subject = req.getParameter("subject");
         String description = req.getParameter("description");

        Complain complain = new Complain(id ,userId,subject, description, "pending", "none","Not Work");

        boolean result = complainDao.updateCompliant(complain);
        response.setContentType("text/html");

        if (result) {
            System.out.println("updated");
        } else {
            response.getWriter().println("<h3>complain update failed!</h3>");

        }

    }


    public void deleteComplain(HttpServletRequest req, HttpServletResponse response) throws IOException {
        String id = req.getParameter("id");
        boolean result = complainDao.deleteComplain(id);
        if (result) {
            System.out.println("updated");
        } else {
            response.getWriter().println("<h3>complain update failed!</h3>");

        }
        response.setContentType("text/html");
    }
}
