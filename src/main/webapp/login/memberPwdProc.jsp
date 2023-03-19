<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    /*
        memberPwdFind.jsp -> memberPwdProc.jsp
     */
%>
<head>
    <title>비밀번호 변경</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/signin.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/modal.css?after" rel="stylesheet">
    <script>
        window.onload = function (){
            document.getElementById("memPwdErr").style.visibility = "hidden";
            document.getElementById("memPwdCheckErr").style.visibility = "hidden";
        }
        function isPwdChangeCheck(){
            let memPwd       = pwdChangeForm.memNewPwd.value;
            let memPwdCheck  = pwdChangeForm.memNewPwdCheck.value;

            if(isEmpty(memPwd) || isPassword(memPwd)){
                document.getElementById("memPwdErr").style.color="red";
                document.getElementById("memPwdErr").style.visibility = "visible";
                document.pwdChangeForm.memNewPwd.focus();
                return false;
            }
            if(memPwd == memPwdCheck){
                document.getElementById("memPwdCheckErr").style.color="red";
                document.getElementById("memPwdCheckErr").style.visibility = "visible";
                document.pwdChangeForm.memNewPwdCheck.focus();
                return false;
            }
        }
    </script>
</head>
<body>
<%
    /*
        넘어오는 파라미터값
        이메일 : memEmailToPwdFind
        아이디 : memIdToPwdFind
        이름  : memNameToPwdFind
     */
    String email = request.getParameter("memEmailToPwdFind");
    String id    = request.getParameter("memIdToPwdFind");
    String name  = request.getParameter("memNameToPwdFind");

    UserVO vo = new UserVO();
    vo.setEmail(email);
    vo.setName(name);
    vo.setId(id);
    UserDAO dao = new UserDAO();
    if(!dao.selectUserPwdFind(vo)){
%>
        <script>
            alert("정보가 일치하지않습니다.");
            history.go(-1);
        </script>
<%
    }
%>

<h2 align="center" style="margin-top: 5px">비밀번호변경</h2>
<hr style="margin: -5px 0;">
<form name="pwdChangeForm" action="memberPwdChange.jsp" onsubmit="isPwdChangeCheck()">
    <div class="row align-items-end">
        <div class="col-input" style="margin-left: 10px">
            <label class="form-label lblMa" for="memNewPwd" >새 비밀번호</label>
            <label class="form-label lblMa" for="memNewPwd" id="memPwdErr"> | 8자에서 16자 이내</label>
            <input class="form-control" id="memNewPwd" name="memNewPwd" type="password" autocomplete="off">
        </div>
        <div class="col-input" style="margin-left: 10px">
            <label class="form-label lblMa" for="memNewPwdCheck" >비밀번호 확인</label>
            <label class="form-label lblMa" for="memNewPwdCheck" id="memPwdCheckErr"> | 비밀번호가 일치하지 않습니다.</label>
            <input class="form-control" id="memNewPwdCheck" name="memNewPwdCheck" type="password" autocomplete="off">
        </div>
        <div class="col-btn" align="right" style="width: 100vw;padding-right: 20px;margin-top:10px;">
            <input class="btn btn-outline-danger" id="cancelBtn" type="button" value="닫기" onclick="window.close()">
            <input class="btn btn-outline-primary" id="useBtn" type="submit" value="찾기">
            <input type="hidden" name="id" value="<%=id%>">
        </div>
    </div>
</form>
</body>
</html>
