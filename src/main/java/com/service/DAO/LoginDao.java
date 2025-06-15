package com.service.DAO;

import jakarta.annotation.Resource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

        public boolean validateUser(String name, String password,String role) throws SQLException {
        String sql = "SELECT * FROM users WHERE name = ? AND password = ? AND role = ?";

        Connection connection =dataSource.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, password);
        ps.setString(3, role);

            boolean result = ps.executeQuery().next();

            if (result) {
                return true;
            }else {
                return false;
            }
        }

}
