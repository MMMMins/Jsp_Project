<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP 프로젝트</title>
    <style>
        .footerbar{
            font-size: 1.125rem;
            background-color: gray;
            background-size: cover;
        }
    </style>
</head>
<body style="width: 100vw; height: 100vh; padding: 0">
    <div style="background-color: black;  height: 100vh">
        <div id="header">
            <jsp:include page="menubar.jsp"/>
        </div>
        <div id="container" >
            <jsp:include page="main.jsp"/>
        </div>
    </div>
</body>
</html>
