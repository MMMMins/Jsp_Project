<%@ page import="java.util.ArrayList" %>
<%@ page import="Board.BoardVO" %>
<%@ page import="Board.BoardDAO" %>
<%@ page import="schedule.*" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">

<%
    int idx = 0;
    if(request.getParameter("boardIdx") != null){
        idx = Integer.parseInt(request.getParameter("boardIdx"));
    }
    if(idx == 0){
%>
    <script>
        alert("이상한 접근입니다.");
        location.href="${pageContext.request.contextPath}/map/boardPage.jsp";
    </script>
<%
    }
    LocationDAO ldao = new LocationDAO();
    TrafficDAO tdao = new TrafficDAO();
    ScheduleDAO sdao = new ScheduleDAO();
    AccommodationDAO adao = new AccommodationDAO();
    TrafficOneVO tOvo = tdao.oneWayView(idx);
    TrafficTwoVO tTvo = tdao.twoWayView(idx);
    ScheduleVO svo = sdao.getView(idx);
    String id = (String) session.getAttribute("id");
    ArrayList<LocationVO> locationList = ldao.getView(idx);
    ArrayList<AccommodationVO> accList = adao.AccommView(idx);
    new BoardDAO().updateReadCount(idx);
%>
<jsp:include page="${pageContext.request.contextPath}/menubar.jsp"/>
<div style="position: absolute;top: 60%; left: 50%; transform: translate(-50%, -60%); ">
    <table class="table table-hover" style="width: 1200px;margin-bottom: 2px;">
        <thead style="background-color: #e2e2e2">
        <tr style="height: 40px" valign="middle">
            <th style="width: auto;text-align: center;color: blue"><%=idx%></th>
            <th style="width: auto"> 제목 : </th>
            <th style="width: 57%;text-align: center"><%=svo.getTitle()%></th>
            <th>여행기간 :</th>
            <th><%=svo.getStartdate()%> ~ <%=svo.getEnddate()%></th>
        </tr>
        </thead>
    </table>

    <div style="display: flex;height: 600px;overflow: auto;">
        <div style="flex: 1;">
            <table class="table table-hover table-bordered bgtr" style="width: 300px">
                <thead align="center" style="height: 63px">
                <tr valign="middle">
                    <th>출발지</th> <th>목적지</th> <th>거리</th> <th>시간</th>
                </tr>
                </thead>
                <tbody id="locationTable" style="text-align: center">
                <%
                    for (LocationVO list : locationList){
                %>
                    <tr valign="middle">
                        <td><%=list.getFromLoc()%></td>
                        <td><%=list.getToLoc()%></td>
                        <td><%=list.getDistance()%></td>
                        <td><%=list.getTime()%></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <div style="flex: 1;">
            <table style="width: 400px" class="table table-bordered bgtr" >
                <thead align="center">
                <!-- 메인-->
                <tr style="height: 63px">
                    <th valign="top" colspan="4">
                        <span style="font-size: 20px">교통편</span><br>
                        <span style="color:#bdbcbc">*출발지부터 여행지까지 이동방법</span>
                    </th>
                </tr>
                <!-- 교통수단, 방법, 비고-->
                <tr valign="middle">
                    <th colspan="2" ><%=tOvo.getWay()%></th>
                    <th colspan="2" ><%=tOvo.getName()%></th>
                </tr>
                <%
                    if(tOvo.getWay().equals("편도")){
                %>
                <tr valign="middle">
                    <th colspan="2"><%=tTvo.getWay()%></th>
                    <th colspan="2"><%=tTvo.getName()%></th>
                </tr>
                <%
                    }
                %>
                </thead>
                <tbody id="trafficTable" style="text-align: center;">
                    <tr valign="middle">
                        <td >
                            <span style="font-size: 20px">가는편 비용</span><br>
                        </td>
                        <td colspan="3">
                            <span style="font-size: 20px"><%=tOvo.getAmount()%></span><br>
                            <span style="color:#bdbcbc">*1인당 금액</span>
                        </td>
                    </tr>
                    <tr valign="middle">
                        <td>
                            <span style="font-size: 20px">오는편 비용</span><br>
                        </td>
                        <td colspan="3">
                            <span style="font-size: 20px"><%=tTvo.getAmount()%></span><br>
                            <span style="color:#bdbcbc">*1인당 금액</span>
                        </td>
                    </tr>
                    <%
                        if(!tOvo.getWay().equals("차량")){
                    %>
                    <tr>
                        <td>
                            <span style="font-size: 20px">가는날 티켓시간</span>
                        </td>
                        <td colspan="3">
                            <span style="font-size: 18px"><%=tOvo.getDepartDate()%> / <%=tOvo.getDepartTime()%></span>
                        </td>
                    </tr>
                    <%
                        }
                        if(!tTvo.getWay().equals("차량")){
                    %>
                    <tr>
                        <td>
                            <span style="font-size: 20px">오는날 티켓시간</span>
                        </td>
                        <td colspan="3">
                            <span style="font-size: 18px"><%=tTvo.getArrivalDate()%> / <%=tTvo.getReturnTime()%></span>
                        </td>
                    </tr>

                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div style="flex: 1;">
            <table style=" width: 500px" class="table table-bordered bgtr">
                <thead align="center">
                <tr style="height: 63px">
                    <th valign="top" colspan="4">
                        <span style="font-size: 20px">숙소편</span><br>
                        <span style="color:#bdbcbc">*숙박일정, 몇박/금액</span>
                    </th>
                </tr>
                <tr valign="middle">
                    <th >숙소</th>
                    <th colspan="2" >기간</th>
                    <th> 금액</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for(AccommodationVO avo : accList){
                %>
                <tr style="text-align: center; height: 76px">
                    <td valign="middle">
                        <span style="font-size: 20px"><%=avo.getName()%></span><br>
                        <span style="color:#bdbcbc">*숙소명</span>
                    </td>
                    <td colspan="2" valign="middle">
                        <span style="font-size: 18px"><%=avo.getCheckIn()%> ~ <%=avo.getCheckOut()%></span><br>
                        <span style="color:#bdbcbc">*체크인 ~ 체크아웃</span>
                    </td>
                    <td valign="middle">
                        <span style="font-size: 20px"><%=avo.getAmount()%></span><br>
                        <span style="color:#bdbcbc">*금액</span>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
    <div style="float:right">
        <a class="btn btn-danger" style="background-color:#ffa0ac;" href="planView.jsp?boardIdx=<%=idx%>">이전페이지</a>
        <%
            if(svo.getId().equals(id)){
        %>
        <a class="btn btn-danger" style="background-color:#ffa0ac;" href="deletePageProc.jsp?deleteIdx=<%=idx%>">삭제하기</a>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
