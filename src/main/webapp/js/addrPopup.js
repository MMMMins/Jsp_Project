function goPopup(){
    var pop = window.open("/login/memberJusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}
function jusoCallBack(roadAddrPart1,addrDetail,roadAddrPart2,zipNo){
    // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
    document.frm.memRoadAddr.value = roadAddrPart1 + roadAddrPart2;
    document.frm.memAddrDetail.value = addrDetail;
    document.frm.memZipno.value = zipNo;
}