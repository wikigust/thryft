package model.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class User {
    private String username;
    private String email;
    private String password;

    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    // Save this user to the database
    public boolean save() {
        try {
            System.out.println("Connecting to DB...");
            Connection conn = DatabaseConnection.initializeDatabase();
            System.out.println("Connected!");

            String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);

            int rowsInserted = stmt.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);

            conn.close();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();  // 🧨 This will show what went wrong
            return false;
        }
    }

}
