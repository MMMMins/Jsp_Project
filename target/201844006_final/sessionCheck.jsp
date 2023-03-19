<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String go = request.getParameter("go");
%>
<script>
    <c:if test="${id == null}">
        alert("로그인 후 이용해주세요.");
        location.href ="${pageContext.request.contextPath}/login/memberLogin.jsp";
    </c:if>
    <c:if test="${id != null}">
        location.href ="${pageContext.request.contextPath}/<%=go%>.jsp";
    </c:if>
</script>
</body>
</html>
