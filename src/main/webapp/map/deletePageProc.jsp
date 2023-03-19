<%@ page import="Board.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        int idx = Integer.parseInt(request.getParameter("deleteIdx"));
        BoardDAO bdao =new BoardDAO();
        if(bdao.deletePage(idx) > 0){
    %>
        <script>
            location.href = "boardPage.jsp";
        </script>
    <%
        }else{
    %>
        <script>
            alert("삭제에 문제가 생겼습니다.");
            history.go(-1);
        </script>
<%
    }
%>
</body>
</html>
