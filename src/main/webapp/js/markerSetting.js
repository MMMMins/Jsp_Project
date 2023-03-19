var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var markerLabel  = 65;   // 도착지 마커 라벨 아스키코드 'A'부터 시작
var startMarkers = [];   // 출발지 마커 목록
var endMarkers   = [];   // 도착지 마커 목록
var startAddress = [];   // 마커찍을 시작주소
var endAddress   = [];   //마커찍은 도착주소

//마커찾기를 누르면 초기화 후 진행
function clearOverlays() {
    console.log("clearOverlays 함수 시작");
    for (var i = 0; i < endMarkers.length; i++ ) {
        endMarkers[i].setMap(null);
    }
    console.log(startMarkers);
    for (var j = 0; j < startMarkers.length; j++ ) {
        startMarkers[j].setMap(null);
    }

    directionsDisplay.setMap(null);``
    startMarkers.length = 0;
    startAddress.length = 0;
    endMarkers.length   = 0;
    endAddress.length   = 0;
    markerLabel         = 65;
    geocoder            = new google.maps.Geocoder();
    infowindow          = new google.maps.InfoWindow();
    console.log("clearOverlays 함수 끝");
}


function targetMarking() {
    console.log("targetMarking 함수 시작");
    clearOverlays();
    geocodeAddress(geocoder, map);
    console.log("targetMarking 함수 끝");
}

function geocodeAddress(geocoder, resultMap) {
    console.log("geocodeAddress 함수 시작");
    // 주소 설정
    let latValue = 0;
    let lngValue = 0;
    let markerIdx = 0;
    var tableChecked = document.getElementById('serviceTable');
    directionsDisplay.setMap(map);
    for(var i=0 ; i<tableChecked.rows.length; i++){
        if(!(tableChecked.rows[i].cells[1].innerHTML in startAddress)){
            startAddress.push(tableChecked.rows[i].cells[1].innerText);
        }
        if(!(tableChecked.rows[i].cells[2].innerHTML in endAddress)){
            endAddress.push(tableChecked.rows[i].cells[2].innerText);
        }
    }

    //마커찍을 위치들을 하나씩 가져와서 마커를 찍는다
    endAddress.forEach((addr) => {
        console.log(addr);
        geocoder.geocode({'address': addr}, function(result, status) {
            console.log(result+"||"+status);

            if (status === 'OK') {

                //맵 중앙에 마커찍기
                latValue += result[0].geometry.location.lat();
                lngValue += result[0].geometry.location.lng();
                console.log(latValue,"|",lngValue);
                //맵 중앙에 위치 x1...xn / n + y1...yn / n
                markerIdx++;
                console.log(latValue/markerIdx+"+ㅁㄴㅇㅁㄴㅇ"+lngValue/markerIdx+"ㅁㄴㅇㅁㄴ");

                resultMap.setCenter(new google.maps.LatLng(latValue/markerIdx,lngValue/markerIdx));
                // 맵 마커
                var marker = new google.maps.Marker({
                    label: String.fromCharCode(markerLabel++),
                    name : addr,
                    map: resultMap,
                    position: result[0].geometry.location
                });

                //마커에 설명쓰기
                marker.addListener("click", () => {
                    infowindow.setContent(addr);
                    infowindow.open({
                        anchor: marker,
                        map,
                    });
                });
                endMarkers.push(marker);

                console.log('위도(latitude) : ' + marker.position.lat());
                console.log('경도(longitude) : ' + marker.position.lng());
                console.log(''+addr);
            } else if(status === 'OVER_QUERY_LIMIT'){
                alert('5초후에 다시 시도해주세요.');
            }else{
                alert('지오코드가 다음의 이유로 성공하지 못했습니다 : ' + status);
            }
        });
    });

    startAddress.forEach((addr) => {
        console.log(addr);
        geocoder.geocode({'address': addr}, function(result, status) {
            console.log(result+"||"+status);

            if (status === 'OK') {
                // 맵 마커
                var marker = new google.maps.Marker({
                    label: "*",
                    name : addr,
                    map: resultMap,
                    position: result[0].geometry.location
                });

                //마커에 설명쓰기
                marker.addListener("click", () => {
                    infowindow.setContent(addr);
                    infowindow.open({
                        anchor: marker,
                        map,
                    });
                });
                startMarkers.push(marker);

            } else if(status === 'OVER_QUERY_LIMIT'){
                alert('5초후에 다시 시도해주세요.');
            }else{
                alert('지오코드가 다음의 이유로 성공하지 못했습니다 : ' + status);
            }
        });
    });
    console.log("geocodeAddress 함수 끝");
}