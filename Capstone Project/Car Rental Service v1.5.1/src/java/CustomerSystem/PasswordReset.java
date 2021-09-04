/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomerSystem;

//Exception Imports
import java.io.IOException;
import java.io.UnsupportedEncodingException;

//Servlet Imports
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;

//Database Imports
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

//Utility class import
import java.util.Random;
import java.util.Date;
import java.util.Properties;

//Email Class Imports
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
/**
 *
 * @author apgav
 * JavaMail class usage and setup credit to Nam Ha Minh @ Codejava.net
 */
public class PasswordReset extends HttpServlet {
    //database connection variables
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String CONN_STRING = 
            "jdbc:mysql://localhost:3306/car_rental?useSSL=false";
    private static final String TABLE_NAME = "car_rental.renter_info";
    
    //account variables
    private String email;
    private int user_id;
    private String password;
    
    //variables for redirecting user
    private String messageType;
    private String message;
    private String redirectPage;
    
    //Email SMTP variables
    private String host;
    private String port;
    private String senderName;
    private String senderEmail;
    private String senderPass;
    
    //Handle POST method from Password Reset page
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        //capture form entries
        this.email = request.getParameter("email");
        
        if (checkEmail()) {//if the email is registered
            if(changePassword()) {//if password is updated
                messageType = "SystemMessage";
                message = "New password has been sent to your email.</br>Be sure to check your Spam folder.";
                redirectPage = "login.jsp";
            } else { //if password fails to update
                messageType = "ErrorMessage";
                message = "Password did not update successfully. Try again later.";
                redirectPage = "reset_password.jsp";
            }
        } else { //if email is not yet registered
            messageType = "ErrorMessage";
            message = "Email is not registered with an account.";
            redirectPage = "reset_password.jsp";
        }
        redirectUser(request, response, messageType, redirectPage, message);
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
    
    //Checks if supplied email is present in the database as a registered user
    private Boolean checkEmail(){
        Boolean foundEmail = false;
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
            
            //save user's id number
            while (checkEmailReturn.next()) {
                user_id = checkEmailReturn.getInt(1);
                foundEmail = true;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return foundEmail;
    }
    
    //Changes the stored password for the user to random password
    //and sends a copy of it to the user's email
    private Boolean changePassword() {
        //capture return value from SQL query to check if pass was updated
        int updatedRow = 0;
        
        //generate random 6 digit code
        Random rnd = new Random();
        int newPasscode = 100000 + rnd.nextInt(900000);
        password = Integer.toString(newPasscode);
        System.out.println("New password is: " + password);
        
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            //set password to newly generated string and reset failed attempts on account
            String updatePassword = "UPDATE " + TABLE_NAME + " SET password = " + 
                    newPasscode + ", failed_attempts = 0 WHERE id = " + user_id;
            PreparedStatement setNewPassword = conn.prepareStatement(updatePassword);
            updatedRow = setNewPassword.executeUpdate();
            
            //Send the email with new password to user if it works
            if (updatedRow > 0) {
                compileEmail(newPasscode);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return (updatedRow > 0);
    }
    
    //Apply parameters and email content to Javamail Message object
    //and initiate transport of the email
    private void sendEmail(String host, String port, String senderName, String senderEmail,
            String recipientEmail, String subject, String message) throws AddressException, 
            MessagingException, UnsupportedEncodingException {
        
        //set SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.ssl.trust", host); 
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
  
        Session session = Session.getInstance(properties);
  
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
  
        msg.setFrom(new InternetAddress(senderEmail, senderName));
        InternetAddress[] toAddresses = { new InternetAddress(recipientEmail) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setText(message);
        
        // sends the e-mail
        Transport.send(msg, senderEmail, senderPass);
    }
    
    //Set up the parameters and content of the email
    //Gather SMTP parameters from web.xml context-param
    private void compileEmail(int newPasscode) throws AddressException, 
            MessagingException, UnsupportedEncodingException {
        //read the SMTP server settings from web.xml
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        senderEmail = context.getInitParameter("email");
        senderName = context.getInitParameter("name");
        senderPass = context.getInitParameter("pass");
        
        //set the Email contents
        String subject = "Password Reset Confirmation";
        String content = "Hello,\n\n"
                       + "   Your password has been reset for the Car Rental Service project.\n\n"
                       + "   Your new password is " + newPasscode + ".\n\n"
                       + "   Please change your password upon your next login for security purposes.\n\n"
                       + "- Car Rental Service Project";
        try {
            sendEmail(host, port, senderName, senderEmail, email, subject, content);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

