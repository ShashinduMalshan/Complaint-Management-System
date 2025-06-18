package com.service.DAO;

import com.service.model.Complain;
import jakarta.annotation.Resource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CompliantDao {

    @Resource(name = "jdbc/pool")
    private static DataSource dataSource;

    LocalDateTime now = LocalDateTime.now();
    Timestamp timestamp = Timestamp.valueOf(now);

    public CompliantDao() {
            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                this.dataSource = (DataSource) envContext.lookup("jdbc/pool");
            } catch (Exception e) {
                e.printStackTrace();
            }
    }

    public List<Complain> getAllComplaints() {

        String sql = "SELECT * FROM complaints";
        List<Complain> complains = new ArrayList<>();

        try {
            Connection con = dataSource.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Complain complain = new Complain();
                complain.setCreatedAt(rs.getString("created_at"));
                complain.setDescription(rs.getString("description"));
                complain.setComId(rs.getString("comId"));
                complain.setRemarks(rs.getString("remarks"));
                complain.setStatus(rs.getString("status"));
                complain.setSubject(rs.getString("subject"));
                complain.setUserId(rs.getString("user_id"));
                complains.add(complain);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complains;
    }

    public List<Complain> getComplaintsByUserId(String userId) {
        String sql = "SELECT * FROM complaints WHERE user_id = ?";

        List<Complain> complains = new ArrayList<>();

        try {
            Connection con = dataSource.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Complain complain = new Complain();
                complain.setCreatedAt(rs.getString("created_at"));
                complain.setDescription(rs.getString("description"));
                complain.setComId(rs.getString("comId"));
                complain.setRemarks(rs.getString("remarks"));
                complain.setStatus(rs.getString("status"));
                complain.setSubject(rs.getString("subject"));
                complain.setUserId(rs.getString("user_id"));
                complains.add(complain);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complains;
    }

    public boolean saveCompliant(Complain complain) {

        String sql = "INSERT INTO complaints ( user_id, subject, description,status,remarks,created_at) VALUES (?, ?, ?, ?,?,?)";
        try {
            Connection con = dataSource.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, complain.getUserId());
            ps.setString(2, complain.getSubject());
            ps.setString(3, complain.getDescription());
            ps.setString(4, "pending");
            ps.setString(5, "none");
            ps.setTimestamp(6, timestamp);

            return ps.executeUpdate() > 0;

        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


     public boolean updateCompliant(Complain complain) {

        String sql = "UPDATE complaints SET user_id = ?, subject = ?, description = ?, status = ?, remarks = ?, created_at = ? WHERE comId = ?";
            try {
                Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, complain.getUserId());
                ps.setString(2, complain.getSubject());
                ps.setString(3, complain.getDescription());
                ps.setString(4, complain.getStatus());
                ps.setString(5, complain.getRemarks());
                ps.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now())); // updated time
                ps.setString(7, complain.getComId());


                return ps.executeUpdate() > 0;

            }catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }

        public boolean updateState(Complain complain) {

            String sql = "UPDATE complaints SET status = ?, remarks = ? WHERE comId = ?";
                try {
                    Connection con = dataSource.getConnection();
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, complain.getStatus());
                    ps.setString(2, complain.getRemarks());
                    ps.setString(3, complain.getComId());


                    return ps.executeUpdate() > 0;

                }catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }
        }

        public boolean deleteComplain(String complain) {

            String sql = "DELETE FROM complaints WHERE comId = ?";

            try {
                Connection connection = dataSource.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, complain);

                return ps.executeUpdate() > 0;

            } catch (SQLException e) {
                e.printStackTrace();
                return false;

            }

        }




}
