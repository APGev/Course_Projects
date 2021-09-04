<%-- 
    Document   : reset_password
    Created on : Nov 20, 2020, 4:09:21 PM
    Author     : apgav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <title>Password Reset</title>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
            
            <p>Enter the email address associated with your account to reset the
                password and receive the new password in an email.</p>
            <form action="PasswordReset" method="POST">
                <table class="form">
                    <tr>
                        <td>Email:</td>
                        <td><input type="email" name="email" autofocus></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Send new password via Email"></td>
                    </tr>
                </table>
            </form>
            <!-- Printing any messages if requested -->
            <% if (request.getAttribute("SystemMessage") != null) { %>
            <p class="systemMsg"><%= (String) request.getAttribute("SystemMessage")%></p>
            <% } %>
            
            <% if (request.getAttribute("ErrorMessage") != null) { %>
            <p class="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
            <% } %>
    </body>
</html>
