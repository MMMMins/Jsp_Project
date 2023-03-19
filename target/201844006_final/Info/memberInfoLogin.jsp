<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        function inputPwd(){
            let pwdCh = document.getElementById("pwd").value.replace(/ /g,"");
            if(pwdCh.length === 0){
                document.getElementById('pwdMessage').style.display = "";
                document.frmInfo.pwd.focus();
                return false;
            }
        }
    </script>
    <title>마이페이지</title>
</head>
<body style="height: 100%; width: 100%">
<c:if test="${id == null}">
    <script>
        alert("허용되지않은 접근입니다.");
        location.href='${pageContext.request.contextPath}/index.jsp';
    </script>
</c:if>
    <div>
        <jsp:include page="/menubar.jsp"/>
    </div>
    <div style="position: absolute;top:20% ;left: 50%;transform: translate(-50%,-20%)">
        <h3>마이페이지</h3>
    </div>
    <div style="position: absolute;top:45% ;left: 50%;transform: translate(-50%,-45%)">
        <h5>비밀번호 재확인</h5>
    </div>
    <form action="memberInfoProc.jsp" name="frmInfo" method="post" onsubmit="return inputPwd()">
        <div style="width: 100vw; height: 100vh; display: flex; justify-content: center; align-items: center;">
            <div class="row">
                <div class="col">
                    <input class="form-control" type="password" id="pwd" name="pwd" placeholder="비밀번호" autocomplete="off" autofocus="autofocus">
                </div>
                <div class="col-auto"style="display: inline-block">
                    <button type="submit" class="btn btn-outline-primary">확인</button>
                </div>
            </div>
            <span id="pwdMessage" style="color:red; display: none">비밀번호를 입력해주세요</span>
        </div>
    </form>
</body>
</html>
