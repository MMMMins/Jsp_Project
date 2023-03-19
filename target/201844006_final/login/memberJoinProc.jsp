<%@ page import="user.UserVO"%>
<%@ page import="user.UserDAO" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%-- memberJoin.jsp -> memberJoinProc.jsp
        파라미터
        memId           -> 회원가입할 ID명
        memPwd          -> 패스워드
        memName         -> 이름
        checkS          -> 성별
        memEmail        -> 이메일
        memZipno        -> 우편번호
        memRoadAddr     -> 도로명
        memAddrDetail   -> 상세주소
    --%>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">

</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("memId");
    String pwd = request.getParameter("memPwd");
    String name = request.getParameter("memName");
    String gender = request.getParameter("checkS");
    String email = request.getParameter("memEmail");
    String zipno = request.getParameter("memZipno");
    String roadAddr = request.getParameter("memRoadAddr");
    String detailAddr = request.getParameter("memAddrDetail");

    UserVO vo = new UserVO(id, pwd, name, gender, email, zipno, roadAddr);
    if(!detailAddr.isEmpty()) vo.setDetailAddr(detailAddr);
    UserDAO dao = new UserDAO();

    int result = 0; // 성공 : 1 | 실패 : 0
    if(dao.insertUser(vo)){
        result = 1;
    }
    request.setAttribute("result",result);
%>
<script>
    <c:if test="${id != null}">
    alert("허용되지 않는 접근입니다.");
    location.href='${pageContext.request.contextPath}/index.jsp';
    </c:if>
    <c:if test="${result == 1}">
    alert("회원가입에 성공하였습니다.\n로그인 후 이용하세요");
    location.href="${pageContext.request.contextPath}/login/memberLogin.jsp";
    </c:if>
    <c:if test="${result == 0}">
    alert("회원가입에 실패하였습니다.\n계속 문제가 진행된다면 관리자에게 문의바랍니다. ");
    location.href="${pageContext.request.contextPath}/login/memberLogin.jsp";
    </c:if>
</script>
</body>
</html>
