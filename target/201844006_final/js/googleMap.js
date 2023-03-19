let directionsDisplay;
let directionsService = new google.maps.DirectionsService();
let start, end, mode, clickIdx;     // 시작위치, 목적지, 국내/외, 테이블의 인덱스
let total=0, hour, minute;          // 시간 계산 변수
let routeList = {};                 // 경로들의 존재여부 판단
let map;


function initialize() {
    console.log("initialize 함수 시작");
    directionsDisplay = new google.maps.DirectionsRenderer();
    var first = new google.maps.LatLng(37.5400456, 126.9921017);
    var mapOptions = {
        zoom:7,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: first
    }
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    directionsDisplay.setMap(map);
    console.log("initialize 함수 끝");
}


//시작 위도경도랑
function varSetting(){
    console.log("varSetting 함수 시작");
    start = document.getElementById('start').value;
    end = document.getElementById('target').value;
    mode = document.getElementById('mode').value;

    if(document.getElementById('serviceTable').rows.length === 25){
        alert('최대 25개까지 가능합니다!');
        return;
    }
    if(start.length === 0 || end.length === 0){
        alert("출발지와 목적지를 입력해주세요.");
        return;
    }
    if(start === end) {
        alert("출발지와 목적지가 같습니다. 다시 입력해주세요");
        return;
    }
    console.log(mode);
    if(mode === "eva"){
        alert("어디로 떠나시나요~? (국내/해외)");
        return;
    }

    calcRoute(true);
    console.log("varSetting 함수 끝");
}

// 출발지, 도착지 검색
function calcRoute(ckecked) {
    console.log("calcRoute 함수 시작");
    let request = {
        origin:start,
        destination:end,
        travelMode: eval("google.maps.DirectionsTravelMode."+mode)
    };

    directionsService.route(request, function(response, status) {
        //alert(status);  // 확인용 Alert..미사용시 삭제
        if (status === google.maps.DirectionsStatus.OK) {
            let startLoc = response.routes[0].legs[0].start_address;
            let endLoc   = response.routes[0].legs[0].end_address;
            let startEndDist =  response.routes[0].legs[0].distance.value / 1000;
            // 1. 접근방법 : 길찾기(True), 테이블클릭(False)
            // 2. 키 존재 여부
            if(ckecked && Object.keys(routeList).length !== 0){
                // 3. 출발지 키 존재 여부
                // 4. 해당 출발지로 이뤄진 도착지 존재 여부
                if(startLoc in routeList && endLoc in routeList[startLoc]){
                    alert("이미 존재하는 출발지-목적지 경로입니다.");
                    return;
                }
                // 5. 3,4번의 반대의 경로일때, 거리가 같다면
                if(endLoc in routeList && startLoc in routeList[endLoc] && Math.round(startEndDist * 100)/100 === routeList[endLoc][startEndDist]){
                    alert("해당 경로는 기존에 있던 경로의 반대와 같습니다.");
                    return;
                }
            }
            directionsDisplay.setDirections(response);
            let result = directionsDisplay.getDirections();
            computeTotalDistance(result);

            // 1. 접근방법 : 길찾기(True), 테이블클릭(False)
            if(ckecked){
                addRow();
                polylineInsert(response);
            }else{
                polylineInsert(clickIdx);
            }
        }else{
            alert("경로 검색에 문제가 생겼습니다.\n없는 주소이거나 국내/해외 설정이 올바른지 확인해주세요");
        }
        console.log("calcRoute 함수 끝");
    });

    document.getElementById('start').value = null;
    document.getElementById('target').value = null;
}

// 해당 출발지, 도착지 키 삭제
function routeDelete() {
    console.log("routeDelete 함수 시작");
    let request = {
        origin: start,
        destination: end,
        travelMode: eval("google.maps.DirectionsTravelMode." + mode)
    };
    directionsService.route(request, function (response, status) {
        //alert(status);  // 확인용 Alert..미사용시 삭제
        console.log(response);
        delete routeList[response.routes[0].legs[0].start_address][response.routes[0].legs[0].end_address];

        //만약 해당 출발지의 도착지가 아예없다면 해당 출발지를 지워라
        if(Object.keys(routeList[response.routes[0].legs[0].start_address]).length === 0){
            delete routeList[response.routes[0].legs[0].start_address];
        }
    });
    console.log("routeDelete 함수 끝");
}

function computeTotalDistance(result) {
    console.log("computeTotalDistance 함수 시작");
    let time = 0;
    const myroute = result.routes[0];

    if (!myroute) {
        return;
    }

    // 아래 두 변수는 startLoc, endLoc와 같은 기능
    let startTemp = myroute.legs[0].start_address;
    let endTemp = myroute.legs[0].end_address;
    total = myroute.legs[0].distance.value / 1000;
    time = myroute.legs[0].duration.value / 60;
    minute = Math.floor(time % 60);
    hour = Math.floor(time / 60);

    // 경로 오브젝트에 출발지 키가 있다면 목적지 키를 가진 거리를 저장하거나, 없다면 출발지 키를 가진 목적지:거리를 저장해라
    if(startTemp in routeList){
        routeList[startTemp][endTemp] = Math.round(total * 100) / 100;
    }else{
        routeList[startTemp] = {[endTemp]:Math.round(total * 100) / 100};
    }
    console.log("computeTotalDistance 함수 끝");
}

google.maps.event.addDomListener(window, 'load', initialize);