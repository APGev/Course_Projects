
<%-- 
    Document   : faq
    Created on : Dec 11,2020
    Author     : Aferu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <title>FAQ</title>
    </head>
    <body id="faq" bgcolor="#aaa9ad">
        <div id="main">
		     <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
			<h3style="text-align:center"><strong><a name"top"> USER'S GUIDE FREQUENTLY ASKED QUESTIONS</a></strong></h3>

            <p><a href ="#Question1">1. How do I register for new account? </p>
            <p><a href="#Question2"> 2. What if I already registered for account? </p>
            <p><a href="#Question3">3. How to reserve a rental car?</p>
            <p><a href="#Question4">4.How to return rented car?</p>
            <p><a href="#Question5">5.How to extend rental?</p>
            <p><a href="#Question6">6.How to report incident?</p>
    
            <h3><a name="Question1">1.To register for new account: </a></h3>
            <br />1.1 Go to Register User tab.<br />          
            <br />1.2  Enter Username.(Email Address). <br />
            <br />1.3  Enter Password<br />
            <br />1.4  Re enter Password manually. Do not copy and paste.<br />
			<br />1.5  Enter User Information:Last Name, First Name, Driver's License ID Number, and Address in the appropriate fields.<br />
            <br />1.6  Select the Register button.<br />
            <br />1.7  Successfully registered message will be displayed. Else follow the error message and direction displayed.<br />
            <br /><br /><a href="#top">Top Page</a>
            <h3><a name="Question2">2. If you already have an account (Returning customer) :</a></h3>
            <br />2.1  Enter your username(Email address) and password to login.<br />
            <br />2.2. If you forget password, hit forget password and enter associated email to receive  new password. <br />
            <br />2.3  Log in using the new password.<br />
			<br />2.4  Go to Account Setting if you wish to change password.<br />
			<br />2.5  Enter previous password.<br />
			<br />2.6  Enter new password.<br />
			<br />2.7  Confirm new password and select change password.<br />
            <br /><br /><br /><br />
  
            <a href="#top">Top Page</a>
            <h3><a name="Question3">3. To reserve rental car: </a></h3>
            <br />3.1  Log in using your username and password.<br />
            <br />3.2  Go to Make Reservation tab.<br />
            <br />3.3  Select car by Make/Model/ year input fields.<br />
            <br />3.4  Chose the car from the list you wish to reserve.<br />
            <br />3.5  Enter pick up date and time for the rental.<br />
            <br />3.6  Enter return date and time for the rental.<br />
            <br />3.7  Enter the payment information.<br />
            <br />3.8  Select the Reserve button.<br />
            <br /><br />
   
   
            <a href="#top">Top Page</a>
            <h3><a name="Question4">4.To return rented car: </a></h3>
            <br />4.1  Log in using username and password.<br />
            <br />4.2  Go to Return Reservation tab.<br />
            <br />4.3  Select the car you wish to return.<br />
            <br />4.4  Enter the date and time of return.<br />
            <br />4.5  Fill out incident report if needed.<br />           
            <br />4.6  Enter damage charge if significant scratch/damage found .<br />
            <br />4.7  Select the Return Vehicle button. This will finalize the return process.<br />

            <br /><br />
   
            <a href="#top">Top Page</a>
            <h3><a name="Question5">5. To extend rental: </a></h3>
            <br />5.1  Log in using username and password.<br />
            <br />5.2  Go to Return Reservation tab.<br />
            <br />5.3  Select extend rental option.<br />
            <br />5.4  From drop down menu, select the type of status modification you wish to make.<br />
            <br />5.5  Enter the new date and time you wish to return and submit.<br />
            <br />5.6  Rental extension success message will display.<br />
            <br /><br />
   
            <a href="#top">Top Page</a>
            <h3><a name="Question6">6. To report incident: </a></h3>
			<br />6.1  Go to Return Reservation tab .<br />
            <br />6.2  Select the car you wish to report incident. <br />
            <br />6.3  Enter the date and time of incident. <br />
            <br />6.4  Enter brief description of the incident on the field displayed.<br />
            <br />6.5  Enter Category of damage.<br />
            <br />6.5.1  No damage – No additional charge.<br />
            <br />6.5.2  Minor scratch and damage- No additional charge.<br />
            <br />6.5.3  Significant scratch and damage – Damage charge will apply. <br />
            <br />6.5  Select Report button.<br />
            <br /><br />
            <a href="#top">Top Page</a>
 
        </div>
    </body>
</html>