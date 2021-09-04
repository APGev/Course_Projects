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
import javax.servlet.RequestDispatcher;

//Database Imports
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

//RegEx Imports
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author Gavin Tichi
 */

public class Registration extends HttpServlet {
    //database connection variables
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String CONN_STRING = 
            "jdbc:mysql://localhost:3306/car_rental?useSSL=false";
    private static final String TABLE_NAME = "car_rental.renter_info";
    
    //variables for capturing registration form
    private String email;
    private String password;
    private String confirmPass;
    private String fname;
    private String lname;
    private String licenseID;
    private String phoneNumber;
    private String streetAdd;
    private String cityAdd;
    private String stateAdd;
    private String zipCode;
    
    //input validation check variable
    private Boolean completeForm;
    
    //Password Requirement RegEx
    private static final String PASSWORD_REGEX = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&+=])(?=\\S+$).{8,}$";
    
    //Handle POST method from Registration form with action Registration
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        //variables for redirecting user to next page
        String message;
        String messageType;
        String redirectPage;
        
        //check if form is filled out properly
        completeForm = validateForm(request);
        
        //if inputs are valid
        if(completeForm) {
            if (userExists()) {
            //set error message for pre-existing user
            message = "This email is already associated with an account.";
            messageType = "ErrorMessage";
            redirectPage = "registration.jsp";
            } else if(updateCustomerDatabase()){//if all conditions for the form pass
                message = "New account created with username: " + email;
                messageType = "SystemMessage";
                redirectPage = "home.jsp";
            } else { //if DB does not successfullly update
                message = "Error creating account. Try again later.";
                messageType = "ErrorMessage";
                redirectPage = "registration.jsp";
            }
        } else {
            //set the error messsage for incompete form and return to form
            message = "Form is incomplete. Correct all fields and resubmit.";
            messageType = "ErrorMessage";
            redirectPage = "registration.jsp";
        }
        redirectUser(request, response, messageType, redirectPage, message); 
    }
    
    //check each form entry and validate
    private Boolean validateForm(HttpServletRequest request) {
        //return variable for if form inputs are valid
        Boolean validForm = true;
        
        //retrieve form entries from POST method
        this.email = request.getParameter("email");
        this.password = request.getParameter("pass");
        this.confirmPass = request.getParameter("confirmPass");
        this.fname = request.getParameter("fname");
        this.lname = request.getParameter("lname");
        this.licenseID = request.getParameter("licenseID");
        this.phoneNumber = request.getParameter("phoneNumber");
        this.streetAdd = request.getParameter("streetAdd");
        this.cityAdd = request.getParameter("cityAdd");
        this.stateAdd = request.getParameter("stateAdd");
        this.zipCode = request.getParameter("zipCode");
        
        //for proper input validation of each field
        if(email.equals("")) {
            validForm = false;
            request.setAttribute("emailError","Email must not be blank.");
        }
        
        //check if password field is empty first, then validate for the password rules
        Pattern passwordRegEx = Pattern.compile(PASSWORD_REGEX);
        Matcher passwordCheck = passwordRegEx.matcher(password);
        if(password.equals("")) {
            validForm = false;
            request.setAttribute("passwordError","Password must not be blank.");
        } else if (!passwordCheck.matches()) {
            validForm = false;
            request.setAttribute("passwordError","Password must contain at least 8 characters,</br>"
                                                +"an upper case and lower case letter, a number,</br>"
                                                +"a special character, and no whitespace.");
        }
        
        if(confirmPass.equals("")) {
            validForm = false;
            request.setAttribute("confirmPasswordError","Password confirmation must not be blank.");
        } else if(!password.equals(confirmPass)) {
            validForm = false;
            request.setAttribute("confirmPasswordError","Passwords must match.");
        }
        
        if(fname.equals("")) {
            validForm = false;
            request.setAttribute("fnameError","First name must not be blank.");
        }
        if(lname.equals("")) {
            validForm = false;
            request.setAttribute("lnameError","Last name must not be blank.");
        }
        if(licenseID.equals("")) {
            validForm = false;
            request.setAttribute("licenseError","License ID Number must not be blank.");
        }
        if(phoneNumber.equals("")) {
            validForm = false;
            request.setAttribute("phoneError","Phone number must not be blank.");
        }
        if(streetAdd.equals("")) {
            validForm = false;
            request.setAttribute("streetError","Street Address must not be blank.");
        }
        if(cityAdd.equals("")) {
            validForm = false;
            request.setAttribute("cityError","City must not be blank.");
        }
        if(stateAdd.equals("None")) {
            validForm = false;
            request.setAttribute("stateError","You must choose a State from the list.");
        }
        if(zipCode.equals("")) {
            validForm = false;
            request.setAttribute("zipError","ZIP Code must not be blank.");
        }
        return validForm;
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
    
    //check if the email input in the registration form already exists
    //as a user in the database - do not allow multiple users with same email
    private Boolean userExists() {
        //return variable for if the email is already taken
        Boolean usernameTaken = false;
        
        //connect to database
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);

            //set up SQL query
            String searchForEmail = "SELECT 1 FROM " + TABLE_NAME + " WHERE email = ?";
            PreparedStatement checkForEmail = conn.prepareStatement(searchForEmail);
            checkForEmail.setString(1,email);
            ResultSet emailMatch = checkForEmail.executeQuery();

            //check if there were any matches for that email in the database
            while (emailMatch.next()) {
                usernameTaken = true;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return usernameTaken;
    }
    
    //given that the information in the form fields is valid, push the info
    //into the database as a new customer
    private Boolean updateCustomerDatabase() {
        //return value for capturing number of updated rows 
        //from our DB Query to check if update was successful
        int successfulUpdate = 0;
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            //set up SQL statement for Customer info
            String customerInsertQuery = "INSERT INTO " + TABLE_NAME + " (" 
                    + "email,"
                    + "first_name,"
                    + "last_name,"
                    + "licence_number,"
                    + "street_address,"
                    + "city,"
                    + "state,"
                    + "zip_code,"
                    + "phone_number,"
                    + "failed_attempts,"
                    + "password) VALUES ("
                    + "?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?)";
            PreparedStatement addCustomerInfo = conn.prepareStatement(customerInsertQuery);
            addCustomerInfo.setString(1, email);
            addCustomerInfo.setString(2, fname);
            addCustomerInfo.setString(3, lname);
            addCustomerInfo.setString(4, licenseID);
            addCustomerInfo.setString(5, streetAdd);
            addCustomerInfo.setString(6, cityAdd);
            addCustomerInfo.setString(7, stateAdd);
            addCustomerInfo.setString(8, zipCode);
            addCustomerInfo.setString(9, phoneNumber);
            addCustomerInfo.setString(10, password);
            
            //after assigning all variables, push the updates to the system
            successfulUpdate = addCustomerInfo.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return (successfulUpdate > 0);
    }
}
