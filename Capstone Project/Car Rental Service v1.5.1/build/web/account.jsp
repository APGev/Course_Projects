<%-- 
    Document   : change_password
    Created on : Dec 6, 2020, 8:19:06 PM
    Author     : apgav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <title>Change Password</title>
        <style type="text/css">
               body{
               background-image: url("account.jpg");
               background-repeat: no-repeat;
               background-attachment: fixed;
               background-position: 80% 20%; 
               background-size: cover;
               background-color:bisque
               
                   
               }
        </style>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
            
            <% if (session.getAttribute("email") != null) {%>
            <h2>Account Settings</h2>
            
            <!-- Printing any Error Messages if requested -->
            <% if (request.getAttribute("ErrorMessage") != null) { %>
            <p class="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
            <% } %>
            <!-- Print any System Messages if requested -->
            <% if (request.getAttribute("SystemMessage") != null) { %>
            <p class="systemMsg"><%= (String) request.getAttribute("SystemMessage")%></p>
            <% } %>
            
            <form action="AccountSettings" method="POST">
                <fieldset>
                    <legend>Change Account Password</legend>
                    <table class="form">
                        <tr>
                            <td><label for="oldPass">Enter previous password:</label></td>
                            <td><input type="password" id="oldPass" name="oldPass"></td>
                            <% if (request.getAttribute("oldPassError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("oldPassError") %></p>
                            <% } %>                        
                        </tr>
                        <tr>
                            <td><label for="pass">Enter new password:</label></td>
                            <td><input type="password" id="newPass" name="newPass"></td>
                            <% if (request.getAttribute("newPassError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("newPassError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="pass">Confirm new password:</label></td>
                            <td><input type="password" id="newPassConfirm" name="newPassConfirm"></td>
                            <% if (request.getAttribute("newPassConfirmError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("newPassConfirmError") %></p>
                            <% } %>
                        </tr>
                    </table>
                <input type="submit" value="Change Password">
                </fieldset>
            </form>
            <%
                } else {
                    request.setAttribute("ErrorMessage", "You must be logged in to change your password.");
                    RequestDispatcher dispatch = request.getRequestDispatcher("login.jsp");
                    dispatch.forward(request,response);
                } 
            %>
        </div>
    </body>
</html>
