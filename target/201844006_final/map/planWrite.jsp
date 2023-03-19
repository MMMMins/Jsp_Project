<%@ page import="java.util.ArrayList" %>
<%@ page import="schedule.ScheduleDAO" %>
<%@ page import="schedule.LocationVO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

    <!--교통편 스크립트 -->
    <script>
        let waySelect;
        let selectValue;
        let carTypeBtn;
        let wayTypeBtn;

        function changeWay(){
            waySelect = document.getElementById("way");                         // 편도 왕복 선택
            selectValue = waySelect.options[waySelect.selectedIndex].value;     // 선택한 옵션
            wayTypeBtn = document.getElementsByName("wayType");
            document.getElementById("endWay").selectedIndex = 0;

            carTypeBtn = document.getElementsByName("carType");                 // 자차 렌트 초기화
            carTypeBtn[0].checked = false;
            carTypeBtn[1].checked = false;

            document.getElementById("selectWayType").innerText =                // 아래 셀에 선택된 값 출력
                document.getElementById("way").options[waySelect.selectedIndex].innerText;

            document.getElementById("carTypeHidden").style.display = "none";    // 자차 렌트 셀 숨기기
            document.getElementById("firstTr").style.display = "none";          // 구분 셀 숨기기
            document.getElementById("routeAccountTr").style.display = "none";   // 금액 셀 숨기기
            document.getElementById("asEndWay").style.display = "none";         // 편도 교통수단 셀 숨기기
            document.getElementById("route").checked = false;                   // 왕복 편도 버튼 초기화
            document.getElementById("onwWay").checked = false;
            document.getElementById("endMyCar").disabled = true;                // 자차, 렌트 버튼 비활성
            document.getElementById("endRentalCar").disabled = true;
            document.getElementById("endMyCar").checked = false;                // 자차, 렌트 버튼 초기화
            document.getElementById("endRentalCar").checked = false;
            document.getElementById("endFirstTr").style.display = "none"        // 돌아오는 날 셀 숨기기
            document.getElementById("endAccountTr").style.display = "none"      // 금액지정 셀 숨기기
            document.getElementById("startTicketTime").style.display = "none"   // 티켓시간 숨기기
            document.getElementById("startTimeDiv").style.display = "none"      // 가는날 시간 숨기기
            document.getElementById("endTimeDiv").style.display = "none"        // 오는날 시간 숨기기

            if(selectValue === "car"){
                document.getElementById("carTypeHidden").style.display = "";    // 자차 렌트 셀 보이기
            }
        }

        function checkWayRadio(){ //왕복 편도 클릭시
            waySelect = document.getElementById("way");
            selectValue = waySelect.options[waySelect.selectedIndex].value;
            carTypeBtn = document.getElementsByName("carType");
            wayTypeBtn = document.getElementsByName("wayType");
            document.getElementById("endTimeDiv").style.paddingLeft = "0px";

            document.getElementById("endFirstTr").style.display = "none"        // 돌아오는 날 셀 숨기기
            document.getElementById("asEndWay").style.display = "none";         // 편도 교통수단 셀 숨기기
            document.getElementById("firstTr").style.display = "none";          // 구분 셀 숨기기
            document.getElementById("endAccountTr").style.display = "none"      // 금액지정 셀 숨기기
            document.getElementById("startTicketTime").style.display = "none";
            document.getElementById("startTimeDiv").style.display = "none";     // 가는날 시간 숨기기
            document.getElementById("endTimeDiv").style.display = "none"        // 오는날 시간 숨기기
            document.getElementById("routeAccountTr").style.display = "none";   // 금액 셀 숨기기
            document.getElementById("asCar").style.display = "none";

            if(selectValue === "noChoice"){
                document.getElementById("asWay").style.display = "";
                for(let i=0; i<wayTypeBtn.length; i++){
                    wayTypeBtn[i].checked = false;
                }
            }else if(selectValue !== "car"){
                document.getElementById("firstTr").style.display = "";          // 구분 셀 보이기
                document.getElementById("routeAccountTr").style.display = "";   // 금액 셀 보이기
                if(wayTypeBtn[1].checked){
                    document.getElementById("accountWayType").innerText = "편도 티켓값";
                    document.getElementById("asEndWay").style.display = "";       // 편도 교통수단 셀 보이기
                    document.getElementById("startTicketTime").style.display = "";
                    document.getElementById("startTimeDiv").style.display = "";
                }else{
                    document.getElementById("accountWayType").innerText = "왕복 티켓값";
                    document.getElementById("startTicketTime").style.display = "";
                    document.getElementById("startTimeDiv").style.display = "";
                    document.getElementById("endTimeDiv").style.display ="";

                }
                document.getElementById("accountWayMessage").innerText = "*1인 요금";
            }else{
                carTypeBtn[0].checked = false;
                carTypeBtn[1].checked = false;
                document.getElementById("carTypeHidden").style.display = "";    // 자차 렌트 셀 보이기
            }
        }
        function checkCarType() { // 자차 렌트 클릭시
            selectValue = waySelect.options[waySelect.selectedIndex].value;
            carTypeBtn = document.getElementsByName("carType");
            wayTypeBtn = document.getElementsByName("wayType");

            document.getElementById("asCar").style.display = "none";
            if(!wayTypeBtn[0].checked && !wayTypeBtn[1].checked){
                document.getElementById("asCar").style.display = "";
                carTypeBtn[0].checked = false;
                carTypeBtn[1].checked = false;
                return;
            }else if (carTypeBtn[0].checked) {
                if(wayTypeBtn[1].checked){
                    wayTypeBtn[0].checked = true;
                    alert("자차는 왕복으로 고정됩니다.");
                }
                document.getElementById("selectWayMessage").innerText = "*가는날/오는날";
                document.getElementById("accountWayType").innerText = "왕복 유류비";
                document.getElementById("accountWayMessage").innerText = "*1인 요금"
                document.getElementById("asEndWay").style.display="none";

                document.getElementById("routeAccountTr").style.display = "";
                document.getElementById("selectWayType").innerText = "차량(자차)";
            }else{
                let wayCar;
                if(wayTypeBtn[0].checked){  // 렌트, 왕복
                    wayCar = "왕복";
                    document.getElementById("asEndWay").style.display="none";     // 편도 교통수단 셀 숨기기
                    document.getElementById("selectWayMessage").innerText = "*대여일/반납일";
                }else{                      // 렌트, 편도
                    wayCar = "편도";
                    document.getElementById("asEndWay").style.display="";         // 편도 교통수단 셀 보이기
                    document.getElementById("selectWayMessage").innerText = "*대여일";
                }
                document.getElementById("routeAccountTr").style.display = "";
                document.getElementById("accountWayType").innerText = wayCar + " 렌트비";
                document.getElementById("accountWayMessage").innerText = "* 총금액";
                document.getElementById("selectWayType").innerText = "차량(렌트)";
            }
            document.getElementById("firstTr").style.display = "";          // 구분 셀 보이기
        }

        let endWaySelect, endCarTypeBtn, endSelectValue;
        function endChangeWay(){
            endWaySelect = document.getElementById("endWay");                         // 편도 왕복 선택
            endSelectValue = endWaySelect.options[endWaySelect.selectedIndex].value;     // 선택한 옵션
            endCarTypeBtn = document.getElementsByName("endCarType");
            document.getElementById("endTimeDiv").style.paddingLeft = 0;

            document.getElementById("endMyCar").disabled = true;                // 자차, 렌트 버튼 비활성
            document.getElementById("endRentalCar").disabled = true;
            document.getElementById("endMyCar").checked = false;                // 자차, 렌트 버튼 초기화
            document.getElementById("endRentalCar").checked = false;

            document.getElementById("endSelectWayType").innerText =                // 아래 셀에 선택된 값 출력
                document.getElementById("endWay").options[endWaySelect.selectedIndex].innerText;

            if(endSelectValue !== "car"){
                document.getElementById("endFirstTr").style.display = "";
                document.getElementById("endAccountTr").style.display = "";
                document.getElementById("startTicketTime").style.display = "";
                document.getElementById("endTimeDiv").style.display = "";

                if(selectValue === "car"){
                    document.getElementById("timeTd").colSpan = 4;
                    document.getElementById("endTimeDiv").style.paddingLeft = "12px";
                }else{
                    document.getElementById("timeTd").colSpan = 3;
                }
                document.getElementById("endAccountWayType").innerText = "편도 티켓값";
                document.getElementById("endAccountWayMessage").innerText = "*1인 요금"
            }else if(endSelectValue === "car"){
                if(selectValue === "car"){
                    document.getElementById("startTicketTime").style.display = "none";
                }
                document.getElementById("endMyCar").disabled = false;                // 자차, 렌트 버튼 비활성
                document.getElementById("endRentalCar").disabled = false;
                document.getElementById("endTimeDiv").style.display = "none";
            }
        }
        function checkEndCarType(btnId){
            document.getElementById("endSelectWayType").innerText =                // 아래 셀에 선택된 값 출력
                document.getElementById("endWay").options[endWaySelect.selectedIndex].innerText;
            if(document.getElementById(btnId).checked){
                document.getElementById("endFirstTr").style.display = "";
                document.getElementById("endAccountTr").style.display = "";
                document.getElementById("endSelectWayType").innerText += "(" + document.getElementById(btnId).value+ ")";
                document.getElementById("endAccountWayType").innerText = document.getElementById(btnId).value === "자차" ? "편도 유류비" : "편도 렌트비";
                document.getElementById("endAccountWayMessage").innerText = "*총금액"
            }
        }
    </script>

    <script>
        function amount(btn){
            let acc = document.getElementById(btn).value;
            let num = /^[0-9]/g;
            acc = acc.replace(/[^\d]+/g, '');
            if(!num.test(acc)){
                acc = acc.replace(/^[0-9]/g,"");
                document.getElementById(btn).value = acc;
            }else{
                totalMoneySum();
                document.getElementById(btn).value = acc.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }

        function amount1(inputValue){
            let acc = inputValue.value;
            let num = /^[0-9]/g;
            acc = acc.replace(/[^\d]+/g, '');
            if(!num.test(acc)){
                acc = acc.replace(/^[0-9]/g,"");
                inputValue.value = acc;
            }else{
                totalMoneySum();
                inputValue.value = acc.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
        }
        function totalMoneySum(){
            let money = 0
            let temp = document.getElementsByName("money");
            for(let i = 0; i<temp.length;i++){
                money += Number(temp[i].value.replaceAll(",",""));
            }
            document.getElementById("totalMoney").placeholder = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }
    </script>
    <!--숙소편 스크립트 -->
    <script>
        function selectNumberFun(){
            let selectForm = document.getElementById("selectNumber");
            let count = selectForm.options[selectForm.selectedIndex].value;
            let rowValue = document.getElementsByName("accTr");
            for(let i=0; i<9; i++){
                rowValue[i].style.display = "none";
                rowValue[i].children[0].children[0].children[0].required = false;
                rowValue[i].children[1].children[0].children[0].required = false;
                rowValue[i].children[2].children[0].children[0].required = false;
            }
            for(let i=0; i<count; i++){
                rowValue[i].style.display = "";
                rowValue[i].children[0].children[0].children[0].required = true;
                rowValue[i].children[1].children[0].children[0].required = true;
                rowValue[i].children[2].children[0].children[0].required = true;
            }
        }


    </script>
    <style>
        body{
            background-image: linear-gradient(
                    rgba(255, 255, 255, 0.5),
                    rgba(255, 255, 255, 0.5)
            ),
            url(/img/pngegg.png);
            background-size: cover;

        }
        .bgimg{
            background: linear-gradient(
                rgba(255, 255, 255, 0.9),
                rgba(255, 255, 255, 0.9)
            );

        }
    </style>
    <style>
        #trafficTable tr{
            text-align: center;
            vertical-align : middle;
        }
    </style>
    <title>상세계획</title>
<body>
<script>
    <c:if test="${id == null}">
    alert("허용되지 않는 접근입니다.");
    location.href = "${pageContext.request.contextPath}/index.jsp";
    </c:if>
</script>
<%
    request.setCharacterEncoding("utf-8");
    String title = request.getParameter("travelTit");
    String temp =request.getParameter("schedule").replace(" ","");
    String[] date =  temp.split("~");
    ScheduleDAO scheduleDAO = new ScheduleDAO();
    LocationVO locationVO = null;
    int idx = scheduleDAO.choiceIdx();
    String[] rowDatas = request.getParameterValues("rowData");
    ArrayList<LocationVO> table = new ArrayList<>();
    String[] rowData = new String[7];


    for(int i=0, j=0; i<rowDatas.length; i++){
        if(j != rowDatas.length/rowData.length){
            rowData[i-j*7] = rowDatas[i];
        }
        if(rowData[i-j*7].equals("last%")){
            locationVO = new LocationVO(idx, title, rowData[1], rowData[2], rowData[3], rowData[5], rowData[4].equals("TRANSIT") ? "국내" : "국외");
            table.add(locationVO);
            j++;
        }
    }
    session.setAttribute("idx", idx);
    session.setAttribute("table", table);
    session.setAttribute("date", date);
    session.setAttribute("title", title);
    //[인덱스, 기준점, 목적지, 소요시간, 국내/외]
%>
<jsp:include page="${pageContext.request.contextPath}/menubar.jsp"/>
<form method="post" action="planWriteProc.jsp">
    <div style="position: absolute;top: 32%; left: 50%; transform: translate(-50%, -32%); ">
        <table class="table table-hover" style="width: 1200px;margin-bottom: 2px;">
            <thead style="background-color: #e2e2e2">
            <tr style="height: 40px" valign="middle">
                <th style="width: auto;text-align: center;color: blue"><%=idx%></th>
                <th style="width: auto"> 제목 : </th>
                <th style="width: 57%;text-align: center"><%=title%></th>
                <th>여행기간 :</th>
                <th><%=date[0]%> ~ <%=date[1]%></th>
            </tr>
            </thead>
        </table>

        <div style="display: flex;height: 600px;overflow: auto;">
            <div style="flex: 1;">
                <table class="table table-hover table-bordered bgimg" style="width: 300px">
                    <thead align="center" style="height: 63px">
                        <tr valign="middle">
                            <th>출발지</th> <th>목적지</th> <th>거리</th> <th>시간</th>
                        </tr>
                    </thead>
                    <tbody id="locationTable" >
                    <c:forEach items="${table}" var="rowTable">
                        <tr style="height: 76px" valign="middle">
                            <td>${rowTable.fromLoc}</td>
                            <td>${rowTable.toLoc}</td>
                            <td>${rowTable.distance}</td>
                            <td>${rowTable.time}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div style="flex: 1;">
                <table style="width: 400px" class="table table-bordered bgimg" >
                    <thead align="center">
                        <!-- 메인-->
                        <tr style="height: 63px">
                            <th valign="top" colspan="4">
                                <span style="font-size: 20px">교통편</span><br>
                                <span style="color:#bdbcbc">*출발지부터 여행지까지 이동방법</span>
                            </th>
                        </tr>
                        <!-- 교통수단, 방법, 비고-->
                        <tr style="height: 76px" valign="middle">
                            <!-- 이동수단 name="way", id="way" -->
                            <th style="width: 40%" >
                                <select class="form-select" id="way" name="way" aria-label="이동방법" onchange="changeWay()" >
                                    <option value="noChoice" selected>이동방법</option>
                                    <option value="ship">배</option>
                                    <option value="car">차량</option>
                                    <option value="bus">버스</option>
                                    <option value="train">기차</option>
                                    <option value="air">비행기</option>
                                </select>
                            </th>
                            <!-- 왕복/편도 선택 name="wayType" id="route", "oneWay"-->
                            <th style="width: auto;padding: 0;" valign="middle" colspan="2">
                                <input type="radio" class="form-check-input" name="wayType" id="route" value="two" onclick="checkWayRadio()">
                                <label for="route"> 왕복 </label>&nbsp;&nbsp;
                                <input type="radio" class="form-check-input" name="wayType" id="onwWay" value="one" onclick="checkWayRadio()">
                                <label for="onwWay"> 편도 </label>
                                <br><span id="asWay" style="color:red; display:none;font-size: 12px">*이동방법을 먼저 선택해주세요</span>
                            </th>
                            <!-- 자차/왕복 선택 name="carType" id="myCar", "rentalCar"-->
                            <th id="carTypeHidden" style="width: 30%;display: none;padding: 0" valign="middle" >
                                <input type="radio" class="form-check-input" name="carType" id="myCar" value="자차" onclick="checkCarType()" >
                                <label for="myCar"> 자차 </label>&nbsp;&nbsp;
                                <input type="radio" class="form-check-input" name="carType" id="rentalCar" value="렌트" onclick="checkCarType()">
                                <label for="rentalCar"> 렌트 </label>
                                <br><span id="asCar" style="color:red; display:none;font-size: 12px">*이동방법을 먼저 선택해주세요</span>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="trafficTable">
                        <!-- 출발일 또는 왕복일자 지정-->
                        <tr id="firstTr" style="display: none; height: 76px">
                            <td>
                                <span id="selectWayType" style="font-size: 20px"></span><br>
                                <span id="selectWayMessage" style="color:#bdbcbc;"></span>
                            </td>
                            <td colspan="3">
                                <label style="font-size: 13px">항공사, 기차, 버스  회사이름 또는 종류</label>
                                <input class="form-control" name="airlineName" type="text" autocomplete="off" placeholder="대한항공, KTX, 우등버스/대원관광" style="font-size: 13px;">
                            </td>
                        </tr>

                        <!-- 금액 지정 -->
                        <tr id="routeAccountTr" style="display: none; height: 76px">
                            <td>
                                <span id="accountWayType" style="font-size: 20px"></span><br>
                                <span id="accountWayMessage" style="color:#bdbcbc;"></span>
                            </td>
                            <td colspan="3">
                                <input class="form-control" id="wayAccount" name="wayAccount" type="text" autocomplete="off" onkeyup="amount(this.id)">
                            </td>
                        </tr>
                        <!-- 편도일경우 돌아오는편 추가입력 지점, 교통수단선택-->
                        <tr id="asEndWay" style="display: none; height: 76px">
                            <th>
                                <select class="form-select" id="endWay" name="endWay" aria-label="이동방법" onchange="endChangeWay()" >
                                    <option value="noChoice" selected>교통수단</option>
                                    <option value="ship">배</option>
                                    <option value="car">차량</option>
                                    <option value="bus">버스</option>
                                    <option value="train">기차</option>
                                    <option value="air">비행기</option>
                                </select>
                            </th>
                            <th id="endCarTypeHidden" style="padding: 0;text-align: center" valign="middle" colspan="3">
                                <input type="radio" class="form-check-input" name="endCarType" id="endMyCar" value="자차" onclick="checkEndCarType(this.id)" disabled="disabled">
                                <label for="endMyCar"> 자차 </label>&nbsp;&nbsp;
                                <input type="radio" class="form-check-input" name="endCarType" id="endRentalCar" value="렌트" onclick="checkEndCarType(this.id)" disabled="disabled">
                                <label for="endRentalCar"> 렌트 </label>
                                <br><span id="endCarMessage" style="color:#bdbcbc;font-size: 13px">*교통수단이 선택되어야 사용가능합니다.</span>
                            </th>
                        </tr>
                        <!-- 돌아오는날 일자 지정-->
                        <tr id="endFirstTr" style="display: none; height: 76px">
                            <td>
                                <span id="endSelectWayType" style="font-size: 20px"></span><br>
                                <span id="endSelectWayMessage" style="color:#bdbcbc;">*오는날</span>
                            </td>
                            <td colspan="3">
                                <label style="font-size: 13px">항공사, 기차, 버스  회사이름 또는 종류</label>
                                <input class="form-control" name="endAirlineName" type="text" autocomplete="off" placeholder="대한항공, KTX, 우등버스/대원관광" style="font-size: 13px;">
                            </td>

                        </tr>
                        <!-- 금액 지정-->
                        <tr id="endAccountTr" style="display: none;text-align: center; height: 76px" valign="middle">
                            <td>
                                <span id="endAccountWayType" style="font-size: 20px"></span><br>
                                <span id="endAccountWayMessage" style="color:#bdbcbc;"></span>
                            </td>
                            <td colspan="3">
                                <input class="form-control" id="endWayAccount" name="endWayAccount" type="text" autocomplete="off" onkeyup="amount(this.id)">
                            </td>
                        </tr>
                        <!-- 티켓시간, 왕복/편도 가는날-->
                        <tr id="startTicketTime" style="display: none; height: 76px">
                            <td id="timeTd" colspan="3">
                                <div class="row">
                                    <div id="startTimeDiv" class="col" style="width: 50%;display:none">
                                        <label for="startTime" style="font-size: 13px">가는날 티켓 시간</label>
                                        <input class="form-control" id="startTime" name="startTime" type="time" autocomplete="off" aria-label="시간" placeholder="가는날 시간">
                                    </div>
                                    <div id="endTimeDiv" class="col" style="width: 50%;display: none; padding-left: 0;" >
                                        <label for="startTime" style="font-size: 13px">오는날 티켓 시간</label>
                                        <input class="form-control" id="endTime" name="endTime" type="time" autocomplete="off" aria-label="시간" placeholder="오는날 시간" >
                                    </div>
                                </div>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>

            <div style="flex: 1;">
                <table style=" width: 500px" class="table table-bordered bgimg">
                    <thead align="center">
                    <tr style="height: 63px">
                        <th valign="top" colspan="4">
                            <span style="font-size: 20px">숙소편</span><br>
                            <span style="color:#bdbcbc">*숙박일정, 몇박/금액</span>
                        </th>
                    </tr>
                        <tr style="height: 76px" valign="middle">
                            <th valign="middle" style="width: 30%">
                                <span style="font-size: 20px">예약한 숙소</span><br>
                            </th>
                            <th colspan="2">
                                <select class="form-select" id="selectNumber" aria-label="숙소개수" onchange="selectNumberFun()" >
                                    <option value="noChoice" selected>숙소개수</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                </select>
                            </th>
                            <th style="text-align: center;" valign="middle">
                                <input class="form-control" id="totalMoney" name="totalMoney" type="number" autocomplete="off" aria-label="금액" placeholder="총금액" readonly>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="accTbody" >
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                        <tr name="accTr" style="text-align: center; display: none; height: 76px">
                            <td>
                                <label>숙소명<input class='form-control' type='text' name='accNames' placeholder='숙소명'></label>
                            </td>
                            <td colspan='2' width="40%">
                                <label>체크인/체크아웃<input class='form-control checkInOut' type='text' name='checkInOut'></label>
                            </td>
                            <td>
                                <label>금액<input class='form-control' type='text' name='money' onkeyup="amount1(this)"></label>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div style="float:right">
            <button type="button" class="btn btn-danger" style="background-color:#ffa0ac;" onclick="history.go(-1)">이전페이지</button>
            <button type="button" class="btn btn-secondary" onclick="location.href='../index.jsp';">작성취소</button>
            <input type="submit" class="btn btn-primary" style="background-color:#90bddd;" value="작성완료">
        </div>
    </div>
</form>
<script>
    $('.checkInOut').daterangepicker({
        "locale": {
            "format": "YY/MM/DD",
            "separator": " ~ ",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        },
        "startDate": "<%=date[0]%>",
        "endDate": "<%=date[1]%>",
        "drops": "auto"
    });

    $('#startWayDate').daterangepicker({
        "locale": {
            "format": "YY-MM-DD",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        },
        "startDate": "<%=date[0]%>",
        "drops": "auto",
        singleDatePicker: true,
    });
    $('#endWayDate').daterangepicker({
        "locale": {
            "format": "YY-MM-DD",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        },
        "startDate": "<%=date[1]%>",
        "drops": "auto",
        singleDatePicker: true,
    });
    $('#twoWayDate').daterangepicker({
        "locale": {
            "format": "YY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        },
        "startDate": "<%=date[0]%>",
        "endDate": "<%=date[1]%>",
        "drops": "auto"
    });
</script>
</body>
</html>
