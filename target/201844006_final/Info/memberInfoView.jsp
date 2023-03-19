<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/addrPopup.js?after"></script> <!-- 주소검색 팝업창 스크립트 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/inputNullCheck.js?after"></script> <!-- input태그 유효성 검사 -->

    <title>Title</title>
</head>
<body>
<%
    Map<String, String> userData = (HashMap<String, String>) request.getAttribute("userData");
%>
<script>
    let submitCheck = false;
    window.onload = function (){
        let userGender = "<%= userData.get("gender")%>";
        let gender = document.getElementsByName("checkS")
        console.log(userGender);
        if(userGender === "M"){
            gender[0].checked = true;
        }else{
            gender[1].checked = true;
        }
    }

    function updateCheck(){
        let name = document.getElementById("userName").value;
        if(name.length !== name.replace(/ /g, "").length){
            document.getElementById("nameChk").innerHTML = "이름에 공백이 있습니다.";
            document.getElementById("nameChk").style.color = "red";
            return false;
        }else if(!isCorrect(name)){
            document.getElementById("nameChk").innerHTML = "이름은 영문또는 한글만 가능합니다.";
            document.getElementById("nameChk").style.color = "red";
            return false;
        }

        let password = document.getElementById("userPwd").value;
        if(password.length !== password.replace(/ /g,"").length || password !== document.getElementById("userPwdChk").value){
            document.getElementById("pwdChk").innerHTML = "비밀번호가 일치하지않습니다.";
            document.getElementById("pwdChk").style.color = "red";
            return false;
        }
    }
    function chkPwd(){
        document.getElementById("pwdChk").innerHTML="";
    }
    function nameChk(){
        document.getElementById("nameChk").innerHTML="";
    }
</script>
<div style="width: 100%;height: 100%">
    <div>
        <jsp:include page="${pageContext.request.contextPath}/menubar.jsp"/>
    </div>
    <div class="p-5 mb-4 bg-white rounded-10" style="text-align:center; height:580px;position: absolute ;top:45%; left:50%; transform: translate(-50%,-45%)">
        <h4 style="margin-top:10px; margin-bottom:20px;">︎회원정보 변경</h4>
        <form class="form-inline" action="memberUpdate.jsp" method="post" name="frm" onsubmit="return updateCheck()">
            <table class="table table-bordered" style="width:400px; margin-left: auto; margin-right: auto; vertical-align:middle;">
                <tr>
                    <th style="background-color:#F2F2F2">아이디</th>
                    <td><input type="text" class="form-control-plaintext" id="userid" name="userId" value="<%=userData.get("id")%>" style="margin-left:10px;" readonly></td>
                </tr>
                <tr>
                    <th style="background-color:#F2F2F2">비밀번호</th>
                    <td align="center">
                        <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="새 비밀번호" style="margin-bottom:10px;" value="${beforePwd}" onkeyup="chkPwd()">
                        <input type="password" class="form-control" id="userPwdChk" name="userPwdChk" placeholder="새 비밀번호 확인" style="margin-bottom:5px;" value="${beforePwd}" onkeyup="chkPwd()">
                        <span id="pwdChk" style="font-size:14px;"></span>
                    </td>
                </tr>
                <tr>
                    <th style="background-color:#F2F2F2">이름</th>
                    <td>
                        <input type="text" class="form-control sr-only" id="userName" name="userName" value="<%=userData.get("name")%>" style="margin-left:auto; margin-right:auto;" required="required" onkeyup="nameChk()">
                        <span id="nameChk" style="font-size:14px;"></span>
                    </td>
                </tr>
                <tr>
                    <th style="background-color:#F2F2F2">성별</th>
                    <td>
                        <input type="radio" class="btn-check" id="M" name="checkS" value = "M" autocomplete="off">
                        <label class="btn btn-outline-primary" for="M">남자</label>
                        <input type="radio" class="btn-check" id="F" name="checkS" value = "W" autocomplete="off">
                        <label class="btn btn-outline-danger" for="F">여자</label>
                    </td>
                </tr>
                <tr>
                    <th style="background-color:#F2F2F2">이메일</th>
                    <td>
                        <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="<%=userData.get("email")%>" value="<%=userData.get("email")%>" style="margin-left:auto; margin-right:auto; margin-bottom:10px;" required="required">
                    </td>
                </tr>
                <tr>
                    <th style="background-color:#F2F2F2">주소</th>
                    <td>
                        <div class="row" style="width: 100%; margin-bottom: 10px" >
                            <div class="col">
                                <input class="form-control" id="memZipno" name="memZipno" type="number" placeholder="우편번호" value="<%=userData.get("zipCode")%>" style="margin-right: 0" readonly>
                            </div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-outline-success"  style="width: auto;" onclick="goPopup()">조회</button>
                            </div>
                        </div>
                        <input class="form-control" id="memRoadAddr" name="memRoadAddr" type="text" placeholder="도로명" value="<%=userData.get("roadAddr")%>" style="margin-bottom:10px;" readonly>
                        <input class="form-control" id="memAddrDetail" name="memAddrDetail" type="text" placeholder="상세주소" value="<%=userData.get("detailAddr")%>" style="margin-bottom:5px;" readonly>
                    </td>
                </tr>
            </table>
            <button type="submit" class="btn btn-primary">변경</button>
            <button type="button" class="btn btn-outline-secondary" onclick="location.href='../index.jsp'">취소</button>
        </form>
    </div>
    <table>
    </table>
</div>
</body>
</html>
