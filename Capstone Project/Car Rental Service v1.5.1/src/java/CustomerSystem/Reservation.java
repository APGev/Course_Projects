package CustomerSystem;

//Exception Import
import java.io.IOException;

//Database Imports
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//Time Imports
import java.time.LocalDate;
import java.time.Duration;

//Servlet Imports
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Reservation extends HttpServlet
{
    //database connection variables
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String CONN_STRING = 
            "jdbc:mysql://localhost:3306/car_rental?useSSL=false";
    private static final String CAR_TABLE = "car_rental.car";
    private static final String CAR_TYPE_TABLE = "car_rental.car_types";
    private static final String CARD_INFO_TABLE = "car_rental.cc_info";
    private static final String RENTAL_INFO_TABLE = "car_rental.rental_information";
    
    //variable for user account session
    private HttpSession session;
    
    //Car Rental form variables
    private int carID;
    private LocalDate pickup;
    private LocalDate dropoff;
    private String cardName;
    private String cardNumber;
    private int cardExpMonth;
    private int cardExpYear;
    
    //User Redirect Variables
    private String message;
    private String messageType;
    private String redirectPage;
    
    //form validation check
    private boolean validForm;
    
    //Rental Vehicle Info
    private String rentalMake;
    private String rentalModel;
    private int rentalYear;
    private int rentalCharge;
    private int rentalDuration;
        
    //Search database and retrieve relevant information for
    //customer to choose a rental vehicle
    public static ResultSet getCarInventory() throws SQLException {
        ResultSet carInventory = null;
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            String checkCars = "SELECT c.id, c.make, c.model, c.year, ct.price_per_day "
                             + "FROM " + CAR_TABLE + " c LEFT JOIN " + CAR_TYPE_TABLE + " ct ON "
                             + "c.car_type_id = ct.id";
            PreparedStatement getCars = conn.prepareStatement(checkCars);
            carInventory = getCars.executeQuery();
        } catch (Exception e) { 
            System.out.println(e);
        } finally {
            return carInventory;
        }
    }
    
    //Handle POST method from Car Rental form with action Reservation
    //Process: Validate the form inputs - 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        session = request.getSession(false);
        //Validate form inputs
        validForm = validateForm(request);
        
        if(validForm) {
            try {
                if(getRentalInfo()) {
                    if (saveRentalInfo()) {
                        message = generateRentalConfirmation();
                        messageType = "SystemMessage";
                        redirectPage = "home.jsp";
                    } else {
                        message = "Error saving rental data. Try again later.";
                        messageType = "ErrorMessage";
                        redirectPage = "reservation.jsp";
                    }
                } else {
                    message = "Error gathering rental data. Try again later.";
                    messageType = "ErrorMessage";
                    redirectPage = "reservation.jsp";
                }
            } catch (Exception e) {
                        System.out.println(e);
            }
        } else {
            message = "Form input(s) invalid. Correct all fields and resubmit.";
            messageType = "ErrorMessage";
            redirectPage = "reservation.jsp";
        }
        redirectUser(request,response,messageType,redirectPage,message);
    }
    
    //Add rental information to the database
    private Boolean saveRentalInfo() {
        int savedCardInfo = 0;
        int savedRentalInfo = 0;
        
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            
            //Set up SQL INSERT for Credit Card Info
            String cardInsertQuery = "INSERT INTO " + CARD_INFO_TABLE + " ("
                    + "cc_name,"
                    + "cc_number,"
                    + "cc_exp_month,"
                    + "cc_exp_year) VALUES ("
                    + "?, ?, ?, ?)";
            PreparedStatement addCardInfo = conn.prepareStatement(cardInsertQuery);
            addCardInfo.setString(1, cardName);
            addCardInfo.setString(2, cardNumber);
            addCardInfo.setInt(3,cardExpMonth);
            addCardInfo.setInt(4,cardExpYear);
            
            //After assigning variables, execute Card Insert query
            savedCardInfo = addCardInfo.executeUpdate();
            
            System.out.println("Card Info Status: " + savedCardInfo);
            //Set up SQL INSERT for Rental Info
            String rentalInsertQuery = "INSERT INTO " + RENTAL_INFO_TABLE + " ("
                    + "renter_id,"
                    + "cc_info_id,"
                    + "car_id,"
                    + "rental_time,"
                    + "rental_location,"
                    + "rental_type,"
                    + "rental_return_date,"
                    + "rental_return_status) VALUES ("
                    + "?, LAST_INSERT_ID(), ?, NOW(), 'None', 1, ?, 1)";
            PreparedStatement addRentalInfo = conn.prepareStatement(rentalInsertQuery);
            addRentalInfo.setInt(1, (int) session.getAttribute("user_id"));
            addRentalInfo.setInt(2, carID);
            addRentalInfo.setInt(3, rentalDuration);
            
            //After assigning variables, execute Rental Insert query
            savedRentalInfo = addRentalInfo.executeUpdate();
            
            System.out.println("Rental Info Status: " + savedRentalInfo);
        } catch (Exception e) {
            System.out.println(e);
        }
        
        return ((savedCardInfo > 0) && (savedRentalInfo > 0));
    }
    
    //Read vehicle data and generate output message to confirm
    //vehicle rental with customer
    private Boolean getRentalInfo() throws SQLException {
        Boolean gotRentalInfo = false;
        
        try {
            // load and register JDBC driver for MySQL - 
            // This tells the Java Class where to find the driver to connect to 
            // The MySQL Database
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection(CONN_STRING,USERNAME,PASSWORD);
            String searchCarInfo = "SELECT c.make, c.model, c.year, ct.price_per_day "
                             + "FROM " + CAR_TABLE + " c LEFT JOIN " + CAR_TYPE_TABLE + " ct ON "
                             + "c.car_type_id = ct.id WHERE c.id = ?";
            PreparedStatement getCarInfo = conn.prepareStatement(searchCarInfo);
            getCarInfo.setInt(1, carID);
            ResultSet carInfo = getCarInfo.executeQuery();
            
            while (carInfo.next()) {
                rentalMake = carInfo.getString(1);
                rentalModel = carInfo.getString(2);
                rentalYear = carInfo.getInt(3);
                rentalCharge = calculateCharge(carInfo.getInt(4));
                
                gotRentalInfo = true;
            }
            
        } catch (Exception e) { 
            System.out.println(e);
        }
        
        return gotRentalInfo;
    }
    
    //Calculate the total cost of the car rental given the daily cost
    private int calculateCharge(int dailyCost) {
        Duration rentalTime = Duration.between(pickup.atStartOfDay(), dropoff.atStartOfDay());
        rentalDuration = (int) rentalTime.toDays();
        
        return (rentalDuration * dailyCost);
    }
    
    //Create the message for confirming the rental transaction
    private String generateRentalConfirmation() {
        String confirmationMessage = "";
        
        confirmationMessage = "Thank you for using the Car Rental Service! </br>"
                            + "Your rental of the " + rentalYear + " " + rentalMake
                            + " " + rentalModel + " has been booked for " + rentalDuration
                            + " days, from " + pickup + " to " + dropoff + "!</br></br>"
                            + "The total for your rental comes out "
                            + "to $" + rentalCharge +". </br></br>Your card will be charged upon pickup "
                            + "of your new rental. Drive safely!";
        
        return confirmationMessage;
    }
    
    //Check each input in the form and validate the inputs
    private Boolean validateForm(HttpServletRequest request) {
        //return variable
        Boolean validatedForm = true;
        
        //retrieve form input from POST request
        String tempCar = request.getParameter("car");
        String pickupDate = request.getParameter("pickup");
        String dropoffDate = request.getParameter("dropoff");
        this.cardName = request.getParameter("cardName");
        cardNumber = request.getParameter("cardNum");
        String tempCardExpMonth = request.getParameter("cardExpMonth");
        String tempCardExpYear = request.getParameter("cardExpYear");
        
        //Validate Car ID input
        if (tempCar.equals("")) {
            validForm = false;
            request.setAttribute("carError", "Car ID Number must not be blank.");
        } else {
            carID = Integer.parseInt(tempCar);
            if ((carID < 1) || (carID > 89)) {
                validForm = false;
                request.setAttribute("carError", "Car ID must be between 1-89");
            }
        } 
        
        //Validate Pick Up and Drop Off Dates
        if (pickupDate.equals("")) {
            validForm = false;
            request.setAttribute("pickupError", "You must select a date to pick up the rental.");
        } else {
            pickup = LocalDate.parse(pickupDate);
        }
        
        if (dropoffDate.equals("")) {
            validForm = false;
            request.setAttribute("dropoffError", "You must select a date to return the rental.");
        } else {
            dropoff = LocalDate.parse(dropoffDate);
        }
        
        if ((pickup != null) && (dropoff != null)) {
            if ((pickup.isEqual(dropoff)) || (pickup.isAfter(dropoff))) {
                validForm = false;
                request.setAttribute("pickupError", "The pickup date must be before the dropoff date.");
                request.setAttribute("dropoffError", "The dropoff date must be after the pickup date.");
            }
        }
        
        //Validate Credit Card information
        if (cardName.equals("")) {
            validForm = false;
            request.setAttribute("cardNameError", "Name on credit card must not be blank.");
        }
        
        //Card number must be a 16 digit long input
        if (cardNumber.equals("")) {
            validForm = false;
            request.setAttribute("cardNumError", "You must enter your 16 digit credit card number.");
        } else if (cardNumber.length() != 16) {
            validForm = false;
            request.setAttribute("cardNumError", "Your credit card number must be 16 digits long.");
        } 
        
        //Expiration month must be between 1-12
        if (tempCardExpMonth.equals("")) {
            validForm = false;
            request.setAttribute("cardExpMonthError", "You must enter your card's expiration month.");
        } else {
            cardExpMonth = Integer.parseInt(tempCardExpMonth);
            if (cardExpMonth > 12 || cardExpMonth < 1) {
                validForm = false;
                request.setAttribute("cardExpMonthError", "You must enter a valid month 1-12.");
            }
        }
        
        //Expiration year must be greater than 2020
        if (tempCardExpYear.equals("")) {
            validForm = false;
            request.setAttribute("cardExpYearError", "You must enter your card's expiration year.");
        } else {
            cardExpYear = Integer.parseInt(tempCardExpYear);
            if (cardExpYear < 2020) {
                validForm = false;
                request.setAttribute("cardExpYearError", "You must enter a valid year of at least 2020.");
            }
        }
        return validatedForm;
    }        
    
    //accept the HttpServletRequest/Response objects and a custom message to send the
    //user back to the registration form with the new error message
    //same class as in Registration due to issues with imports (???)
    private void redirectUser(HttpServletRequest request, HttpServletResponse response,
            String messageType, String targetPage, String error) 
            throws ServletException, IOException {
        //assign message to request
        request.setAttribute(messageType, error);
        
        //push user back to registration form with the error message included
        RequestDispatcher dispatcher = request.getRequestDispatcher(targetPage);
        dispatcher.forward(request,response);
    }
}


/*
Code Plan if Eric doesn't deliver:

Validate form inputs as described in method

Get Car Information from DB for output

Get Pricing Calculation from DB for output

Insert CC information into DB

Insert Rental Information into DB

E.G. 
INSERT INTO car_rental.cc_info (`cc_name`, `cc_number`, `cc_exp_month`, `cc_exp_year`) VALUES ('Test Card', 1234567890, 01, 23);

INSERT INTO car_rental.rental_information (`renter_id`, `cc_info_id`, `car_id`, `rental_time`, `rental_location`, `rental_type`, `rental_return_date`, `rental_return_status`) VALUES 
(3, 1, 1, NOW(), 'Test Location', 1, 1, 0);

Output confirmation message to user at home

Maybe send confirmation email as well?
*/