<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Error</title>
    <link href='<c:url value="/resources/css/bootstrap.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/font-awesome/css/font-awesome.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/animate.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h1 style="">Error</h1>
        <h3 class="font-bold">Logic Error</h3>
        <div class="error-desc">
            ${ERR}
            <form class="form-inline m-t" role="form">
                <input onclick="location.href='loginForm'" type="button" class="btn btn-primary" value="Back"/>
            </form>
        </div>
    </div>
<!-- Mainly scripts -->
<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

</body>
</html>