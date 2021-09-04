<%-- 
    Document   : login
    Created on : Nov 18, 2020, 9:15:48 PM
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
        <title>Rental Account Login</title>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
            
            <!-- Display Login Form if Session has not been created -->
            <% if (session.getAttribute("email") == null) { %>
            <h2>Log In</h2>
            <form action="Authentication" method="POST">
                <table class="form">
                    <tr>
                        <td> Email Address:</td>
                        <td><input type="text" name="email" size="40" autofocus></td>
                    </tr>
                    <tr>
                        <td> Password: </td>
                        <td><input type="password" name="pass" size="40" autocomplete="off"></td>
                    </tr>
                    <tr>
                        <td><a href="reset_password.jsp">Forgot Password?</a></td>
                        <td><input type="submit" name="login" value="Log In"></td>
                    </tr>
                </table>
                <br>
                
                <!-- Printing any Error Messages if requested -->
                <% if (request.getAttribute("SystemMessage") != null) { %>
                <p class="systemMsg"><%= (String) request.getAttribute("SystemMessage")%></p>
                <% } %>

                <% if (request.getAttribute("ErrorMessage") != null) { %>
                <p class="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
                <% } %>
            </form>
            <!-- If user is already logged in and tries to access login page -->
            <% 
                } else {
                    request.setAttribute("ErrorMessage", "You are already logged in");
                    RequestDispatcher dispatch = request.getRequestDispatcher("home.jsp");
                    dispatch.forward(request, response);
                } %>
        </div>
    </body>
</html>
