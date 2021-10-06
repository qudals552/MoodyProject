<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>LOGIN</title>

    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/font-awesome/css/font-awesome.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/animate.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

</head>
<body class="gray-bg">

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>

                <h1 class="logo-name">Moody</h1>
            </div> 
         </div>
    </div><br><br>
    <div class="text-center loginscreen animated fadeInDown"><br>
     <button class="btn btn-danger  dim btn-large-dim" type="button"><i class="fa fa-heart"></i></button>
            <h1>회원가입을 축하합니다!</h1>
             <br><br>
            <a href="loginForm"> <button class="btn btn-white">로그인하기</button></a>

    </div>


    <!-- Mainly scripts -->
    <script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
</body>

</body>
</html>