<%-- 
    Document   : logout
    Created on : Nov 18, 2020, 9:51:57 PM
    Author     : Gavin Tichi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            
            
               body{
               background-image: url("login.jpg");
               background-repeat: no-repeat;
               background-attachment: fixed;
               background-position: 50% 50%; 
               background-size: cover;
               background-color:bisque
               
                   
               }
               
     
               
                
    </style>
        <title>Rental Account Log Out</title>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
            <!-- Printing any Error Messages if requested -->
            <% if (request.getAttribute("ErrorMessage") != null) { %>
            <p class="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
            <% } %>
            <!-- Print any System Messages if requested -->
            <% if (request.getAttribute("SystemMessage") != null) { %>
            <p class="systemMsg"><%= (String) request.getAttribute("SystemMessage")%></p>
            <% } %>
            <!-- End the user's session when navigating to logout -->
            <% session.invalidate(); %>
            
            <h2> User has been logged out. </h2>
        </div>
    </body>
</html>