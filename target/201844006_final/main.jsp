<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title></title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <style>
    .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      user-select: none;
    }

    .img1{
      font-size: 1.125rem;
      background: linear-gradient(
              to top,
              rgba(0,0,0, 0 ) 10%,
              rgba(0,0,0, 0.25 ) 25%,
              rgba(0,0,0, 0.5 ) 50%,
              rgba(0,0,0, 0.75 ) 75%,
              rgba(0,0,0, 1 ) 95%,
              rgba(0,0,0, 1 ) 100%
      ),
      url(img/travel.jpg) no-repeat center;
      background-size: cover;
    }
    .img2{
      font-size: 1.125rem;
      background: linear-gradient(
              to top,
              rgba(0,0,0, 0 ) 10%,
              rgba(0,0,0, 0.25 ) 25%,
              rgba(0,0,0, 0.5 ) 50%,
              rgba(0,0,0, 0.75 ) 75%,
              rgba(0,0,0, 1 ) 95%,
              rgba(0,0,0, 1 ) 100%
      ),
      url(img/td.jpg) no-repeat center;
      background-size: cover;
    }
    .img3{
      font-size: 1.125rem;
      background: linear-gradient(
              to top,
              rgba(0,0,0, 0 ) 10%,
              rgba(0,0,0, 0.25 ) 25%,
              rgba(0,0,0, 0.5 ) 50%,
              rgba(0,0,0, 0.75 ) 75%,
              rgba(0,0,0, 1 ) 95%,
              rgba(0,0,0, 1 ) 100%
      ),
      url(img/why.jpg) no-repeat center;
      background-size: cover;
    }
  </style>
  <link href="css/carousel.css" rel="stylesheet">
</head>
<body>
  <main >
    <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>

      <div class="carousel-inner">
        <div class="carousel-item active" style="height: 100%;">
          <svg class="img1 bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"></svg>
          <div class="container" >
            <div class="carousel-caption text-start" style="padding-bottom: 10rem">
              <h1>여행, 간단하게 계획</h1>
              <h3>여행지 찾기와 각각의 거리를 한눈에, 쉽게 계획하자</h3>
              <p>항상 여행 지역의 명소를 찾고, 숙소와의 거리들을 비교하며 계획했던 지난 날의 여행</p>
              <c:if test="${id == null}">
                <p><a class="btn btn-lg btn-primary" href="login/memberLogin.jsp">지금, 시작하기</a></p>
              </c:if>
              <c:if test="${id != null}">
                <p><a class="btn btn-lg btn-primary" href="map/maptest.jsp">${id}님, 시작하기</a></p>
              </c:if>
            </div>
          </div>
        </div>

        <div class="carousel-item" style="height: 100%;">
          <svg class="img2 bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"></svg>
          <div class="container">
            <div class="carousel-caption text-start" style="padding-bottom: 10rem;">
              <h1>지난날의 나의 여행</h1>
              <h3>기간, 목적, 금액과 나만의 여행 다이어리</h3>
              <p>기록하여 남들과 공유도 하고, 다른 여행 계획의 참고 사항</p>
              <p></p>
              <c:if test="${id == null}">
                <p><a class="btn btn-lg btn-primary" href="login/memberLogin.jsp">지금, 확인하기</a></p>
              </c:if>
              <c:if test="${id != null}">
                <p><a class="btn btn-lg btn-primary" href="map/boardPage.jsp">${id}님, 시작하기</a></p>
              </c:if>
            </div>
          </div>
        </div>

        <div class="carousel-item" style="height: 100%;">
          <svg class="img3 bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"></svg>
          <div class="container">
            <div class="carousel-caption text-end" style="padding-bottom: 10rem;">
              <c:if test="${id == null}">
                <h1>Why</h1>
                <h3>모든걸 간단하게, 쉽게</h3>
                <p>계획부터 기록까지</p>
                <p><a class="btn btn-lg btn-primary" href="login/memberLogin.jsp">로그인하기</a></p>
              </c:if>
              <c:if test="${id != null}">
                <h1>Why</h1>
                <h3>나의 정보는 사소한 것부터, 지금</h3>
                <p>항상 관리하고 변경하자</p>
                <p><a class="btn btn-lg btn-primary" href="Info/memberInfoLogin.jsp">마이페이지</a></p>
              </c:if>
            </div>
          </div>
        </div>
      </div>

      <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </main>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>
