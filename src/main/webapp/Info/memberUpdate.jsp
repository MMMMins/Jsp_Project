<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("userId");
    String pwd = request.getParameter("userPwd");
    String name = request.getParameter("userName");
    String gender = request.getParameter("checkS");
    String email = request.getParameter("userEmail");
    String zipno = request.getParameter("memZipno");
    String roadAddr = request.getParameter("memRoadAddr");
    String detailAddr = request.getParameter("memAddrDetail");

    UserVO vo = new UserVO(id, pwd, name, gender, email, zipno, roadAddr);
    if(detailAddr != null) vo.setDetailAddr(detailAddr);

    UserDAO dao = new UserDAO();
    if(dao.updateUser(vo) > 0){
%>
    <script>
        alert("변경완료!");
        location.href = "${pageContext.request.contextPath}/index.jsp";
    </script>
<%
    }else{
%>
<script>
        alert("변경실패\n지속될경우 관리자에게 말씀해주세요");
        history.go(-1);
    </script>
<%
    }
%>
</body>
</html>
