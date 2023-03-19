<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String id = (String) session.getAttribute("id");
    String pwd = request.getParameter("pwd");
    Map<String,String> userData;
    UserVO vo = new UserVO();
    vo.setId(id);
    vo.setPassword(pwd);
    boolean chk = false;
    UserDAO dao = new UserDAO();
    if(dao.selectUserResult(vo)){
        chk = true;
        userData = dao.selectUserAllData(vo);
        request.setAttribute("userData", userData);
    }
    request.setAttribute("beforePwd", pwd);
%>
<script>
    <c:if test="<%=!chk%>">
        alert("비밀번호가 틀렸습니다.");
        location.replace("memberInfoLogin.jsp");
    </c:if>
    <c:if test="<%=chk%>">
        <jsp:forward page="memberInfoView.jsp"></jsp:forward>
    </c:if>
</script>
</body>
</html>
