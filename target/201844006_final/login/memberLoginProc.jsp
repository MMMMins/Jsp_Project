<%@ page import="user.UserVO"%>
<%@ page import="user.UserDAO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%-- memberLogin.jsp -> memberLoginProc.jsp
         넘어오는 파라미터 값
         userID     -> 로그인할 id
         userPwd    -> 해당 아이디의 password
     --%>
    <title>로그인</title>
</head>
<body>
    <%
        String id = request.getParameter("userID");
        String pwd = request.getParameter("userPwd");
        if(!id.isEmpty() && !pwd.isEmpty()){
            UserVO vo = new UserVO();
            vo.setId(id);
            vo.setPassword(pwd);
            UserDAO dao = new UserDAO();
            if(dao.selectUserResult(vo)){
                dao.dbClose();
                session.setAttribute("id", id);
                response.sendRedirect("../index.jsp"); // 페이지 이동
            }else{
    %>
            <script>
                alert("로그인정보가 일치하지않습니다.")
                location.replace("memberLogin.jsp");
            </script>
    <%
            }
        }
    %>
</body>
</html>
