package com.service.model;

public class Complain {
    private String comId;
    private String userId;
    private String subject;
    private String description;
    private String status;
    private String remarks;
    private String createdAt;

    public Complain() {
    }
    public Complain(String id , String userId, String subject,String description, String status, String remarks, String createdAt) {
        this.comId = id;
        this.userId = userId;
        this.subject = subject;
        this.description = description;
        this.status = status;
        this.remarks = remarks;
        this.createdAt = createdAt;
    }


    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}