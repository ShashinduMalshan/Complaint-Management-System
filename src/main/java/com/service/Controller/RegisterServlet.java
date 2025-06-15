package com.service.Controller;

import com.service.DAO.UserDao;
import com.service.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserDao userDao = new UserDao();

        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        System.out.println(userId+" "+name+" "+password);

        User user = new User(userId, name, password);


        boolean result = userDao.saveUser(user);

        response.setContentType("text/html");
        if (result) {
            response.getWriter().println("<h3>Registration successful!</h3>");

        } else {
            response.getWriter().println("<h3>Registration failed!</h3>");
        }
        response.getWriter().println("<a href='saveUser.jsp'>Back</a>");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println(req.getHeader("name"));
    }
}
