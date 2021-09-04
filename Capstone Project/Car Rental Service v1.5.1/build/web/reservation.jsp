<%-- 
    Document   : MakeReservation
    Created on : Dec 10, 2020, 2:54:56 PM
    Author     : apgav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="CustomerSystem.Reservation" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <style type="text/css">
               body{
               background-image: url("reservation.jpeg");
               background-repeat: no-repeat;
               background-attachment: fixed;
               background-position: 80% 20%; 
               background-size: cover;
               background-color:bisque
               }
         </style>
         <title>Make Car Reservation</title>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
        
            <% if (session.getAttribute("email") == null) {
                request.setAttribute("ErrorMessage","You must be logged in to make "
                                    +"a reservation.");
                RequestDispatcher dispatch = request.getRequestDispatcher("login.jsp");
                dispatch.forward(request,response);
            } %>
            <!-- Printing any Error Messages if requested -->
            <% if (request.getAttribute("SystemMessage") != null) { %>
            <p class="systemMsg"><%= (String) request.getAttribute("SystemMessage")%></p>
            <% } %>

            <% if (request.getAttribute("ErrorMessage") != null) { %>
            <p class="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
            <% } %>
            
            <h2>Rent a car</h2>
            
            <!--Get a list of all the cars and their relevant
            info to display for the rental form-->
            <%
                ResultSet carInventory = Reservation.getCarInventory();
            %>
            
            
            <!-- Container for displaying list of cars -->
            <div id="car-container">
                <div id="scrollable-content">
                    <table class="list">
                        <tr id="header">
                            <td>Car ID</td>
                            <td>Make</td>
                            <td>Model</td>
                            <td>Year</td>
                            <td>Daily $</td>
                        </tr>
                            <%
                                while (carInventory.next()) {
                                    int car_id = carInventory.getInt(1);
                                    String make = carInventory.getString(2);
                                    String model = carInventory.getString(3);
                                    int year = carInventory.getInt(4);
                                    int daily_price = carInventory.getInt(5);
                                    %>      
                                    <tr>
                                        <td><%=car_id%></td>
                                        <td><%=make%></td>
                                        <td><%=model%></td>
                                        <td><%=year%></td>
                                        <td><%=daily_price%></td>
                                    </tr>
                            <%  }  %>
                    </table>
                </div>
            </div>
            <form action="Reservation" method="POST">
                <fieldset>
                    <legend>Car Rental Form</legend>
                    <table class="form">
                        <tr>
                            <td><label for="car">Car Selection (ID Number):</label></td>
                            <td><input type="number" id="car" name="car" min="1" max="89"></td>
                            <% if (request.getAttribute("carError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("carError") %>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="pickup">Pick Up Date:</label></td>
                            <td><input type="date" id="pickup" name="pickup"></td>
                            <% if (request.getAttribute("pickupError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("pickupError") %>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="dropoff">Drop Off Date:</label></td>
                            <td><input type="date" id="dropoff" name="dropoff"></td>
                            <% if (request.getAttribute("dropoffError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("dropoffError") %>
                            <% } %>
                        </tr>
                    </table>
                </fieldset>
                <fieldset>
                    <legend>Credit Card Information:</legend>
                    <table class="form">
                        <tr>
                            <td><label for="cardName">Name on Credit Card:</label></td>
                            <td><input type="text" id="cardName" name="cardName"></td>
                            <% if (request.getAttribute("cardNameError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("cardNameError") %>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="cardNum">Credit Card Number:</label></td>
                            <td><input type="number" id="cardNum" name="cardNum"></td>
                            <% if (request.getAttribute("cardNumError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("cardNumError") %>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="cardExpMonth">Credit Card Expiration Month:</label></td>
                            <td><input type="number" id="cardExpMonth" name="cardExpMonth" min="01" max="12"></td>
                            <% if (request.getAttribute("cardExpMonthError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("cardExpMonthError") %>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="cardExpYear">Credit Card Expiration Year:</label></td>
                            <td><input type="number" id="cardExpYear" name="cardExpYear" min="2020"></td>
                            <% if (request.getAttribute("cardExpYearError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("cardExpYearError") %>
                            <% } %>
                        </tr>
                    </table>
                </fieldset>
                <input type="submit" value="Reserve Car Rental">
            </form>
        </div>
    </body>
</html>
