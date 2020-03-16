<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<html>
<head>
   <link rel="stylesheet" href="/resources/css/header.css"  type="text/css" />
   <link rel="stylesheet" href="/resources/css/gameInfoPage.css"  type="text/css" />
   <title>회원가입 페이지</title>
</head>
<body> 
   
   <%@include file="../includes/header.jsp"%>
        
        <div class="row">
        <div class="column side">
         <img alt="E-102_Gamma" src="resources/img/E-102_Gamma.jpg">
      </div>

      <div class="column middle">
         <!--
      <img alt="casino" src="resources/img/main.png" style="width:100%">
        -->
         <div class="container">
            <h2 style="color:#454194;">MEMBERSHIP</h2>
            <form name="SignUp" method="post" action="memberSingUp.do"><!-- 회원가입, 포스트 수정했어요-->
               <table>
                  <tr>
                     <td style='width: 100px'>❡ ID ☪</td>
                     <td><input required type="text" size=25 id="id" name="id">
                     <input required type="button"  value="중복체크"></td>
                  </tr>
                  <tr>
                     <td>❡ Password ☪</td>
                     <td><input required type="password" size=37 name="password" id="password"></td>
                  </tr>
                  <tr>
                     <td>❡ Password ☪(확인)</td>
                     <td><input required type="password" size=37 name="rePassword" id="rePassword"></td>
                  </tr>
                  <tr>
                     <td>❡ Phone Number ☪</td>
                     <td><input required type="text" size=37 name="phoneNumber" id="phoneNumber" value=""></td>
                  </tr>
                  <tr>
                     <td>❡ E-mail ☪</td>
                     <td><input required type="text" size=37 name="email" id="email" value=""></td>
                  </tr>
                  <tr>
                     <td style='width: 100px'>❡ Name ☪</td>
                     <td><input required type="text" size=37 name="name" id="name" value=""></td>
                  </tr>
                  <tr>
                     <td style='width: 100px'>❡ Sex ☪ </td>
                     <td>
                        <select name="gender" id="gender">
                        <option value="Male" selected="selected">Male</option>
                        <option value="Female">Female</option>
                        </select>
                     </td>
                  </tr>
               </table>
                  <button class="button" style="vertical-align:middle">
                  <span>Sign UP </span></button>
            </form>
         </div>
         
         <table>
            <tr>
               <th>Current cash</th>
            </tr>
            <c:forEach var="Customer" items="${listAllCustomer}">
               <tr>
                  <td>${Customer.currentCash}</td>
               </tr>
            </c:forEach>
         </table>
      </div>
   
      
      <div class="column side">
         <img alt="TAKO" src="resources/img/TAKO.jpg">
      </div>
   </div>  
   <audio src="resources/mp3/NeverMind.mp3" autoplay loop>
</body>
</html>




