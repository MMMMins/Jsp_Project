<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="schedule.*" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="Board.BoardVO" %>
<%@ page import="Board.BoardDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    /*
        메인 여행 계획 테이블 생성
     */
    request.setCharacterEncoding("utf-8");
    SimpleDateFormat fm = new SimpleDateFormat("yy-MM-dd");
    int idx = (int) session.getAttribute("idx");
    String id = (String) session.getAttribute("id");
    String title = (String) session.getAttribute("title");
    String[] date = (String[]) session.getAttribute("date");

    String statusSchedule = "";
    ScheduleVO svo = new ScheduleVO();
    svo.setIdx(idx);
    svo.setId(id);
    svo.setTitle(title);
    svo.setStartdate(date[0]);
    svo.setEnddate(date[1]);

    ScheduleDAO sdao = new ScheduleDAO();
    int scheduleResult = sdao.insertSchedule(svo);
    if(scheduleResult > 0){
        statusSchedule = "여행 계획 작성 완료";
    }else if(scheduleResult == 0){
        statusSchedule = "여행 계획 작성에 문제가 생겼습니다.";
    }else{
        statusSchedule = "여행 계획 등록에 문제가 생겼습니다.";
    }
    System.out.println("여행 계획 삽입 : "+scheduleResult);

%>
<%
    /*
        출발지 목적지 삽입
     */
    ArrayList<LocationVO> locationList = (ArrayList<LocationVO>) session.getAttribute("table");
    ArrayList<String> insertError = new ArrayList<>();
    ArrayList<String> statusLocation = new ArrayList<>();
    if(locationList.size() != 0){
        for(LocationVO lvo : locationList){
            lvo.setIdx(idx);
            LocationDAO ldao = new LocationDAO();
            int locationResult = ldao.insertLocationTime(lvo);
            if(locationResult > 0){
                statusLocation.add("여행 경로 작성 완료");
            }else if(locationResult == 0){
                statusLocation.add("여행 경로 작성에 문제가 생겼습니다.");
            }else{
                statusLocation.add("여행 경로 등록에 문제가 생겼습니다.");
            }
            System.out.println("출발지 목적지 삽입 : "+locationResult);
        }
    }
%>
<%
    /*
        교통수단
     */
    Enumeration<String> te = request.getParameterNames();
    while(te.hasMoreElements()){
        System.out.println(te.nextElement());
    }
    String way = request.getParameter("way");
    String wayType = request.getParameter("wayType");
    String carType = way.equals("car") ? request.getParameter("carType") : "";
    String[] wayDate = new String[]{date[0],date[1]};
    String[] wayTime = new String[2];
    String endWay;
    String endCarType;
    String[] wayName;
    int[] wayAccount;

    if(wayType.equals("two")){
        endWay = way;
        endCarType = carType;
        wayAccount = new int[]{Integer.parseInt(request.getParameter("wayAccount").replace(",", ""))/2,
                               Integer.parseInt(request.getParameter("wayAccount").replace(",", ""))/2};
        if(way.equals("car")){
            wayName = new String[] {request.getParameter("carType"),
                                    request.getParameter("carType")};
        }else{
            wayName = new String[] {request.getParameter("airlineName"),
                                    request.getParameter("airlineName")};
            wayTime[0] = request.getParameter("startTime");
            wayTime[1] = request.getParameter("endTime");
        }
    }else{
        endWay = request.getParameter("endWay");
        endCarType = endWay.equals("car") ? request.getParameter("endCarType") : "";
        wayTime[0] = request.getParameter("startTime");
        if(!endWay.equals("car")) {
            wayTime[1] = request.getParameter("endTime");
        }
        wayName = new String[] {request.getParameter("airlineName"),
                                request.getParameter("endAirlineName")};
        wayAccount = new int[] {Integer.parseInt(request.getParameter("wayAccount").replace(",", "")),
                                Integer.parseInt(request.getParameter("endWayAccount").replace(",", ""))};
    }


    TrafficOneVO tOvo = new TrafficOneVO(idx,title,way,wayType,carType,wayName[0], wayDate[0],wayTime[0],wayAccount[0]);
    TrafficTwoVO tTvo = new TrafficTwoVO(idx,title,endWay,endCarType,
                                        wayName[1],
                                        wayDate[1],
                                        wayTime[1],
                                        wayAccount[1]);
    String statusTrafficOne = "";
    String statusTrafficTwo = "";
    TrafficDAO tdao = new TrafficDAO();
    int trafficOneResult = tdao.insertOneWay(tOvo);
    if(trafficOneResult > 0){
        statusTrafficOne = "가는편 교통 계획 정보 작성이 완료되었습니다.";
    }else if(trafficOneResult == 0){
        statusTrafficOne = "가는편 교통 계획 정보 작성에 문제가 생겼습니다.";
    }else{
        statusTrafficOne = "가는편 교통 계획 정보 등록에 문제가 생겼습니다.";
    }

    int trafficTwoResult = tdao.insertTwoWay(tTvo);
    if(trafficTwoResult > 0){
        statusTrafficTwo = "오는편 교통 계획 정보 작성이 완료되었습니다.";
    }else if(trafficTwoResult == 0){
        statusTrafficTwo = "오는편 교통 계획 정보 작성에 문제가 생겼습니다.";
    }else{
        statusTrafficTwo = "오는편 교통 계획 정보 등록에 문제가 생겼습니다.";
    }
    System.out.println("가는편 교통계획 삽입 : "+trafficOneResult);
    System.out.println("오는편 교통계획 삽입 : "+trafficTwoResult);
%>
<%
    /*
        숙소 정보 삽입
     */
    String[] accName = request.getParameterValues("accNames");
    String[] checkInOut = request.getParameterValues("checkInOut");
    String[] money = request.getParameterValues("money");
    try {
        for(int i=0; i<accName.length;i++){
            if(accName[i].isEmpty()){
                break;
            }
            System.out.println(accName[i]+"|"+money[i]+"|"+checkInOut[i]);
            String[] dateInOut = checkInOut[i].replace(" ","").split("~");
            String amount = money[i].replace(",","");
            Date format1 = new SimpleDateFormat("yy/MM/dd").parse(dateInOut[0]);
            Date format2 = new SimpleDateFormat("yy/MM/dd").parse(dateInOut[1]);
            long day = ((format2.getTime() - format1.getTime()) / 1000) / (24*60*60);
            AccommodationVO avo = new AccommodationVO();
            AccommodationDAO adao = new AccommodationDAO();
            avo.setIdx(idx);
            avo.setName(accName[i]);
            avo.setTitle(title);
            avo.setCheckIn(dateInOut[0]);
            avo.setCheckOut(dateInOut[1]);
            avo.setDay(String.valueOf(day));
            avo.setAmount(Integer.parseInt(amount));
            int result = adao.insertAcc(avo);
            if(result <= 0 ){
                System.out.println("에러에러에러숙소");
            }
        }
    } catch (ParseException e) {
        System.out.println("날짜변환에러");
        e.printStackTrace();
    }

%>
<%
    /*
        게시글 테이블 삽입
     */
    BoardVO bvo = new BoardVO();
    BoardDAO bdao = new BoardDAO();
    bvo.setIdx(idx);
    bvo.setId(id);
    bvo.setTitle(title);
    bvo.setBoardData(bdao.getDateNow());
    if(bdao.insertBoard(bvo) >= 0){

    }else{

    }
%>

<jsp:forward page="boardPage.jsp"/>
</body>
</html>
