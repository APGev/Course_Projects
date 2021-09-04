/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomerSystem;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServlet;
//Database Imports
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Pro-J
 */
public class CarReturn extends HttpServlet {
    //database connection variables
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String CONN_STRING = 
            "jdbc:mysql://localhost:3306/car_rental?useSSL=false";
    private static final String TABLE_NAME = "car_rental.rental_information";
    private static final String RENTER_TABLE = "car_rental.renter_info";
    private static final String INCIDENTS = "car_rental.incident_reports";

    // Variable
    private HttpSession session;
    // Database field data
    private String renterName;
    private String rentalType;
    private String rental_return_date;
    private String carID;
    private String carIDin;
    private int email_id;
    private int renter_id;
    private boolean regExists;
    
    //Session variables
    private int user_id;
    private String user_email;
    
    // input validation variables
    private static Pattern input_match =
        Pattern.compile("^[a-zA-Z0-9]{1,15}$");
    private static Matcher inputMatch;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        session = request.getSession(true);
        
        if (session.getAttribute("email") == null) {
            // Send back to login page 
            response.sendRedirect("login.jsp");
        } else {
            //Get Session Data (User ID and Email)
            user_id = (int) session.getAttribute("user_id");
            user_email = (String) session.getAttribute("email");
            
            // Connect to the Database and pull the data
            getData();
            // Set the Attribute for viewing in the JSP
            request.setAttribute("renterName", renterName);
            request.setAttribute("rentalType", rentalType);
            request.setAttribute("carID", carID);
            request.setAttribute("renterID", renter_id);
            request.setAttribute("returndate", rental_return_date);
            
            //Set session variables for the extend page
            session.setAttribute("carID", carID);
            session.setAttribute("returndate", rental_return_date);
            
            // check registration
            carIDin = request.getParameter("carIDin");
            boolean inputValid = validateInput(carIDin);
            
            regExists = false;
            if (inputValid) {
                regExists = checkRegistration(renter_id, carIDin);
            }            
            
            if (!regExists) {
                // if registration does not exist
                carID = null;
                request.setAttribute("ErrorMessage", "Invalid or no reservations. Try again.");
                RequestDispatcher tryAgain = request.getRequestDispatcher("return.jsp");
                tryAgain.forward(request, response);
            } else {
                // if registration exists return vehicle
                returnRental(carIDin);
                // get incident report
                int damage = Integer.parseInt(request.getParameter("damageinput"));
                String location = request.getParameter("locationinput");
                incidentReport(renter_id, damage, location);
                request.setAttribute("carID", carIDin);

                // return to home page
                RequestDispatcher goHome = request.getRequestDispatcher("home.jsp");
                request.setAttribute("SystemMessage", "Reservation returned.");
                goHome.forward(request, response);
            }
        }
    }
  
            
    // verifies reservation exist in database
    boolean checkRegistration(int renterID, String tagInput) {
        boolean tagSearch = false;
        try {
            // connection stuff
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            // Check if renter exists in reservations
            String searchRentalInfo = "SELECT renter_id FROM " + TABLE_NAME + " WHERE renter_id = ?";
            PreparedStatement checkInfo = conn.prepareStatement(searchRentalInfo);
            checkInfo.setInt(1, renterID);
            ResultSet checkRentalInfo = checkInfo.executeQuery();
            
            // gets id for rental info
            while (checkRentalInfo.next()){
                renter_id = checkRentalInfo.getInt(1);
            }
            // if the renter exists check if tag exists
            if (renter_id > 0) {
                String searchTag = "select renter_id from " + TABLE_NAME + " where renter_id = ? and car_id = ?";
                PreparedStatement checkTag = conn.prepareStatement(searchTag);
                checkTag.setInt(1, renter_id);
                checkTag.setString(2, tagInput);
                ResultSet checkTagReturn = checkTag.executeQuery();
                
                int matches = 0;
                
                // check if this user has this tag
                while (checkTagReturn.next()){
                    matches++;
                }
                // if the tag exists
                if(matches > 0) {
                        tagSearch = true;
                    } 
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return tagSearch;
    }

    // input validation
    boolean validateInput(String userInput) {
        inputMatch = input_match.matcher(userInput);
        return inputMatch.matches();
    }
    
    // removes car from rental_information
    private void returnRental(String tagInput){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            String deleteTag = "DELETE FROM " + TABLE_NAME + " where car_id = ?";
            PreparedStatement returnTag = conn.prepareStatement(deleteTag);
            returnTag.setString(1, tagInput);
            returnTag.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        } 
        
    }
    
    // gets incident report information and updates database
    private void incidentReport(int rentalID, int damageType, String location){
     String charge = "Pending review.";
      try {
              Class.forName("com.mysql.jdbc.Driver");
              Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
              String insertReport = "INSERT INTO " + INCIDENTS + " (rental_information_id, damage_type_id, damage_location, damage_charge) VALUES (?,?,?,?)";
              //String insertReport = "INSERT into (`rental_information_id`, `damage_type_id`, `damage_location`, `damage_charge`) " + TABLE_NAME + " VALUES (?,?,?,?)";
              PreparedStatement insert = conn.prepareStatement(insertReport);
              insert.setInt(1, rentalID);
              insert.setInt(2, damageType);
              insert.setString(3, location);
              insert.setString(4, charge);
              insert.executeUpdate();
          } catch (Exception e) {
              System.out.println(e);
          }      
    }
        
    private void getData() {

        try {     
            // connection variables
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            // sql
            String getInfo = "select rental_type, car_id, renter_id, rental_return_date FROM " + TABLE_NAME+" where renter_id = ?";
            String get_id = "SELECT id, first_name FROM " + RENTER_TABLE + " WHERE email = ?";
            
            //Prepared Statements       
            
            PreparedStatement userInfo = conn.prepareStatement(get_id);
            userInfo.setString(1, user_email);
            ResultSet rsUserInfo = userInfo.executeQuery();
            
            // Assign values
            while (rsUserInfo.next()) {
                email_id = rsUserInfo.getInt(1);
                renterName = rsUserInfo.getString(2);
            }
            
            PreparedStatement rentalInfo = conn.prepareStatement(getInfo);
            rentalInfo.setInt(1,email_id);
            ResultSet rsRentalInfo = rentalInfo.executeQuery();
            //Consider making this loop save the data to an array or list
            //in the event that a user has more than one rental (if our app
            //is allowing that)
            while (rsRentalInfo.next()) {
                rentalType = rsRentalInfo.getString(1);
                carID = rsRentalInfo.getString(2);
                renter_id = rsRentalInfo.getInt(3);
                rental_return_date = rsRentalInfo.getString(4);
            }
        } catch (Exception e) {
            System.out.println(e);
        }

    }
    
}
