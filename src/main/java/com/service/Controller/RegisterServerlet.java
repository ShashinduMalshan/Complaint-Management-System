package com.service.Controller;

import com.service.DAO.RegisterDao;
import com.service.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServerlet extends HttpServlet {

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws IOException {

        RegisterDao registerDao = new RegisterDao();

        String name = request.getParameter("name");
        String password = request.getParameter("password");



        boolean result = registerDao.saveUser(name,password);
        if (result) {
            response.sendRedirect("LoginPage.jsp");

        }

        response.setContentType("text/html");

    }

}
