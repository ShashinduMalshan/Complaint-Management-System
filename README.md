# Complaint Management System

## Project Overview
The Complaint Management System is a web-based application that allows users to submit, track, and manage complaints. The system has two main user roles: regular users who can submit complaints, and administrators who can manage and respond to complaints.

## Features
- User registration and login
- Submit new complaints
- View complaint history
- Update complaint status (admin)
- Add remarks to complaints (admin)
- Delete complaints (admin)

## Technologies Used
- Java Servlets
- JSP (JavaServer Pages)
- MySQL Database
- JDBC for database connectivity
- Tomcat Server
- HTML/CSS/JavaScript for frontend

## Setup Instructions

### Prerequisites
- JDK 8 or higher
- Apache Tomcat 9 or higher
- MySQL 8.0 or higher

### Database Setup
1. Create a MySQL database named `complaint_management_db`
2. Execute the SQL schema script in `database_schema.sql` to create the necessary tables and indexes
   ```bash
   mysql -u root -p < database_schema.sql
   ```

### Application Configuration
1. Update the database connection details in `web/META-INF/context.xml` if needed
2. Deploy the application to Tomcat server

## Database Schema

### Tables

#### users
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'user'
);
```

#### complaints
```sql
CREATE TABLE complaints (
    comId INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    remarks VARCHAR(255) DEFAULT 'none',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Database Relationships
- Each complaint is associated with a user through the `user_id` field in the `complaints` table.

## Usage
1. Register a new user account or login with existing credentials
2. Regular users can:
   - Submit new complaints
   - View their complaint history
   - Track the status of their complaints
3. Administrators can:
   - View all complaints in the system
   - Update the status of complaints (pending, processing, resolved)
   - Add remarks to complaints
   - Delete complaints

## Project Structure
- `src/main/java/com/service/Controller/`: Contains servlet classes that handle HTTP requests
- `src/main/java/com/service/DAO/`: Contains Data Access Object classes for database operations
- `src/main/java/com/service/model/`: Contains model classes representing data entities
- `web/`: Contains JSP files for the user interface
- `web/META-INF/`: Contains configuration files
