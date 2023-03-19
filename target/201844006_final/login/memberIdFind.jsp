<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%-- memberLogin.jsp -> memberIdFind.jsp 팝업창 --%>

    <title>아이디 찾기</title>
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
        }
        function idFind(){
            let memEmail = idFindForm.memIdFind.value;
            if(isEmpty(memEmail) || memEmail.length == 0){
                document.getElementById("memEmailErr").style.color="red";
                document.getElementById("memEmailErr").style.visibility = "visible";
                document.idFindForm.memIdFind.focus();
                return false;
            }else{
                let url = "${pageContext.request.contextPath}/login/memberIdFind.jsp?memIdFind="+memEmail;
                window.open(url, "아이디 찾기","width="+popupWidth+", height="+popupHeight+", top="+popupY+", left="+popupX);
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
<%
    String text = null;
    int use = 0; // 0: 초기, 1: 성공, 2: 실패
    String email = request.getParameter("memIdFind");
    if(email!=null && !email.isEmpty()){
        UserVO vo = new UserVO();
        vo.setEmail(email);
        UserDAO dao = new UserDAO();
        ArrayList<String> result = dao.selectUserIdFind(vo);
        if(result != null && result.size() != 0){
            request.setAttribute("result", result);
            use = 1;
        }else{
            use = 2;
        }
    }
%>

<h2 align="center" style="margin-top: 5px">아이디찾기</h2>
<hr style="margin: -5px 0;">
<form name="idFindForm">
    <div class="row align-items-end" >
        <div class="col-input" style="margin-left: 10px">
            <label class="form-label lblMa" for="memIdFind" >등록하신 이메일</label>
            <label class="form-label lblMa" for="memIdFind" id="memEmailErr">의 형식이 올바르지 않습니다.</label>
            <input class="form-control" id="memIdFind" name="memIdFind" type="email" autocomplete="off">
        </div>
        <div class="col-btn">
            <button class="btn btn-primary" name="memIdFindBtn" style="width:112px" onclick="return idFind()">ID찾기</button>
        </div>
    </div>
    <div style="margin-left: 10px">
        <c:if test="<%=use == 1%>">
            <h3>해당 이메일로 가입된 아이디 목록입니다.</h3>
            <c:forEach items="${result}" varStatus="status">
                <div id="idList">
                    <label>
                        <input type="radio" name="idListbtn" value="${status.current}">${status.current}을(를) 사용하기
                    </label>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="<%=use == 2%>">
            <h3>해당 이메일로 가입된 아이디가 없습니다.</h3>
        </c:if>
    </div>
</form>
<div align="right" style="margin-right: 12px;">
    <input class="btn btn-outline-danger" id="cancelBtn" type="button" value="닫기" onclick="window.close()">
    <input class="btn btn-outline-primary" id="useBtn" type="button" value="사용하기" onclick="sendFindId()">
</div>
<script>
    function sendFindId(){
        if(<%=use == 1%>){
            var id = document.querySelector('input[name="idListbtn"]:checked').value;
            opener.document.frmlogin.userID.value = id;
            self.close();
        }
    }
</script>
</body>
</html>
