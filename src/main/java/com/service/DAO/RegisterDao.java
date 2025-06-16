package com.service.DAO;

import com.service.model.User;
import jakarta.annotation.Resource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class RegisterDao {

    @Resource(name = "jdbc/pool")
    private static DataSource dataSource;

    public RegisterDao() {
            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                this.dataSource = (DataSource) envContext.lookup("jdbc/pool");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    public boolean saveUser(String name, String password) {
        String sql = "INSERT INTO users (name, password) VALUES (?, ?)";

        try  {
            Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, password);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
