<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <title>Directions service</title>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

    <!-- 선관련 JS -->


    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <style>
        .lblMa{
            margin-top : 10px;
            margin-bottom: -5px;
        }
         .btnCursor {
            cursor: pointer;
            color : blue;
         }
    </style>
    <script>
        function reloadPage(){
            let reloadChoice = confirm("정말 초기화하시나요?\n입력하신 모든값이 사라집니다?");
            if(reloadChoice){
                location.reload();
            }else{
                return false;
            }
        }

        let cellIdxValue = 0;
        function addRow(){
            let code1="<tr><td hidden>"+cellIdxValue+"<input type='hidden' value='"+cellIdxValue+"' name='rowData'></td>"
                +"<td>"+start+"<input type='hidden' value='"+start+"' name='rowData'></td>"
                +"<td>"+end+"<input type='hidden' value='"+end+"' name='rowData'></td>" //추가한 행에 원하는  요소추가
                +"<td align='center'>"+Math.round(total * 100) / 100+"<input type='hidden' value='"+Math.round(total * 100) / 100+"Km' name='rowData'>km</td>"
                +"<td onclick='event.cancelBubble=true;' align='center'><input type='checkbox'></td>"
                +"<td hidden>"+mode+"<input type='hidden' value='"+mode+"' name='rowData'></td>"
                +"<td hidden>"+hour+":"+minute+"<input type='hidden' value='"+hour+":"+minute+"' name='rowData'></td>"
                +"<input type='hidden' value='last%' name='rowData'></tr>";
            document.getElementById('serviceTable').innerHTML += code1;
            cellIdxValue++;
        }

        function remove_row() {//행 삭제
            var tableChecked = document.getElementById('serviceTable');
            for(var i=0 ; i<tableChecked.rows.length; i++){
                var delIdx = Number(tableChecked.rows[i].cells[0].childNodes[0].textContent);
                start = tableChecked.rows[i].cells[1].childNodes[0].textContent;
                end = tableChecked.rows[i].cells[2].childNodes[0].textContent;
                var chkTable = tableChecked.rows[i].cells[4].childNodes[0].checked;
                mode = tableChecked.rows[i].cells[5].childNodes[0].textContent;
                console.log(delIdx+"|"+start+"|"+end+"|"+chkTable+"|"+mode);

                if(chkTable){
                    polylineDelete(Number(delIdx));
                    routeDelete();
                    tableChecked.deleteRow(i);
                    if(before == clickIdx){
                        before = -1;
                    }
                    i--;
                }
            }
        }
    </script>
</head>
<body>
<form action="planWrite.jsp" method="post" onsubmit="return nextPage()">
    <div style="width: 100%;">
        <div style="margin-top: 10px">
            <div style="margin: 0 10px">
                <label class="form-label lblMa" for="travelTit" >계획 타이틀</label>
                <input class="form-control" id="travelTit" name="travelTit" type="text" autocomplete="off">
            </div>
            <div style="margin: 0 10px;">
                <label class="form-label lblMa" for="schedule" >기간</label>
                <input class="form-control" id="schedule" name="schedule" type="text" autocomplete="off">
            </div>
            <script>
                $('#schedule').daterangepicker({
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
                    "startDate": new Date(),
                    "endDate": new Date(),
                    "drops": "auto"
                });
            </script>
        </div>
        <table id="markerListTable" class="table table-hover" style="margin-top: 5px">
            <thead>
            <tr align="center">
                <th hidden>번호</th>
                <th style="width: 30%;">기준점</th>
                <th style="width: 30%;">목적지</th>
                <th style="width: 20%;">소요시간</th>
                <th style="width: 20%;"><span class="btnCursor" onclick="remove_row()" >삭제</span></th>
                <th hidden>국내/외</th>
            </tr>
            </thead>
            <tbody id="serviceTable">
            </tbody>
        </table>
        <div style="bottom:2px;position: absolute;right:2px">
            <button type="button" class="btn btn-outline-secondary" onclick="location.href='../index.jsp';">돌아가기</button>
            <button type="button" class="btn btn-outline-danger" onclick="reloadPage()">다시작성</button>
            <button type="button" class="btn btn-outline-danger" onclick="clearOverlays()">마커삭제</button>
            <button type="button" class="btn btn-outline-success" onclick="targetMarking()">마커찍기</button>
            <button type="submit" class="btn btn-outline-primary">세부계획</button>
        </div>
        <script>
            // 테이블의 Row 클릭시 값 가져오기
            let before = -1;
            $("#serviceTable").on('click',"tr" ,function(){
                clickIdx = $(this).find("td:eq(0)").text();
                start = $(this).find("td:eq(1)").text();
                end = $(this).find("td:eq(2)").text();
                mode = $(this).find("td:eq(5)").text();
                console.log(clickIdx+"|"+start+"|"+end+"|"+mode);
                if(before != clickIdx){
                    calcRoute(false);
                    before = clickIdx;
                }
            });
        </script>
    </div>
</form>
</body>
</html>
