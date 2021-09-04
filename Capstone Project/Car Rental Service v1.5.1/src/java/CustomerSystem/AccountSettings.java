/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomerSystem;

//Exception Imports
import java.io.IOException;

//Servlet Imports
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

//Database Imports
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

//RegEx imports
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author apgav
 */
public class AccountSettings extends HttpServlet{
    //database connection variables
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String CONN_STRING = 
            "jdbc:mysql://localhost:3306/car_rental?useSSL=false";
    private static final String TABLE_NAME = "car_rental.renter_info";
    
    //variable for user account session
    private HttpSession session;
    
    //account variables
    private int user_id;
    private String email;
    private String oldPassword;
    private String newPassword;
    private String newPasswordConfirm;
    
    //variables for redirecting user
    private String messageType;
    private String message;
    private String redirectPage;
    
    //Password Requirement RegEx
    private static final String PASSWORD_REGEX = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&+=])(?=\\S+$).{8,}$";

    //variables for invalid credentials lockout
    private Boolean lockout;
    private int failedAttempts;
    //maximum number of invalid credential input before lockout
    final int MAX_FAILS = 3;
    
    //Handle POST method from Account Page for changing password
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        //grab form and session variables
        session = request.getSession(false);
        email = (String) session.getAttribute("email");
        user_id = (int) session.getAttribute("user_id");
        oldPassword = request.getParameter("oldPass");
        newPassword = request.getParameter("newPass");
        newPasswordConfirm = request.getParameter("newPassConfirm");
        
        if(checkPasswordForm(request)) {//check if inputs are good
            if(changePassword()) { //if password updates successfully
                message = "Password updated successfully.";
                messageType = "SystemMessage";
                redirectPage = "account.jsp";
            } else { //if password fails to update
                message = "Password failed to update. Try again later.";
                messageType = "ErrorMessage";
                redirectPage = "account.jsp";
            }
        } else if (lockout) {
            message = "You have been locked out of your account.";
            messageType = "ErrorMessage";
            redirectPage = "logout.jsp";
        } else {
            message = "Bad form input detected. Correct all fields and try again.";
            messageType = "ErrorMessage";
            redirectPage = "account.jsp";
        }
        redirectUser(request, response, messageType, redirectPage, message); 
    }
    
    //Checks inputs in password change form for password rules and matches
    //Return True if all 3 fields are filled, the old password is correct,
    //and the password follows these rules:
    //At least 8 characters, one uppercase and one lowercase letter, one number,
    //one special character, and no whitespace
    private Boolean checkPasswordForm(HttpServletRequest request) {
        Boolean validForm = true;
        lockout = false;
        
        if(oldPassword.equals("")) {//if old password is blank
            validForm = false;
            request.setAttribute("oldPassError","Old password must be provided.");
        } else if (lockout) {
            validForm = false;
        } else if (!authenticate(user_id, oldPassword)) {//if old password is incorrect
            validForm = false;
            request.setAttribute("oldPassError","Old password is incorrect.");
        }
        
        //check if password field is empty first, then validate for the password rules
        Pattern passwordRegEx = Pattern.compile(PASSWORD_REGEX);
        Matcher passwordCheck = passwordRegEx.matcher(newPassword);
        if(newPassword.equals("")) {
            validForm = false;
            request.setAttribute("newPassError","New password must be provided.");
        } else if (!passwordCheck.matches()) {
            validForm = false;
            request.setAttribute("newPassError","New password must contain at least 8 characters,</br>"
                                                +"an upper case and lower case letter, a number,</br>"
                                                +"a special character, and no whitespace.");
        }
        
        if(newPasswordConfirm.equals("")) {//if new password confirmation is blank
            validForm = false;
            request.setAttribute("newPassConfirmError","New password confirmation must not be blank.");
        } else if(!newPasswordConfirm.equals(newPassword)) { //if new pass confirmation does not match
            validForm = false;
            request.setAttribute("newPassConfirmError","New passwords must match.");
        }
        return validForm;
    }
    
    //Changes the stored password for the user to random password
    //and sends a copy of it to the user's email
    private Boolean changePassword() {
        //capture return value from SQL query to check if pass was updated
        int updatedRow = 0;
        
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            //set password to newly generated string and reset failed attempts on account
            String updatePassword = "UPDATE " + TABLE_NAME + " SET password = '" + 
                    newPassword + "', failed_attempts = 0 WHERE id = " + user_id;
            System.out.println(updatePassword);
            PreparedStatement setNewPassword = conn.prepareStatement(updatePassword);
            updatedRow = setNewPassword.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return (updatedRow > 0);
    }
    
    //accept the HttpServletRequest/Response objects and a custom message to send the
    //user back to the registration form with the new error message
    private void redirectUser(HttpServletRequest request, HttpServletResponse response,
            String messageType, String targetPage, String error) 
            throws ServletException, IOException {
        //assign message to request
        request.setAttribute(messageType, error);
        
        //push user back to registration form with the error message included
        RequestDispatcher dispatcher = request.getRequestDispatcher(targetPage);
        dispatcher.forward(request,response);
    }
    
    private Boolean authenticate(int user_id, String password) {
        //return value
        boolean validPassword = false;
        
        //database match tracking
        int matches = 0;
        
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            //check if user got locked out
            String searchLockout = "SELECT failed_attempts FROM " + TABLE_NAME + " WHERE id = ?";
            PreparedStatement checkLockout = conn.prepareStatement(searchLockout);
            checkLockout.setInt(1, user_id);
            ResultSet checkLockoutReturn = checkLockout.executeQuery();

            //read the account's lockout value
            while (checkLockoutReturn.next()) {
                failedAttempts = checkLockoutReturn.getInt(1);
            }
            if(failedAttempts >= MAX_FAILS) {
                lockout = true;
                System.out.println("User locked");
            }
            
            //if user is not locked out
            if (!lockout) {
                String checkPassword = "SELECT id FROM " + TABLE_NAME + " WHERE id = ? AND password = ?";
                PreparedStatement checkInfo = conn.prepareStatement(checkPassword);
                checkInfo.setInt(1, user_id);
                checkInfo.setString(2,password);
                ResultSet checkPasswordMatches = checkInfo.executeQuery();

                //check if password matches the user's account
                while(checkPasswordMatches.next()) {
                    validPassword = true;
                    matches++;
                }
                
                //if password was wrong, add to lockout counter
                if(matches == 0) {
                    String addLockToUser = "UPDATE " + TABLE_NAME + " SET failed_attempts = failed_attempts + 1 WHERE id = ?";
                    PreparedStatement addLockout = conn.prepareStatement(addLockToUser);
                    addLockout.setInt(1, user_id);
                    addLockout.executeUpdate();
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return validPassword;
    }
}
