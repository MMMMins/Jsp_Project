<%@ page import="Board.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Board.BoardVO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">

    <title>게시판</title>
    <style>
        body{
            background-image: linear-gradient(
                    rgba(255, 255, 255, 0.5),
                    rgba(255, 255, 255, 0.5)
            ),
            url(/img/checklistImage.png);
            background-size: contain;

        }
        .bgtr{
            background: linear-gradient(
                    rgba(255, 255, 255, 0.9),
                    rgba(255, 255, 255, 0.9)
            );

        }
    </style>
</head>
<body>
<%
    int pageIdx = 1;
    if(request.getParameter("pageIdx") != null){
        pageIdx = Integer.parseInt(request.getParameter("pageIdx"));
    }
%>
    <jsp:include page="${pageContext.request.contextPath}/menubar.jsp"/>
    <div class="container" style="position: absolute;top: 10%; left: 50%; transform: translate(-50%, -10%); ">
        <table class="table table-striped" style="text-align: center; border: solid 1px #dddddd">
            <thead>
                <tr style="background-color: #eeeeee; text-align: center">
                    <th width="10%">번호</th>
                    <th width="50%">제목</th>
                    <th width="10%">작성자</th>
                    <th width="20%">작성일</th>
                    <th width="10%">조회수</th>
                </tr>
            </thead>
            <tbody>
                <%
                    BoardDAO bdao = new BoardDAO();
                    ArrayList<BoardVO> list = bdao.getBoardList(pageIdx);
                    for (BoardVO board : list) {
                %>
                <tr class="bgtr">
                    <td><%=board.getIdx()%></td>
                    <td><a href="planView.jsp?boardIdx=<%=board.getIdx()%>"><%=board.getTitle()%></a></td>
                    <td><%=board.getId()%></td>
                    <td><%=board.getBoardData().substring(0,11)%></td>
                    <td><%=board.getReadCount()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
