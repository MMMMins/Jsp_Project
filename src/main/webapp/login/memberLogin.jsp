<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html style="height: 100vh;">
<head>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css?after" rel="stylesheet">
    <title>로그인</title>
    <link href="${pageContext.request.contextPath}/css/signin.css?after" rel="stylesheet">
    <script>
        var isEmpty = function(value){
            if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
                return true;
            }else{
                return false;
            }
        };
        function loginCheck(){
            let id = frmlogin.userID.value.replace(/ /g,"");
            let pwd = frmlogin.userPwd.value.replace(/ /g,"");
            if(isEmpty(id)){
                document.frmlogin.userID.focus();
                return false;
            }
            if(isEmpty(pwd)){
                document.frmlogin.userPwd.focus();
                return false;
            }
        }

        function memIdFindPopup(){
            var popupHeight = 400;
            var popupWidth = 460;
            var popupX = (window.screen.width / 2) - (popupWidth / 2);
            var popupY= (window.screen.height / 2) - (popupHeight / 2);
            console.log(popupX+"|"+popupY);
            let url = "${pageContext.request.contextPath}/login/memberIdFind.jsp";
            window.open(url, "아이디 찾기","width="+popupWidth+", height="+popupHeight+", left="+ popupX+", top="+popupY);
        }
        function memPwdFindPopup(){
            var popupHeight = 330;
            var popupWidth = 356;
            var popupX = (window.screen.width / 2) - (popupWidth / 2);
            var popupY= (window.screen.height / 2) - (popupHeight / 2);
            console.log(popupX+"|"+popupY);
            let url = "${pageContext.request.contextPath}/login/memberPwdFind.jsp";
            window.open(url, "비밀번호 찾기","width="+popupWidth+", height="+popupHeight+", left="+ popupX+", top="+popupY);
        }
    </script>
</head>
<body vlink="gray" style="min-height: 100%;">
<script>
    <c:if test="${id != null}">
        alert("허용되지 않는 접근입니다.");
        location.href='${pageContext.request.contextPath}/index.jsp';
    </c:if>
</script>
    <div >
        <jsp:include page="${pageContext.request.contextPath}/menubar.jsp"/>
    </div>
    <div class="login-form" style="height: 100%;padding: 0">
    <main class="form-signin w-100 m-auto">
        <h1 class="h3 mb-3 fw-normal">Login</h1>
        <form action="${pageContext.request.contextPath}/login/memberLoginProc.jsp" name="frmlogin" id="frmlogin" method="post" onsubmit="return loginCheck()">
            <div class = "form-floating">
                <input type="text" class="form-control" name="userID" id="idInput" autocomplete="off">
                <label for="idInput">아이디</label>
            </div>
            <div class = "form-floating">
                <input type="password" class="form-control" name="userPwd" id="pwdInput">
                <label for="pwdInput">비밀번호</label>
            </div>
            <button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
            <hr>
            <div style="text-align: center;" class="div_a">
                <a class="a1" href="#" onclick="memIdFindPopup()">아이디 찾기</a> |
                <a class="a1" href="#" onclick="memPwdFindPopup()">비밀번호 찾기</a> |
                <a class="a1 mem-join-popup" href="#">회원가입</a>
            </div>
        </form>
        <jsp:include page="memberJoin.jsp"/>
    </main>
    </div>
</body>
</html>
