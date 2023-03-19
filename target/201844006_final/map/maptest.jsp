<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css?after" rel="stylesheet">
    <title>여행계획세우기</title>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>


    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCH40Xj04LwxQT6gR4PwSuUnIdQjgIVILQ&callback=initMap"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/googleMap.js?after"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/markerSetting.js?after"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/polylineModule.js?after"></script>


    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <style>
        html, body {
            height: 100%;
            width: 100vw;
            margin: 0;
            padding: 0;
        }
        #map-canvas, #map_canvas {
            height: 100%;
            width: 70%;
        }

        @media print {
            html, body {
                height: auto;
            }

            #map_canvas {
                height: 650px;
            }
        }

        #panel {
            position: absolute;
            top: 5px;
            left: 50%;
            margin-left: -180px;
            z-index: 5;
            padding: 5px;
        }
        .sidediv{
            width: 30vw;
            height: 100%;
            display: inline-block;
            position: absolute;
            border: 1px solid #999;
        }
    </style>
</head>
<body>
    <script>
        <c:if test="${id == null}">
            alert("허용되지 않는 접근입니다.");
            location.href = "${pageContext.request.contextPath}/index.jsp";
        </c:if>
    </script>
    <div class="sidediv">
        <jsp:include page="sideBar.jsp"/>
    </div>
    <div align="right" style="display: inline">
        <div id="panel">
            <div class="input-group mb-3" style="width: 530px">
                <select class="form-select" id="mode" aria-label="Default select example" style="font-size: 14px;">
                    <option value="eva" selected>-선택-</option>
                    <option value="TRANSIT">국내</option>
                    <option value="DRIVING">해외</option>
                </select>
                <input type="text" id="start" class="form-control" aria-label="start" placeholder="출발지" style="width:150px">
                <input type="text" id="target" class="form-control" aria-label="end" placeholder="목적지" style="width:150px">
                <button class="btn btn-outline-secondary" type="button" onclick="varSetting();" style="background-color: white">찾기</button>
            </div>
        </div>
        <div id="map-canvas"></div>
    </div>
</body>
</html>