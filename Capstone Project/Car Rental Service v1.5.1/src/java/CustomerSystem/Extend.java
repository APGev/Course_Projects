/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomerSystem;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
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
public class Extend extends HttpServlet{
        //database connection variables
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String CONN_STRING = 
            "jdbc:mysql://localhost:3306/car_rental?useSSL=false";
    private static final String TABLE_NAME = "car_rental.rental_information";
    private static final String CARTYPES_TABLE = "car_rental.car_types";
    // Variable
    private HttpSession session;
    // Database field data
    private String carID;
    private int renter_id;
    private String new_return_date;
    private String rental_return_date;
    private boolean regExists;
    private int setPrice;
    private int setTime;
    private int charge;
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        session = request.getSession(true);
        
        if (session.getAttribute("email") == null) {
            // Send back to login page 
            response.sendRedirect("login.jsp");
        } else {     
            this.renter_id = (int) session.getAttribute("user_id");
            this.carID = request.getParameter("carID");
            this.rental_return_date = request.getParameter("returndate");
            this.new_return_date = request.getParameter("newreturndate");
            
            System.out.println("Parameters: " + this.renter_id + " / " + this.carID);
            this.regExists = checkRegistration(this.renter_id, this.carID);
            
            if (!regExists){
                // if registration does not exist
                request.setAttribute("ErrorMessage", "Invalid or no reservations. Try again.");
                RequestDispatcher tryAgain = request.getRequestDispatcher("extend.jsp");
                tryAgain.forward(request, response);
            
            } else {
                // if registration exists extend to a new rental date
                extendRental(this.carID, this.new_return_date);
                // calculate additional charge
                int price = calculateCharge(this.renter_id, this.rental_return_date, this.new_return_date);
                
                // return to home page
                RequestDispatcher goHome = request.getRequestDispatcher("home.jsp");
                request.setAttribute("SystemMessage", "Reservation extended. Additional Price: $" + price);
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
            System.out.println("Renter id: " + renter_id);
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
                    System.out.println("Tag Search match");
                } 
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return tagSearch;
    }
    
    // enters new date and time of return
    void extendRental(String tagInput, String newDate){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            String deleteTag = "UPDATE " + TABLE_NAME + " SET rental_return_date = ? where car_id = ?";
            PreparedStatement returnTag = conn.prepareStatement(deleteTag);
            returnTag.setString(1, newDate);
            returnTag.setString(2, tagInput);
            returnTag.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        } 
    }
    
// queries payment info of user and displays charges
   int calculateCharge(int rentalType, String oldDate, String newDate){
      try {
              Class.forName("com.mysql.jdbc.Driver");
              Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
              String pricePerDay = "SELECT price_per_day FROM " + CARTYPES_TABLE + " WHERE id = ? ";
              String getTimeDiff = "SELECT timestampdiff(DAY, '" + oldDate + "', '" + newDate + "')";
              PreparedStatement getPrice = conn.prepareStatement(pricePerDay);
              PreparedStatement getTime = conn.prepareStatement(getTimeDiff);
              getPrice.setInt(1, rentalType);
              //getTime.setString(1, oldDate);
              //getTime.setString(2, newDate);
             ResultSet rsPrice = getPrice.executeQuery();
             ResultSet rsTime = getTime.executeQuery();
             while (rsPrice.next()) {
               setPrice = rsPrice.getInt(1);
             }
             while (rsTime.next()) {
               setTime = rsTime.getInt(1);
             }
             
             charge = setTime * setPrice;
             
          } catch (Exception e) {
              System.out.println(e);
          }
      return charge;
    }
    
}

