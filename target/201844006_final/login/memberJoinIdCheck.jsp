<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="user.UserVO" %>
<%@ page import="user.UserDAO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--  memberJoin.jsp -> memberJoinIdCheck.jsp
        넘어오는 파라미터
          memId -> 중복확인 할 아이디

    --%>
    <title>아이디 중복확인</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/signin.css?after" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/modal.css?after" rel="stylesheet">

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
    boolean use = false;
    String memid = request.getParameter("memId");
    if(!memid.isEmpty() && memid.replaceAll("^[A-za-z0-9]{5,20}", "").length()==0){

        UserVO vo = new UserVO();
        vo.setId(memid);
        UserDAO dao = new UserDAO();

        if(dao.selectUserIdCheck(vo)){
            text = memid +"(은)는 사용 불가능한 아이디입니다.";
        }else{
            text = memid +"(은)는 사용 가능한 아이디입니다.";
            use = true;
        }

    }else{
        text = memid +"(은)는 사용 불가능한 아이디입니다.";
    }
%>
    <form name="chkForm">
        <div class="row align-items-end">
            <div class="col-input">
                <label class="form-label lblMa" for="memIdCheck" >아이디</label>
                <input class="form-control" id="memIdCheck" name="memId" type="text" value="<%=request.getParameter("memId")%>">
            </div>
            <div class="col-btn">
                <button class="btn btn-primary" name="memIdCheck" style="width:112px" onclick="idCheck()">중복확인</button>
            </div>
        </div>
        <div style="align-content: center">
            <%=text%>
        </div>
    </form>
    <div style="align-content: center">
        <input class="btn btn-outline-danger" id="cancelBtn" type="button" value="닫기" onclick="window.close()">
        <input class="btn btn-outline-primary" id="useBtn" type="button" value="사용하기" onclick="sendCheckValue()">
    </div>
    <script>
        function sendCheckValue(){
            var use = <%=use%>
            if(use == true){
                opener.document.frm.idDuplication.value = "idCheck";
                opener.document.frm.memId.value = document.getElementById("memIdCheck").value;
                self.close();
            }
        }
    </script>
</body>
</html>
