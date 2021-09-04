<%-- 
    Document   : home
    Created on : Nov 20, 2020, 1:02:16 PM
    Author     : apgav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            
            
               body{
               background-image: url("background.jpg");
               background-repeat: no-repeat;
               background-attachment: fixed;
               background-position: 50% 50%; 
               background-size: cover;
               background-color:bisque
               
                   
               }
               
     
               
                
    </style>
    
    
        <title>Car Rental System Home</title>
    </head>
    <body>
        <style type="text/css">
               h1 {
                 color: black;
                 font-style: italic;
                 font-size: 400%;
                }
        
            
            </style>
        
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
            
            <h1>Welcome!</h1>
            
            <% if (session.getAttribute("email") != null) { %>
            <h2> Logged in as <%= (String) session.getAttribute("email")%></h2>
            <% } %>
            
            <% if (request.getAttribute("SystemMessage") != null) { %>
            <p class="systemMsg"><%= (String) request.getAttribute("SystemMessage")%></p>
            <% } %>
            
            <% if (request.getAttribute("ErrorMessage") != null) { %>
            <p class="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
            <% } %>
            
            <% if (session.getAttribute("email") != null) { %>
            <p>Use the above menu options to use the Rental Service.</p>
            <% }  else { %>
            <p>Register or login to start </p>
            <% } %>
        </div>
    </body>
</html>
