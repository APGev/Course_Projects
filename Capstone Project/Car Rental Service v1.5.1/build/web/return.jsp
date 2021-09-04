<%-- 
    Document   : return
    Created on : Dec 1, 2020, 3:10:18 PM
    Author     : Jasmine Simpson
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            
            
               body{
               background-image: url("return.jpg");
               background-repeat: no-repeat;
               background-attachment: fixed;
               background-position: 80% 20%; 
               background-size: cover;
               background-color:bisque
               
                   
               }
                    
                
    </style>
        <title>Return Vehicle Page</title>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
            <h1>Return Reservation</h1>
             <% if (session.getAttribute("email") == null) {
                    // Send back to login page 
                    response.sendRedirect("login.jsp"); %>
            <% } else {%>
                <% if (session.getAttribute("email") != null) { %>
                    <h4> Logged in as <%= (String) session.getAttribute("email")%></h4>  
                    <% } %>

                <% if (request.getAttribute("SystemMessage") != null) { %>
                <p id="systemMsg"><%= (String) request.getAttribute("SystemMessage")%></p>
                <% } %>

                <% if (request.getAttribute("ErrorMessage") != null) { %>
                <p id="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
                <% } %>

                <%-- Gather the data from the servlet if it is not null.
                     Otherwise, set it to some base value to display. --%>
                <% 
                    String car_ID;
                    
                    if (request.getAttribute("carID") != null) {
                        car_ID = (String) request.getAttribute("carID");
                    } else {
                        car_ID = "No reservations found";
                    }
                %>
                
                <h6>Click Return Vehicle with no other other inputs to </br>
                    get the Tag # of the Vehicle you currently have rented.</h6>
                    
                </h6>
                <form action="CarReturn" method="POST">
                    <table class="center">
                        <tr>
                            <td>Current Tag Reserved:</td>
                            <td><input type="text" name="carID" value="<%= car_ID%>" size="40" readOnly></td>
                        </tr>
                        <tr>
                            <td>Enter Car TAG to Return: </td>
                            <td><input type="text" name="carIDin" size="40" autocomplete="off"></td>
                        </tr>
                        <tr>
                            <td>Incident Report:</td>
                            <td><select name="damageinput">
                                <option value="1">No Damage to Report</option>
                                <option value="2">Minor Damage</option>
                                <option value="3">Significant Damage</option>
                                </select>
                            </td>
                        </tr>  
                        <tr>
                            <td>Location of Damage: </td>
                            <td><input type="text" name="locationinput" size="40" autocomplete="off"></td>
                        </tr>                 
                        <tr>
                            <% if (request.getAttribute("carID") != null) { %>
                            <td><a href="extend.jsp">Extend Reservation?</a></td>
                            <% } else { %>
                            <td></td>
                            <% } %>
                            <td><input type="submit" name="return" value="Return Vehicle"></td>
                        </tr>
                    </table>
                </form>
            <% }%>
        </div>
    </body>
</html>
