<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='<c:url value="/resources/css/bootstrap.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/font-awesome/css/font-awesome.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/animate.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
<title>MoodyMoody</title>
</head>

<body class="top-navigation">
<!-- 헤더 부분 -->
<div id="wrapper">
  <div id="page-wrapper" class="gray-bg">
    <div class="row border-bottom white-bg">
      <nav class="navbar navbar-static-top" role="navigation">
            <div class="navbar-header">
                <button aria-controls="navbar" aria-expanded="false" data-target="#navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
                    <i class="fa fa-reorder"></i>
                </button>
                <a href="getBoardList" class="navbar-brand">MoodyMoody</a>
            </div>
            <div class="navbar-collapse collapse" id="navbar">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> 게시판선택 <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-menu">
                            <li><a href="getNoticeList">공지사항</a></li>
                            <li><a href="getBestList">인기글</a></li>
                            <li><a href="getBoardList">무디게시판</a></li>
                        </ul>
                    </li>
                    <c:if test="${user.grade eq Manager}">
                    <li class="dropdown">
                    	<a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> 관리자권한 <span class="caret"></span></a>
                    	<ul role="menu" class="dropdown-menu">
                            <li><a href="getMemberList">회원관리</a></li>
                        </ul>
                    </li>
                    </c:if>
                    
                    <!-- <li class="dropdown">
                        <a aria-expanded="false" role="button" href="" class="dropdown" data-toggle="dropdown"> 앨범 </a>
                    </li>
                    <li class="dropdown">
                        <a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> 상담실 <span class="caret"></span></a>
                        <ul role="menu" class="dropdown-menu">
                            <li><a href="">Menu item</a></li>
                            <li><a href="">Menu item</a></li>
                            <li><a href="">Menu item</a></li>
                            <li><a href="">Menu item</a></li>
                        </ul>
                    </li> -->
                </ul>
                <ul class="nav navbar-top-links navbar-right">
                	<c:choose>
                		<c:when test="${not empty user.id}">
                		<li><b>${user.nickName}</b>님 환영합니다.</li>                	                    
                    	<li>
	                        <a href="loginForm">
	                            <i class="fa fa-sign-out"></i> Log out
	                        </a>
                    	</li>
                		</c:when>
                		<c:otherwise>
                		<li><b>로그인 후 이용해주세요.</b></li>
                		<li>
                			<a href="loginForm">
	                            <i class="fa fa-sign-in"></i> Login
	                        </a>
	                    </li>
                		</c:otherwise>
                	</c:choose>                    
                </ul>
            </div>
        </nav>
<!-- 헤더 끝 부분 -->

<!-- 내 정보창 부분 -->
<div class="col-md-2 ">
<c:if test="${not empty user.id}">
    <div class="ibox">
        <div class="ibox-title">
            <h5>My Page</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content">
        	<div align="center" class="m-t-sm">
            	<h4>${user.nickName}님의 이번 주 Moody차트입니다</h4>
                <div id="userThisWeekChart">
                	<canvas id='doughnutChart' height='129' width='129'></canvas>
                	
                </div>
                <hr>
            </div>
        	
        	<div class="m-t-sm">
        		<input type="button" class="btn btn-primary block full-width m-b" onclick="location.href='chartPage'" value="통계"/>
            </div>
            
            <div class="m-t-sm">
                <input type="button" class="btn btn-primary block full-width m-b" onclick="location.href='insertBoardPage'" value="새글쓰기"/>
            </div>
            
            <div class="m-t-sm">
                <input type="button" class="btn btn-primary block full-width m-b" onclick="location.href='UserPostList'" value="내글 모아보기"/>
            </div>                    
            
            <div class="m-t-sm">
                <a href="updateUserPage"><input type="button" class="btn btn-primary block full-width m-b" value="회원정보 수정"/></a>
            </div>
            <div class="m-t-sm">
                <a href="loginForm"><button class="btn btn-primary block full-width m-b"><i class="fa fa-sign-out"></i>로그아웃</button></a>
            </div>    
        </div>
    </div>
    </c:if>
