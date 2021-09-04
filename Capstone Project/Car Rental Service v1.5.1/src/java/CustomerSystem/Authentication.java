/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomerSystem;

//Exception Import
import java.io.IOException;

//Servlet Imports
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

//Database Imports
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.DriverManager;

/**
 *
 * @author Gavin Tichi
 */
public class Authentication extends HttpServlet {
    
    //database connection variables
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String CONN_STRING = 
            "jdbc:mysql://localhost:3306/car_rental?useSSL=false";
    private static final String TABLE_NAME = "car_rental.renter_info";
    
    //variable for user account session
    private HttpSession session;
    
    //variables for login credentials
    private String email;
    private String password;
    private int customer_id;
    private Boolean validLogin;
    
    //variables for invalid credentials lockout
    private Boolean lockout;
    private int failedAttempts;
    //maximum number of invalid credential input before lockout
    static final int MAX_FAILS = 3;
    
    //Handle post method from Login form with action Authentication
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //retrieve credentials from POST method
        email = request.getParameter("email");
        password = request.getParameter("pass");
        
        //run credentials against DB to check validity
        this.lockout = false;
        validLogin = authenticate(this.email, this.password, lockout);
        
        response.setContentType("text/html;charset=UTF-8");
        
        //if user has been locked out of the account
        if (this.lockout) {
            //Set error message for request
            request.setAttribute("ErrorMessage", "User locked out. Select Reset Password on Login to try again.");
            
            //Send user back to login with error message
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        } else if (validLogin) { //if user credentials match
            //Create a session for the user's account
            session = request.getSession(true);
            session.setAttribute("email", email);
            session.setAttribute("user_id", customer_id);
            
            //Redirect user to homepage
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request,response);
        } else { //if user credentials do not match
            //Set invalid credentials message
            request.setAttribute("ErrorMessage", "Credentials are invalid. Try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request,response);
        }
    }
    
    //Check if the email and password match in the database to verify user login
    public Boolean authenticate(String email, String password, Boolean lockout) {
        //return value for if login is valid
        boolean validCredentials = false;
        
        //track matches in DB for credentials
        int matches = 0;
        
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            //Check if email exists in DB via Prepared Statement
            String searchEmail = "SELECT id FROM " + TABLE_NAME + " WHERE email = ?";
            PreparedStatement checkEmail = conn.prepareStatement(searchEmail);
            checkEmail.setString(1, email);
            ResultSet checkEmailReturn = checkEmail.executeQuery();
            
            //check ResultSet if email was in there, and extract user ID from query
            while (checkEmailReturn.next()) {
                customer_id = checkEmailReturn.getInt(1);
            }
            
            //if email existed in database
            if (customer_id > 0) {
                //check if that email is locked out due to invalid attempts
                String searchLockout = "SELECT failed_attempts FROM " + TABLE_NAME + " WHERE id = ?";
                PreparedStatement checkLockout = conn.prepareStatement(searchLockout);
                checkLockout.setInt(1, customer_id);
                ResultSet checkLockoutReturn = checkLockout.executeQuery();
                
                //read the account's lockout value
                while (checkLockoutReturn.next()) {
                    failedAttempts = checkLockoutReturn.getInt(1);
                }
                if(failedAttempts >= MAX_FAILS) {
                    this.lockout = true;
                    System.out.println("User locked");
                }
                
                //if username isn't locked out
                if (!this.lockout) {
                    String searchPass = "SELECT id FROM " + TABLE_NAME + " WHERE id = ? and password = ?";
                    PreparedStatement checkPass = conn.prepareStatement(searchPass);
                    checkPass.setInt(1, customer_id);
                    checkPass.setString(2,password);
                    ResultSet checkPassReturn = checkPass.executeQuery();
                    
                    //check if user/pass match was found
                    while (checkPassReturn.next()) {
                        matches++;
                    }
                    
                    //if the password was correct
                    if(matches > 0) {
                        validCredentials = true;
                        
                        //Reset incorrect password count
                        String resetLockout = "UPDATE " + TABLE_NAME + " SET failed_attempts = 0 WHERE id = ?";
                        PreparedStatement updateLockout = conn.prepareStatement(resetLockout);
                        updateLockout.setInt(1, customer_id);
                        updateLockout.executeUpdate();
                    } else { //password did not match
                       String addLockToUser = "UPDATE " + TABLE_NAME + " SET failed_attempts = failed_attempts + 1 WHERE id = ?";
                       PreparedStatement addLockout = conn.prepareStatement(addLockToUser);
                       addLockout.setInt(1, customer_id);
                       addLockout.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        
        return validCredentials;
    };
}
