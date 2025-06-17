package com.service.Controller;

import com.service.DAO.LoginDao;
import com.service.model.Complain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/login")
public class login extends HttpServlet {

    LoginDao loginDao = new LoginDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        String id;
        try {
           id  = String.valueOf(loginDao.getUserId(name,password,role));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            boolean result = loginDao.validateUser(name,password,role);
            System.out.println(result);
            if (result) {
                if ( role.equals("employee") ){
                    resp.sendRedirect("submitComplaint?name="+name+"&id="+id);

                }else if ( role.equals("admin") ){
                    resp.sendRedirect("admin");
                }
            } else {
                req.setAttribute("errorMessage", "Invalid username or password");
                req.getRequestDispatcher("/LoginPage.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
}
