<%-- 
    Document   : Registration
    Created on : Nov 20, 2020, 1:50:04 PM
    Author     : apgav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/customer_style.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            
            
               body{
               background-image: url("register.jpg");
               background-repeat: no-repeat;
               background-attachment: fixed;
               background-position: 50% 50%; 
               background-size: cover;
               background-color:bisque
               
                   
               }
               
     
               
                
    </style>
        <title>Account Registration</title>
    </head>
    <body>
        <div id="main">
            <!-- This JSP Fragment file contains the site navigation menu
                 to be displayed at the top of every page -->
            <%@include file="WEB-INF/jspf/site_menu.jspf" %>
            
            <% if (session.getAttribute("email") == null) {%>
            <h2>Account Registration</h2>
            <!-- Printing any Error Messages if requested -->
            <% if (request.getAttribute("ErrorMessage") != null) { %>
            <p class="errorMsg"><%= (String) request.getAttribute("ErrorMessage")%></p>
            <% } %>
            <form action="Registration" method="POST">
                <fieldset>
                    <legend>Account Information:</legend>
                    <table class="form">
                        <tr>
                            <td><label for="email">Email:</label></td>
                            <td><input type="email" id="email" name="email"></td>
                            <% if (request.getAttribute("emailError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("emailError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="pass">Password:</label></td>
                            <td><input type="password" id="pass" name="pass"></td>
                            <% if (request.getAttribute("passwordError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("passwordError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="confirmPass">Password Confirmation:</label></td>
                            <td><input type="password" id="confirmPass" name="confirmPass"></td>
                            <% if (request.getAttribute("confirmPasswordError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("confirmPasswordError") %></p>
                            <% } %>
                        </tr>
                    </table>
                </fieldset>
                <fieldset>
                    <legend>User Information:</legend>
                    <table class="form">
                        <tr>
                            <td><label for="fname">First Name:</label></td>
                            <td><input type="text" id="fname" name="fname"></td>
                            <% if (request.getAttribute("fnameError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("fnameError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="lname">Last Name:</label></td>
                            <td><input type="text" id="lname" name="lname"></td>
                            <% if (request.getAttribute("lnameError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("lnameError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="licenseID">Driver's License ID Number: </label></td>
                            <td><input type="text" id="licenseID" name="licenseID"></td>
                            <% if (request.getAttribute("licenseError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("licenseError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="phoneNumber">Phone Number: </label></td>
                            <td><input type="text" id="phoneNumber" name="phoneNumber"></td>
                            <% if (request.getAttribute("phoneError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("phoneError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="streetAdd">Street Address:</label></td>
                            <td><input type="text" id="streetAdd" name="streetAdd"></td>
                            <% if (request.getAttribute("streetError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("streetError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="cityAdd">City:</label></td>
                            <td><input type="text" id="cityAdd" name="cityAdd"></td>
                            <% if (request.getAttribute("cityError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("cityError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="stateAdd">State:</label></td>
                            <td><select name="stateAdd" id="stateAdd">
                                <option value="None" selected hidden>Select a State</option>
                                <option value="AL">Alabama</option>
                                <option value="AK">Alaska</option>
                                <option value="AZ">Arizona</option>
                                <option value="AR">Arkansas</option>
                                <option value="CA">California</option>
                                <option value="CO">Colorado</option>
                                <option value="CT">Connecticut</option>
                                <option value="DE">Delaware</option>
                                <option value="DC">District Of Columbia</option>
                                <option value="FL">Florida</option>
                                <option value="GA">Georgia</option>
                                <option value="HI">Hawaii</option>
                                <option value="ID">Idaho</option>
                                <option value="IL">Illinois</option>
                                <option value="IN">Indiana</option>
                                <option value="IA">Iowa</option>
                                <option value="KS">Kansas</option>
                                <option value="KY">Kentucky</option>
                                <option value="LA">Louisiana</option>
                                <option value="ME">Maine</option>
                                <option value="MD">Maryland</option>
                                <option value="MA">Massachusetts</option>
                                <option value="MI">Michigan</option>
                                <option value="MN">Minnesota</option>
                                <option value="MS">Mississippi</option>
                                <option value="MO">Missouri</option>
                                <option value="MT">Montana</option>
                                <option value="NE">Nebraska</option>
                                <option value="NV">Nevada</option>
                                <option value="NH">New Hampshire</option>
                                <option value="NJ">New Jersey</option>
                                <option value="NM">New Mexico</option>
                                <option value="NY">New York</option>
                                <option value="NC">North Carolina</option>
                                <option value="ND">North Dakota</option>
                                <option value="OH">Ohio</option>
                                <option value="OK">Oklahoma</option>
                                <option value="OR">Oregon</option>
                                <option value="PA">Pennsylvania</option>
                                <option value="RI">Rhode Island</option>
                                <option value="SC">South Carolina</option>
                                <option value="SD">South Dakota</option>
                                <option value="TN">Tennessee</option>
                                <option value="TX">Texas</option>
                                <option value="UT">Utah</option>
                                <option value="VT">Vermont</option>
                                <option value="VA">Virginia</option>
                                <option value="WA">Washington</option>
                                <option value="WV">West Virginia</option>
                                <option value="WI">Wisconsin</option>
                                <option value="WY">Wyoming</option>
                                </select>
                            </td>
                            <% if (request.getAttribute("stateError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("stateError") %></p>
                            <% } %>
                        </tr>
                        <tr>
                            <td><label for="zipCode">ZIP Code:</label></td>
                            <td><input type="text" id="zipCode" name="zipCode"></td>
                            <% if (request.getAttribute("zipError") != null) { %>
                            <td><p class="errorMsg"><%= (String) request.getAttribute("zipError") %></p>
                            <% } %>
                        </tr>
                    </table>
                </fieldset>
                <input type="submit" value="Register">
            </form>
            <%
                } else {
                    request.setAttribute("ErrorMessage", "You must log out to create a new account. ");
                    RequestDispatcher dispatch = request.getRequestDispatcher("home.jsp");
                    dispatch.forward(request,response);
                } 
            %>
        </div>
    </body>
</html>
