<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
 <div class="col-md-2 ">
    </div>
	<div class="row">
        <div class="col-lg-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                <h5>회원관리</h5>                
                    <div class="ibox-tools">
                    </div>
                </div>
                <div class="ibox-content">            
                <table class="table">
                   <thead>
                       <tr class="ibox-heading"> <!-- 수정부 -->
                           <th style="width: 10%;">아이디</th>
                           <th style="width: 10%;">닉네임</th>
                           <th style="width: 10%;">패스워드</th>
                           <th style="width: 10%;">이메일</th>
                           <th style="width: 10%; text-align: center;">가입일</th>
                           <th style="width: 10%; text-align: center;">회원권한</th>
                           <th style="width: 10%;">회원탈퇴</th>
                       </tr>
                   </thead>
                        <tbody>
                        	   <c:forEach items="${MEM_LIST}" var="index" varStatus="status">
                               <tr>
                                   <td>${index.id}</td>
                                   <td>${index.nickName}</td>
                                   <td>${index.password}</td>
                                   <td>${index.email}</td>
                                   <td style="text-align: center;" >${index.regDate}</td>
                                   <td style="text-align: center;"> ${index.grade}</td>
                                   <td>                                   
                                   <a id='deletebtn${status.count}' href='deleteMember?id=${index.id}&page=${page}&keyword=${keyword}&type=${type}&boardType=${searchDTO.boardType}'>탈퇴</a>
                                   </td>                                   
                               </tr>
                               </c:forEach>
                        </tbody>
                    </table>
                    <!-- 검색창 체크박스 -->
                    <div class="hr-line-dashed"></div>
                    <div class="row">
	                    <div class="col-lg-9">
	                        <div class="col-lg-10">
	                        		<form id='searchForm' action="getMemberSerachList" method="get">
	                        		<!-- <form id='searchForm' action="getSerachList" method='get'> -->
	                                <select class="btn btn-warning-left" name='type'>                                    
	                                    <option value="I"
	                                    	<c:out value="${searchDTO.type eq 'I'?'selected':''}"/>>
	                                    	아이디</option>
	                                    <option value="N"
	                                    	<c:out value="${searchDTO.type eq 'N'?'selected':''}"/>>
	                                    	닉네임</option>
	                                    <option value="G"
	                                    	<c:out value="${searchDTO.type eq 'G'?'selected':''}"/>>
	                                    	회원권한</option>
	                                </select>
	                                <input type="text" class="form-moody-center" name="keyword"     
		                                	value='<c:out value="${keyword}"/>'/>
	                                <input type="hidden" name="page"
	                                	value='<c:out value="1"/>'/>
	                                <input type="hidden" name="boardType" value='<c:out value="getMemberSerachList"/>'/>
	                                <button id="searchbtn" class="btn btn-warning-right">검색</button>
	                            </form>
	                        </div>
                        </div>
                        
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
	
	var memList = ${MEM_LIST.size()};
	
	$("#searchbtn").click(function() {
		var searchForm = $("#searchForm");
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}		
	});
	
	for(var i = 1; i <= memList; i++) {
		$("#deletebtn" + i).click(function(){ // 회원탈퇴 물어보는 알림창. 실행안됨
			var resultSet = confirm("이 회원을 정말 탈퇴처리 하시겠습니까?");
			if(!resultSet){			
				return false;
			}
		});
	}
});
</script>
</html>