</div>
<!-- 내 정보창 부분 끝 -->
	<div class="row">
        <div class="col-lg-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                <c:set var="moodyTitle" value="getBoardList"/>
                <c:set var="moodySearch" value="getSerachList"/>
                <c:set var="noticeTitle" value="getNoticeList"/>
                <c:set var="noticeSearch" value="getNoticeSerach"/>
                <c:set var="bestTitle" value="getBestList"/>
                <c:set var="bestSearch" value="getBestSearch"/>
                <c:choose>
                	<c:when test="${BOARD_TYPE eq moodyTitle || BOARD_TYPE eq moodySearch}">
                		<h5>무디게시판</h5>
                	</c:when>
                	<c:when test="${BOARD_TYPE eq noticeTitle || BOARD_TYPE eq noticeSearch}">
                		<h5>공지사항</h5>
                	</c:when>
                	<c:when test="${BOARD_TYPE eq bestTitle || BOARD_TYPE eq bestSearch}">
                		<h5>인기글 게시판</h5>
                	</c:when>
                </c:choose>
                    <div class="ibox-tools">
                    </div>
                </div>
                <div class="ibox-content">            
                <table class="table">
                   <thead>
                       <tr class="ibox-heading"> <!-- 수정부 -->
                           <th style="width: 10%; text-align: center;">글번호</th>
                           <th style="width: 10%;">무디</th>
                           <th style="width: 40%;">글제목</th>
                           <th style="width: 10%;">작성자</th>
                           <th style="width: 10%; text-align: center;">추천수</th>
                           <th style="width: 10%; text-align: center;">작성일</th>
                       </tr>
                   </thead>
                        <tbody>
                        	   <c:forEach items="${BOARD_LIST}" var="index">
                               <tr>
                                   <td style="text-align: center;">${index.bNo}</td>
                                   <td><img class="small-moody" width="30px" src='<c:url value="/resources/img/moody/${index.bMood}.jpg" />'></td>
                                   <td><a href="/getBoard?bNo=${index.bNo}&page=${page}&keyword=${keyword}&type=${type}&boardType=${BOARD_TYPE}">${index.bTitle}</a></td>
                                   <td>${index.nickName}</td>
                                   <td style="text-align: center;" >${index.bLike}</td>
                                   <td style="text-align: center;"> ${index.bRegDate}</td>
                               </tr>
                               </c:forEach>
                        </tbody>
                    </table>
                    <!-- 검색창 체크박스 -->
                    <div class="hr-line-dashed"></div>
                    <div class="row">
	                    <div class="col-lg-9">
	                        <div class="col-lg-10">
	                        		<form id='searchForm' action="getSerachList" method="get">
	                        		<!-- <form id='searchForm' action="getSerachList" method='get'> -->
	                                <select class="btn btn-warning-left" name='type'>                                    
	                                    <option value="T"
	                                    	<c:out value="${searchDTO.type eq 'T'?'selected':''}"/>>
	                                    	 제목</option>
	                                    <option value="C"
	                                    	<c:out value="${searchDTO.type eq 'C'?'selected':''}"/>>
	                                    	 내용</option>
	                                    <option value="W"
	                                    	<c:out value="${searchDTO.type eq 'W'?'selected':''}"/>>
	                                    	 작성자</option>
	                                </select>
	                                <input type="text" class="form-moody-center" name="keyword"     
		                                	value='<c:out value="${keyword}"/>'/>
	                                <input type="hidden" name="page"
	                                	value='<c:out value="1"/>'/>
	                                <input type="hidden" name="boardType" value='<c:out value="${BOARD_TYPE}"/>'/>
	                                <button id="searchbtn" class="btn btn-warning-right">검색</button>
	                            </form>
	                        </div>
                        </div>
                        
                        <span class="col-md-2">
	                        <c:if test="${not empty user.id}">
	                    		<input type="button" class="btn btn-primary block full-width m-b" onclick="location.href='insertBoardPage'" value="글작성"/>
	                    	</c:if>
                        </span>
                        <div class="col-md-12 text-center">
	                        <div class="btn-group">
	                        	<c:if test="${pageDTO.prev}">
	                        	  <button class="btn btn-white" onclick="location.href='/${BOARD_TYPE}?page=${pageDTO.startPage -1}&keyword=${keyword}&type=${type}'"><i class="fa fa-chevron-left"></i></button>
		                          <%-- <li class="btn btn-white"><a href="/getBoardList?page=${page - 1}"><i class="fa fa-chevron-left"></i></a></li> --%>
								</c:if>
								<!-- 만약에 해당 페이지면 눌러져 있는 버튼 -->
									<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
									  <c:choose>
									  	<c:when test="${page eq num}">
									  	  <button id="numbtn" class="btn btn-white active" onclick="location.href='/${BOARD_TYPE}?page=${num}&keyword=${keyword}&type=${type}'">${num}</button>
									  	</c:when>
									  	<c:otherwise>
									  	  <button id="numbtn" class="btn btn-white" onclick="location.href='/${BOARD_TYPE}?page=${num}&keyword=${keyword}&type=${type}'">${num}</button>
									  	</c:otherwise>
									  </c:choose>
									</c:forEach>
								
		                        <c:if test="${pageDTO.next}">
		                          <button class="btn btn-white" onclick="location.href='/${BOARD_TYPE}?page=${pageDTO.endPage +1}&keyword=${keyword}&type=${type}'"><i class="fa fa-chevron-right"></i></button>
		                          <%-- <li class="btn btn-white"><a href="/getBoardList?page=${page + 1}"><i class="fa fa-chevron-right"></i></a></li> --%>
								</c:if>                            
	                       </div>
	                       <!-- 게시판 페이징처리 END -->
                       </div>
                    </div>
                    <!-- 검색창 체크박스END -->
               </div>
           </div>
       </div>
   </div>
