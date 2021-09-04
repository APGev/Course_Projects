<%-- 
    Document   : extend
    Created on : Dec 1, 2020, 3:10:18 PM
    Author     : Jasmine Simpson
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <title>Extend Reservation Page</title>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
        <h1>Extend Reservation</h1>
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
        
        <%-- Check if null first! --%>
        <%
            String old_date;
            String carID;
            
            if(session.getAttribute("returndate") != null) {
                old_date = (String) session.getAttribute("returndate");
            } else {
                old_date = "No rental info found";
            }
            
            if(session.getAttribute("carID") != null) {
                carID = (String) session.getAttribute("carID");
            } else {
                carID = "No rental info found";
            }
        %>

        <form action="Extend" method="POST">
            <table class="center">
                <tr>
                    <td>Car TAG Reserved:</td>
                    <td><input type="text" name="carID" value="<%= carID%>" size="40" readOnly></td>
                </tr>
                <tr>
                    <td>Old Return Date: </td>
                    <td><input type="text" name="returndate" value="<%= old_date%>" size="40" readOnly></td>
                </tr>
                <tr>
                    <td>New Return Date:</td>
                    <td><input type="text" name="newreturndate" size="40" autofocus></td>
                </tr>
                <tr>
                    <td><a href="return.jsp">Previous Page?</a></td>
                    <td><input type="submit" name="extend" value="Extend Reservation"></td>
                </tr>
            </table>
        </form>
        <% }%>
        </div>
    </body>
</html>
