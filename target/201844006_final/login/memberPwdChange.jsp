<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀번호변경</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/signin.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/modal.css?after" rel="stylesheet">
</head>
<body>
<%
    String id = request.getParameter("id");
    String pwd = request.getParameter("memNewPwd");

    UserVO vo = new UserVO();
    vo.setId(id);
    vo.setPassword(pwd);
    UserDAO dao = new UserDAO();

    boolean result = dao.updateUserPwd(vo);
%>
<script>
    <c:if test="${id != null}">
    alert("허용되지 않는 접근입니다.");
    location.href='${pageContext.request.contextPath}/index.jsp';
    </c:if>
</script>
<c:if test="<%=result%>">
    <script>
        alert("비밀번호 변경이 정상적으로 처리되었습니다.\nOK버튼 누르시면 창이 닫힙니다.");
        window.close();
    </script>
</c:if>
<c:if test="<%=result%>">
    <script>
        alert("비밀번호 변경이 정상적으로 처리되지못했습니다. \n이 문제가 계속되시면, 관리자에게 문의바랍니다.");
        window.close();
    </script>
</c:if>
</body>
</html>
