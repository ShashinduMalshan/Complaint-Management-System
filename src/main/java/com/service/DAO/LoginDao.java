package com.service.DAO;

import jakarta.annotation.Resource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {

    @Resource(name = "jdbc/pool")
    private static DataSource dataSource;

    public LoginDao() {
        try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                this.dataSource = (DataSource) envContext.lookup("jdbc/pool");
            }
        catch (Exception e) {
            e.printStackTrace();
            }
    }

        public boolean validateUser(String name, String password, String role) {
        String sql = "SELECT * FROM users WHERE name = ? AND password = ? AND role = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean result = false;

        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, password);
            ps.setString(3, role);

            rs = ps.executeQuery();
            result = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }


    public int getUserId(String name, String password, String role) {
        String sql = "SELECT id FROM users WHERE name = ? AND password = ? AND role = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int userId = 0;

        try {
            connection = dataSource.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, password);
            ps.setString(3, role);

            rs = ps.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return userId;
    }

}
