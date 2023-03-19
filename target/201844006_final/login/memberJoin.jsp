<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
    <title>회원가입</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/signin.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/modal.css?after" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/addrPopup.js?after"></script> <!-- 주소검색 팝업창 스크립트 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/inputNullCheck.js"></script> <!-- input태그 유효성 검사 -->
    <script>
        function startPage(){
            document.getElementById("nameEffect").style.visibility = "hidden";
            document.getElementById("idEffect").style.visibility = "hidden";
            document.getElementById("pwdEffect").style.visibility = "hidden";
            document.getElementById("pwdChkEffect").style.visibility = "hidden";
            document.getElementById("emailEffect").style.visibility = "hidden";
            document.getElementById("checkSEffect").style.color="gray";
        }
        function idCheck(){
            let memId = frm.memId.value;
            if(isEmpty(memId) || !isId(memId)){
                document.getElementById("idEffect").style.color="red";
                document.getElementById("idEffect").style.visibility = "visible";
                document.frm.memId.focus();
                return false;
            }
            var popupHeight = 200;
            var popupWidth = 460;
            var popupX = (window.screen.width / 2) - (popupWidth / 2);
            var popupY= (window.screen.height / 2) - (popupHeight / 2);
            let url = "${pageContext.request.contextPath}/login/memberJoinIdCheck.jsp?memId="+memId;
            window.open(url, "아이디 중복체크","width="+popupWidth+", height="+popupHeight+", top="+popupY+", left="+popupX);
        }

        function inputIdCheck(){
            document.frm.idDuplication.value = "idUnCheck";
        }
    </script>
</head>
<body>
<div class="modal">
    <div class="modal_body">
        <div class="close close2" style="margin-left: 450px; margin-top: -20px"></div>
        <div class="memJoinColor">
            <h2>회원가입</h2>
            <form name="frm" id="frm" method="post" action="${pageContext.request.contextPath}/login/memberJoinProc.jsp" onsubmit="return isCheck()">
                <div class="row align-items-end">
                    <div class="col-input">
                        <label class="form-label lblMa" for="memName" >이름</label>
                        <label class="form-label lblMa" for="memName" id="nameEffect"> 영어와 한글만 사용하실 수 있습니다.</label>
                        <input class="form-control" id="memName" name="memName" type="text" autocomplete="off">
                    </div>
                    <div class="col-btn">
                        <label class="form-label" id="checkSEffect" style="margin-bottom: -1px">성별</label><br>
                        <input type="radio" class="btn-check" id="M" name="checkS" value = "M" autocomplete="off">
                        <label class="btn btn-outline-primary" for="M">남자</label>
                        <input type="radio" class="btn-check" id="F" name="checkS" value = "W" autocomplete="off">
                        <label class="btn btn-outline-danger" for="F">여자</label>
                    </div>
                </div>
                <div class="row align-items-end">
                    <div class="col-input">
                        <label class="form-label lblMa" for="memId" >아이디</label>
                        <label class="form-label lblMa" for="memId" id="idEffect"> 영어와 숫자만 사용하실 수 있습니다.</label>
                        <input class="form-control" id="memId" name="memId" type="text" maxlength="20" autocomplete="off" onkeydown="inputIdCheck()">
                        <input type="hidden" name="idDuplication" value="idUncheck">
                    </div>
                    <div class="col-btn">
                        <br>
                        <button class="btn btn-primary" type="button" id="memIdCheck" name="memIdCheck" style="width:112px" onclick="idCheck()">중복확인</button>
                    </div>
                </div>
                <div class="row align-items-end">
                    <div style="width: 230px;">
                        <label class="form-label lblMa" for="memPwd" >패스워드</label>
                        <label class="form-label lblMa" for="memPwd" id="pwdEffect"> 8자에서 16자이내</label>
                        <input class="form-control" id="memPwd" name="memPwd"type="password" autocomplete="off">
                    </div>
                    <div style="width: 230px;">
                        <label class="form-label lblMa" for="memPwdCheck">패스워드 확인</label>
                        <label class="form-label lblMa" for="memPwdCheck" id="pwdChkEffect"> 일치하지않습니다.</label>
                        <input class="form-control" id="memPwdCheck" name="memPwdCheck" type="password" autocomplete="off">
                    </div>
                </div>
                <div class="row align-items-end">
                    <div class="col-input-2">
                        <label class="form-label lblMa" for="memEmail">이메일</label>
                        <label class="form-label lblMa" for="memEmail" id="emailEffect">이메일 형식을 지켜주세요.</label>
                        <input class="form-control" id="memEmail" name="memEmail" type="email" placeholder="your@email.com" autocomplete="off">
                    </div>
                </div>
                <div class="row align-items-end">
                    <div class="col-input">
                        <label class="form-label" for="memZipno" style="margin-bottom: -1px">우편번호</label>
                        <input class="form-control" id="memZipno" name="memZipno" type="number" readonly>
                    </div>
                    <div class="col-btn">
                        <button class="btn btn-primary" type="button" onclick="goPopup()" style="width:112px">주소찾기</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-input-2">
                        <label class="form-label" for="memRoadAddr" style="margin-bottom: -1px">도로명주소</label>
                        <input class="form-control" id="memRoadAddr" name="memRoadAddr" type="text" readonly>
                    </div>
                </div>
                <div class="row">
                    <div class="col-input-2">
                        <label class="form-label" for="memAddrDetail" style="margin-bottom: -1px">상세주소</label>
                        <input class="form-control" id="memAddrDetail" name="memAddrDetail" type="text" readonly>
                    </div>
                </div>
                <br>
                <div class="row" align="center">

                    <div class="col-input-2">
                        <button class="btn btn-primary" type="submit" style="width:98px">회원가입</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    const body = document.querySelector('body');
    const modal = document.querySelector('.modal');
    const close = document.querySelector('.close');
    const memberJoinPopup = document.querySelector('.mem-join-popup');


    memberJoinPopup.addEventListener('click', () => {
        modal.classList.toggle('show');

        startPage();
        document.frm.memName.value = null;
        document.frm.memId.value = null;
        document.frm.memPwd.value = null;
        document.frm.memPwdCheck.value = null;
        document.frm.memEmail.value = null;
        document.frm.idDuplication.value = "idUnCheck";
        document.getElementById("M").checked = false;
        document.getElementById("F").checked = false;
        document.frm.memZipno.value = null;
        document.frm.memRoadAddr.value = null;
        document.frm.memAddrDetail.value = null;

        if (modal.classList.contains('show')) {
            body.style.overflow = 'hidden';
        }
    });
    // window.onload = function (){
    //     modal.classList.toggle('show');
    //
    //     if (modal.classList.contains('show')) {
    //         body.style.overflow = 'hidden';
    //     }
    // }

    close.addEventListener('click', () => {
        modal.classList.toggle('show');

        if (modal.classList.contains('show')) {
            body.style.overflow = 'auto';
        }
    });

</script>
</body>
</html>
