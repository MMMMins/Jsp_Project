let polyIdx=0;              // 경로들의 각각의 인덱스
let polylineList = [];      // 경로들의 위,경도 집합 2차원 배열로 저장
let polylinePath = [];      // 경로들의 위,경도 집합으로 폴리라인 설정
let colorObj = {};          // 경로들의 각각의 인덱스로 컬러값을 조정함
let colorList =             // 컬러리스트 빨-주-노-초-파-보 순서로 진행됨
    ["#ff0000","#FF8C00","#FFFF00","#008000","#0000FF","#800080"]

// 폴리라인을 그려주는 함수
// 매개변수 poly
//          처음 경로를 그릴때 response 값
//          테이블의 값 클릭시 해당 경로를 보여주기 위해 해당 리스트를 출력하는 인덱스값
function polylineInsert(poly){
    console.log("polylineInsert 선을 긋는다.")
    let temp=[];            // 각각의 경로의 위,경도를 저장하기 위한 임시변수
    if(typeof poly != "string"){
        for (let i = 0 ; i < poly.routes[0].overview_path.length;i++){
            temp.push(poly.routes[0].overview_path[i]);
        }

        colorObj[cellIdxValue-1] = 0;
        polylineList.push(temp);
        polylinePath.push(new google.maps.Polyline({
            path: polylineList[polyIdx],
            strokeColor: colorList[colorObj[cellIdxValue-1]],
            strokeOpacity: 1.0,
            strokeWeight: 4
        }));

        polylinePath[polyIdx].setMap(map);
        polyIdx++;
    }else{
        polylinePath[poly].setMap(null);
        polylinePath[poly] = (new google.maps.Polyline({
            path: polylineList[poly],
            strokeColor: colorList[colorObj[poly] === 5 ? colorObj[poly] = 0 : ++colorObj[poly]],
            strokeOpacity: 1.0,
            strokeWeight: 4
        }));
        polylinePath[poly].setMap(map);
    }
}

// 위,경도 정보 삭제 및 폴리라인 지우기
// 매개변수 delIdx -> 테이블에 숨겨진 인덱스값을 가져와서 해당 인덱스의 값들을 다 삭제
function polylineDelete(delIdx){
    polylinePath[delIdx].setMap(null);
    polylineList[delIdx] = null;
    polylinePath[delIdx] = null;
}
