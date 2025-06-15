package com.service.model;

import javax.sql.DataSource;

/**
 * Model class representing a user in the system.
 */
public class User {
    private String userId;
    private String name;
    private String password;

    /**
     * Default constructor
     */
    public User() {
    }

    /**
     * Constructor with all fields
     * 
     * @param userId the user ID
     * @param name the user's name
     * @param password the user's password
     */
    public User(String userId, String name, String password) {
        this.userId = userId;
        this.name = name;
        this.password = password;
    }



    /**
     * Get the user ID
     * 
     * @return the user ID
     */
    public String getUserId() {
        return userId;
    }

    /**
     * Set the user ID
     * 
     * @param userId the user ID to set
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * Get the user's name
     * 
     * @return the user's name
     */
    public String getName() {
        return name;
    }

    /**
     * Set the user's name
     * 
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Get the user's password
     * 
     * @return the user's password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Set the user's password
     * 
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }
}