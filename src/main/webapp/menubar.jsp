<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>menu</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css?after" rel="stylesheet">
</head>
<body style="width:100%">
<div class="container" style="width:100%;position: absolute; left: 50%;transform: translate( -50%);z-index: 10">
    <header class="d-flex justify-content-center pt-3">
        <ul class="nav nav-pills">
            <li class="nav-item"><a href="${pageContext.request.contextPath}/index.jsp" class="nav-link active" aria-current="page">Home</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/sessionCheck.jsp?go=map/maptest" class="nav-link">여행 계획</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/sessionCheck.jsp?go=map/boardPage" class="nav-link">여행 기록</a></li>
            <c:if test="${id == null}">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/login/memberLogin.jsp" class="nav-link">로그인</a></li>
            </c:if>
            <c:if test="${id != null}">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/login/memberOutProc.jsp" class="nav-link">로그아웃</a></li>
            </c:if>
        </ul>
    </header>
</div>
</body>
</html>
