package com.service.DAO;

import com.service.model.User;
import jakarta.annotation.Resource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDao {

    @Resource(name = "jdbc/pool")
    private static DataSource dataSource;

    public UserDao() {
            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                this.dataSource = (DataSource) envContext.lookup("jdbc/pool");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    public boolean saveUser(User user) {
        String sql = "INSERT INTO users (user_id, name, password, role) VALUES (?, ?, ?, ?)";

        try  {
            Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getUserId());
            ps.setString(2, user.getName());
            ps.setString(3, user.getPassword());
            ps.setString(4, "employee"); // hardcoded for now

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
