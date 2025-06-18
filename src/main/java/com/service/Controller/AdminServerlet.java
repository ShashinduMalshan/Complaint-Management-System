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

@WebServlet("/admin")
public class AdminServerlet extends HttpServlet {
    CompliantDao complainDao = new CompliantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Complain> complains = complainDao.getAllComplaints();
        request.setAttribute("complaints", complains);
        request.getRequestDispatcher("/Admin.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

         String action = req.getParameter("action");
        System.out.println(action);

        if (action == null) {
            resp.getWriter().println("No action specified");
            return;
        }

        switch (action) {
            case "update":
                updateComplainProcess(req,resp);
                break;
            case "addAdmin":
                addAdmin();
                break;

            case "delete":
                deleteComplainProcess(req,resp);
                break;

            default:
                resp.getWriter().println("Invalid action: " + action);
                break;



        }

    }

    private void addAdmin() {
    }


    private void updateComplainProcess(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String id = req.getParameter("id");
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        System.out.println("Updating complaint: " + id + " | Status: " + status + " | Remarks: " + remarks);

        Complain complain = new Complain(id, "userId", "subject", "description", status, remarks, "Not Work");

        boolean result = complainDao.updateState(complain);
        resp.setContentType("text/html");

        if (result) {
            resp.getWriter().println("<script>alert('Complaint updated successfully!'); window.location.href='admin';</script>");
        } else {
            resp.getWriter().println("<script>alert('Complaint update failed!'); window.location.href='admin';</script>");
        }

    }


    private void deleteComplainProcess(HttpServletRequest req, HttpServletResponse resp) throws IOException {

            String id = req.getParameter("id");


            boolean result = complainDao.deleteComplain(id);
            resp.setContentType("text/html");
            System.out.println(result);

            if (result) {
                resp.getWriter().println("<script>alert('Complaint deleted successfully!'); window.location.href='admin';</script>");
            } else {
                resp.getWriter().println("<script>alert('Complaint deletion failed!'); window.location.href='admin';</script>");
            }

    }

}
