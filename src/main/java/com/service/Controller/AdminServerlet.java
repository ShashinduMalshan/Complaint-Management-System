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

}
