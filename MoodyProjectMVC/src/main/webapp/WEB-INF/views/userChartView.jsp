<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>MoodyMoody</title>
    <link href='<c:url value="/resources/css/bootstrap.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/font-awesome/css/font-awesome.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/animate.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
</head>
<body class="top-navigation">
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
            <div class="wrapper wrapper-content  animated fadeInRight article">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1"></div>
                <div class="ibox">
                        <div class="text-center col-md-12">  
                            <div class="col-md-1">
                            </div>
                            <div class="col-md-2 ">
                                <h3>지난주 통계</h3>
                                <div id="chartdiv2">
                                    <canvas id="LastWeekChart" height="129" width="129"></canvas>
                                </div>
                                <div class="text-left" id="chartRate2">
                                </div>
                            </div>
                            <div class="col-md-2 ">
                                <h3>이번주 통계</h3>
                                <div id="chartdiv3">
                                    <canvas id="ThisWeekChart" height="129" width="129"></canvas>
                                </div>
                                <div class="text-left" id="chartRate3">
                                </div>
                            </div>
                            <div class="col-md-2 ">
                                <h3>이번달 통계</h3>
                                <div id="chartdiv4">
                                    <canvas id="ThisMonthChart" height="129" width="129"></canvas>
                                </div>
                                <div class="text-left" id="chartRate4">
                                </div>
                            </div>
                            <div class="col-md-2 ">
                                <h3>이번년 통계</h3>
                                <div id="chartdiv5">
                                    <canvas id="ThisYearChart" height="129" width="129"></canvas>
                                </div>
                                <div class="text-left" id="chartRate5">
                                </div>
                            </div>
                            <div class="col-md-2 ">
                                <h3>통합 통계</h3>
                                <div id="chartdiv1">
                                    <canvas id="TotalChart" height="129" width="129"></canvas>
                                </div>
                                <div class="text-left" id="chartRate1">
                                </div>
                            </div>                                                    
                        </div> 
                        <div class="text-center mail-body text-right tooltip-demo">
                            <a href="getBoardList" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="cancel write">목록으로</a>
                        </div>
                        </div>
                    </div>
                </div>       
            </div>
        </div>
    </div>
    </body>
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

<script type="text/javascript">

$(document).ready(function() {
	function getChart(url,ctx,div,chartRate) {
		// get방식 ajax연동
		$.getJSON(url, function(json) {
			var Moody1 = parseInt(json.Moody1);
			var Moody2 = parseInt(json.Moody2);
			var Moody3 = parseInt(json.Moody3);
			var Moody4 = parseInt(json.Moody4);
			var Moody5 = parseInt(json.Moody5);			
			var total = Moody1 + Moody2 + Moody3 + Moody4+ Moody5;
			//alert(total);
			if(total == 0) {
				ctx.hide();
				div.append("<img width='132' src='<c:url value='/resources/img/noChart.png' />'>");
				
				return false;				
			}
			
			chartRate.append("<p>1. 행복 : " + Moody1 + "</p>");
			chartRate.append("<p>2. 기쁨 : " + Moody2 + "</p>");
			chartRate.append("<p>3. 보통 : " + Moody3 + "</p>");
			chartRate.append("<p>4. 슬픔 : " + Moody4 + "</p>");
			chartRate.append("<p>5. 화남 : " + Moody5 + "</p>");
						
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
	        new Chart(ctx, config);
	        /* 
	        // 도넛차트 번호
	        var ctx4 = $("#doughnutChart");
	        //new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});
	        new Chart(ctx4, config); */        
		});
	}
	
	//TotalChart
	var url1 = "/ChartTotal.do?t=" + Math.random();
	var ctxTotal = $("#TotalChart");
	var chartdiv1 = $("#chartdiv1");
	var chartRate1 = $("#chartRate1");
	getChart(url1,ctxTotal,chartdiv1,chartRate1);    
    
  	//LastWeekChart
	var url2 = "/lastWeekChart.do?t=" + Math.random();	
	var ctxLast = $("#LastWeekChart");
	var chartdiv2 = $("#chartdiv2");
	var chartRate2 = $("#chartRate2");
	getChart(url2,ctxLast,chartdiv2,chartRate2);    
    //new Chart(ctxlast, config);
    
 	//ThisWeekChart
	var url3 = "/ThisWeekChart.do?t=" + Math.random();	
	var ctxThisWeek = $("#ThisWeekChart");
	var chartdiv3 = $("#chartdiv3");
	var chartRate3 = $("#chartRate3");
	getChart(url3,ctxThisWeek,chartdiv3,chartRate3);    
    //new Chart(ctxWeek, config);
    
  	//ThisMonthChart
	var url4 = "/ThisMonthChart.do?t=" + Math.random();
	var ctxThisMonth = $("#ThisMonthChart");
	var chartdiv4 = $("#chartdiv4");
	var chartRate4 = $("#chartRate4");
	getChart(url4,ctxThisMonth,chartdiv4,chartRate4);    
    //new Chart(ctxMonth, config);
    
  	//ThisYearChart
	var url5 = "/ThisYearChart.do?t=" + Math.random();	
	var ctxThisYear = $("#ThisYearChart");
	var chartdiv5 = $("#chartdiv5");
	var chartRate5 = $("#chartRate5");
	getChart(url5,ctxThisYear,chartdiv5,chartRate5);    
    //new Chart(ctxYear, config);
});
	
</script>

</html>