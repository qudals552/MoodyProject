<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/font-awesome/css/font-awesome.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/animate.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
</head>
<title>LOGIN</title>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name">Moody</h1>
            </div>
            <h3>로그인</h3>
            <br>
            <form action="loginOK" name="loginForm" method="post" class="m-t" role="form">
                <div class="form-group">
                    <input type="text" name="id" class="form-control" placeholder="아이디" maxlength="10" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" class="form-control" placeholder="비밀번호" maxlength="20" required>
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b">로그인</button>
                <p class="text-muted text-center"></p>
                <a onclick="join()" class="btn btn-sm btn-white btn-block">회원가입</a> <br>
                <!-- <a href="#"><small>Forgot password?</small></a> -->
            </form>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="<c:url value="/resources/js/jquery-2.1.1.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <script>
		function join(){
			location.href="joinForm";
		}
	</script>
</body>
</html>