</div>
</div>
</div>


</body>

<!-- <footer>
<div class="footer">
      <div class="pull-right">
          part of <strong>Footer</strong> hello world.
      </div>
      <div>
      <strong>TeamProject</strong> Moody Company &copy; 2021-2021
</div>
</div> 
</footer> -->



<!------------ 스크립트구간. ------------>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/plugins/metisMenu/jquery.metisMenu.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/plugins/slimscroll/jquery.slimscroll.min.js" />"></script>


<!-- Sparkline -->
<script type="text/javascript" src="<c:url value="/resources/js/plugins/sparkline/jquery.sparkline.min.js" />"></script>
   
<!-- Custom and plugin javascript -->
<script type="text/javascript" src="<c:url value="/resources/js/inspinia.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/plugins/pace/pace.min.js" />"></script>

<!-- ChartJS-->
<script type="text/javascript" src="<c:url value="/resources/js/plugins/chartJs/Chart.min.js" />"></script>

<script>
$(document).ready(function() {
	function getChart() {
		// get방식 ajax연동
		$.getJSON(url, function(json) {
			var Moody1 = json.Moody1;
			var Moody2 = json.Moody2;
			var Moody3 = json.Moody3;
			var Moody4 = json.Moody4;
			var Moody5 = json.Moody5;			
			
			var total = Moody1 + Moody2 + Moody3 + Moody4+ Moody5;
			//alert(total);
			if(total == 0) {
				$("#doughnutChart").hide();
				$("#userThisWeekChart").append("<img id='imgChart' src='<c:url value='/resources/img/noChart.png' />'>");
			}
			
	    	const DATA_COUNT = 5;
	        const NUMBER_CFG = {count: DATA_COUNT, min: 0, max: 100};

	        const data = {
	            labels: ['행복', '기쁨', '보통', '슬픔', '화남'],
	            datasets: [
	                {
	                label: 'Dataset 1',
	                data:[Moody1,Moody2,Moody3,Moody4,Moody5],
	                backgroundColor: ["#f8ac59","#23c6c8","#ffff00","#1c84c6","#ed5565"],
	                }
	            ]
	        };
	        
	        
	        const config = {
	            type: 'doughnut',
	            data: data,
	            options: {
	                maintainAspectRatio: false,
	                responsive: true,
	                legend: {
	                        display: false
	                },  
	                plugins: {
	                    title: {
	                        display: true,
	                        text: 'Chart.js Doughnut Chart'
	                    }
	                }
	            },
	        };
	        
	        var ctx = $("#doughnutChart");
	        //new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});
	        new Chart(ctx, config);        
		});
	}
	
	//ThisWeekChart
	var url = "/ThisWeekChart.do?t=" + Math.random();
	getChart();
	
	$("#searchbtn").click(function() {		
		var searchForm = $("#searchForm");
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}		
		var boardType1 = "${BOARD_TYPE}";
		
		if((boardType1 == "getNoticeList") || (boardType1 == "getNoticeSerach")) {
			searchForm.attr("action","getNoticeSerach").submit();
			
    	} else if ((boardType1 == "getBestList") || (boardType1 == "getBestSearch")) {
    		searchForm.attr("action","getBestSearch").submit();    		
    		
    	} else if((boardType1 == "getBoardList") || (boardType1 == "getSerachList")) {
    		searchForm.attr("action","getSerachList").submit();
    	}		
	});
});
</script>
</html>