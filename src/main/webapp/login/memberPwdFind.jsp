<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%-- memberLogin.jsp -> memberPwdFind.jsp 팝업창 --%>
    <title>비밀번호 찾기</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/signin.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/modal.css?after" rel="stylesheet">
    <script>
        var isEmpty = function(value){
            if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
                return true;
            }else{
                return false;
            }
        };
        window.onload = function (){
            document.getElementById("memEmailErr").style.visibility = "hidden";
            document.getElementById("memIdErr").style.visibility = "hidden";
            document.getElementById("memNameErr").style.visibility = "hidden";
        }
        function isPwdFindCheck1(){
            let memEmail = pwdFindForm.memEmailToPwdFind.value;
            let memName  = pwdFindForm.memNameToPwdFind.value;
            let memId    = pwdFindForm.memIdToPwdFind.value;

            if(isEmpty(memEmail)){
                document.getElementById("memEmailErr").style.color="red";
                document.getElementById("memEmailErr").style.visibility = "visible";
                document.pwdFindForm.memEmailToPwdFind.focus();
                return false;
            }
            if(isEmpty(memName) || isId(memId)){
                document.getElementById("memIdErr").style.color="red";
                document.getElementById("memIdErr").style.visibility = "visible";
                document.pwdFindForm.memNameToPwdFind.focus();
                return false;
            }
            if(isEmpty(memName) || isCorrect(memName)){
                document.getElementById("memNameErr").style.color="red";
                document.getElementById("memNameErr").style.visibility = "visible";
                document.pwdFindForm.memIdToPwdFind.focus();
                return false;
            }
        }
    </script>
</head>
<body>
<script>
    <c:if test="${id != null}">
    alert("허용되지 않는 접근입니다.");
    location.href='${pageContext.request.contextPath}/index.jsp';
    </c:if>
</script>
<h2 align="center" style="margin-top: 5px">비밀번호찾기</h2>
<hr style="margin: -5px 0;">
<form name="pwdFindForm" action="memberPwdProc.jsp" onsubmit="return isPwdFindCheck1()">
        <div class="col-input" style="margin-left: 10px">
            <label class="form-label lblMa" for="memEmailToPwdFind" >등록하신 이메일</label>
            <label class="form-label lblMa" for="memEmailToPwdFind" id="memEmailErr">의 형식이 올바르지 않습니다.</label>
            <input class="form-control" id="memEmailToPwdFind" name="memEmailToPwdFind" type="email" autocomplete="off">
        </div>
        <div class="col-input" style="margin-left: 10px">
            <label class="form-label lblMa" for="memIdToPwdFind" >등록하신 아이디</label>
            <label class="form-label lblMa" for="memIdToPwdFind" id="memIdErr">의 형식이 올바르지 않습니다.</label>
            <input class="form-control" id="memIdToPwdFind" name="memIdToPwdFind" type="text" autocomplete="off">
        </div>
        <div class="col-input" style="margin-left: 10px">
            <label class="form-label lblMa" for="memNameToPwdFind" >가입자의 이름</label>
            <label class="form-label lblMa" for="memNameToPwdFind" id="memNameErr">의 형식이 올바르지 않습니다.</label>
            <input class="form-control" id="memNameToPwdFind" name="memNameToPwdFind" type="text" autocomplete="off">
        </div>
        <div class="col-btn" align="right" style="width: 100vw;padding-right: 20px;margin-top:10px;">
            <input class="btn btn-outline-danger" id="cancelBtn" type="button" value="닫기" onclick="window.close()">
            <button class="btn btn-outline-primary" id="useBtn" type="submit" >찾기</button>
        </div>
</form>
</body>
</html>
