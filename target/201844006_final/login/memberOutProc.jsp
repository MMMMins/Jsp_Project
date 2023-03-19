<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%-- menubar.jsp -> memberOutProc.jsp
         메뉴바에 로그아웃 클릭, 세션초기화후 인덱스로 이동
    --%>
    <title>Title</title>
</head>
<body>

    <%
        session.invalidate();
        response.sendRedirect("../index.jsp");
    %>
</body>
</html>
