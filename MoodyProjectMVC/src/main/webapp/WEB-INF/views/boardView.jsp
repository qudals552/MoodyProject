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
        
<div id="page-wrapper" class="gray-bg">
     <div class="row border-bottom white-bg">
        <div class="wrapper wrapper-content  animated fadeInRight article">
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1">
                <div class="ibox">
                        <div class="text-center ">
                            <h2>
                                <img class="small-moody" width="60px" src='<c:url value="/resources/img/moody/${boardDTO.bMood}.jpg" />'>
                                 <b>${boardDTO.bTitle}</b>
                            </h2>
                            <span class="text-muted text-right ">NO : ${boardDTO.bNo} || 작성자 : ${boardDTO.nickName} || <i class="fa fa-clock-o"></i> ${boardDTO.bRegDate}</span>
                            <div align="left" class="social-body">      
                                <textarea class="input-moody" rows="10" name="content" readonly
                                style="user-select:none; border:none; resize:none; margin: 0px 1% 1% 0px; height: 100%; width: 100%;">${boardDTO.bContent}</textarea>
                            </div>
                            <div id="recommend">
                            <button id="recommendbtn" class="btn btn-sm btn-white"><i class="fa fa-thumbs-o-up" style="color: red;"></i> 추천${boardDTO.bLike}</button>
                            <%-- <button id="recommendbtn" type="button" onclick="location.href='/recommend?bNo=${boardDTO.bNo}&page=${searchDTO.page}&type=${searchDTO.type}&keyword=${searchDTO.keyword}&boardType=${searchDTO.boardType}'">추천${boardDTO.bLike}</button> --%>
                        	</div>
                        </div>
                                             
                        <div class="mail-body text-right tooltip-demo">
                            <a href="/${searchDTO.boardType}?page=${searchDTO.page}&type=${searchDTO.type}&keyword=${searchDTO.keyword}" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="cancel write"> 목록으로</a>
                       
                        <c:if test="${user.id eq boardDTO.id || user.grade eq Manager}">
                            <a href="/updateBoardPage?bNo=${boardDTO.bNo}&page=${searchDTO.page}&type=${searchDTO.type}&keyword=${searchDTO.keyword}&boardType=${searchDTO.boardType}" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="write"> 수정하기 </a>
                            <a id="deleteboardbtn" href="/deleteBoard?bNo=${boardDTO.bNo}&page=1" class="btn btn-sm btn-danger" data-toggle="tooltip" data-placement="top" title="write"><i class="fa fa-times"></i> 게시글삭제</a>                                                            
                        </c:if>
                        </div>                       
						
                         <div class="row">
                             <div class="col-lg-12">
                                 <h2>Comments:</h2>                                 
                                 <c:forEach items="${REPLY_LIST}" var="replyList" varStatus="status">
                                 <form action="updateReply" method="get" id="updateReply">
                                 <div class="social-feed-box">
                                    <div class="social-avatar">
                                        <div class="media-body">
                                            <a href="#">
                                               	<c:out value="${replyList.nickName}"/>                                	 
                                            </a>
                                            <small class="text-muted">
                                            	<c:out value="${replyList.regDate}"/>
                                            </small>
                                        </div>
                                    </div>
                                    <div class="social-body" id="contents${status.count}"> 
                                    	<p id="replyContent${status.count}"><c:out value="${replyList.contents}"/></p>                                    
                                    </div>
                                 </div>
                                 <input type="hidden" name="rno" value="${replyList.rno}">
                                 <input type="hidden" name="bno" value="${replyList.bno}">
                                 <input type="hidden" name="id" value="${replyList.id}"> 
                             	 <input type="hidden" name="nickName" value="${replyList.nickName}">
                             	 
                             	 <input type="hidden" name="page" value="${page}">
                               	 <input type="hidden" name="type" value="${type}">
                               	 <input type="hidden" name="keyword" value="${keyword}">
                               	 <input type="hidden" name="searchType" value="${searchDTO.searchType}">
                               	 <input type="hidden" name="boardType" value="${searchDTO.boardType}">
                               	 
                                 <c:if test="${user.id eq replyList.id || user.grade eq Manager}">
                                 
									 <input type="button" id="update${status.count}" class="btn btn-white-left btn-sm" onclick="updatebtn(${status.count},${replyList.rno});" value="댓글수정"/>
	                                 <a id="delete${status.count}" class="btn btn-white-right btn-sm" href='/deleteReply?rno=${replyList.rno}&bno=${replyList.bno}&page=${searchDTO.page}&keyword=${searchDTO.keyword}&type=${searchDTO.type}&boardType=${searchDTO.boardType}'>댓글삭제</a>
                                 	 <%-- <input type="button" id="delete${status.count}" value="댓글삭제"> --%>
                                 	 <!-- <a id="updatebtn1">수정</a> -->
                                 	 <%-- <a id="updatebtn" href="/updateReply?rno=${replyList.rno}&bno=${replyList.bno}&page=${searchDTO.page}&keyword=${searchDTO.keyword}&type=${searchDTO.type}&boardType=${searchDTO.boardType}&contents=${textcontents}&id=${replyList.id}&nickName=${replyList.nickName}">수정</a> --%>
                                 	 <%--<button type="button" onclick="location.href='/updateReply?rno=${replyList.rno}&bno=${replyList.bno}&page=${searchDTO.page}&keyword=${searchDTO.keyword}&type=${searchDTO.type}&boardType=${searchDTO.boardType}&contents=${replyList.contents}&id=${replyList.id}&nickName=${replyList.nickName}'">수정</button> --%>
	                                 <%-- <a id="deletebtn" href="/deleteReply?rno=${replyList.rno}&bno=${replyList.bno}&page=${searchDTO.page}&keyword=${searchDTO.keyword}&type=${searchDTO.type}&boardType=${searchDTO.boardType}">삭제</a> --%>
	                                 <%-- <button id="deletebtn" type="button" onclick="location.href='/deleteReply?rno=${replyList.rno}&bno=${replyList.bno}&page=${searchDTO.page}&keyword=${searchDTO.keyword}&type=${searchDTO.type}&boardType=${searchDTO.boardType}'">삭제</button> --%>
                                 </c:if>                                                                 
                                 </form>                                 
                                 </c:forEach>
                                 
                                 <%--                                
                                 <input type="hidden" name="contents" value="${replyList.contents}">
                                  --%>
                                 
                                 
                                 <c:if test="${not empty user.id}">
                                 <form action="insertReply" method="post">
                                 	<textarea maxlength="300" rows="2" name="contents" id="contents"
                                 	style="resize:none; margin: 0px 1% 1% 0px; height: 100%; width: 100%;"></textarea>
                                 	 <input type="hidden" name="page" value="${page}">
                                 	 <input type="hidden" name="type" value="${type}">
                                 	 <input type="hidden" name="keyword" value="${keyword}">
                                 	 <input type="hidden" name="searchType" value="${searchDTO.searchType}">
                                 	 <input type="hidden" name="boardType" value="${searchDTO.boardType}">
                                 	 
	                                 <input type="hidden" name="bno" value="${boardDTO.bNo}">
	                                 <input type="hidden" name="id" value="${user.id}">
	                                 <input type="hidden" name="nickName" value="${user.nickName}">
	                                 
	                                 <button id="combtn" class="btn btn-sm btn-group" >댓글입력<i class="fa fa-reply"></i></button>
                                 </form>
                                 </c:if>                                 
                             </div>
                         </div>
                     </div>
                 </div>
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

<script type="text/javascript" src="<c:url value="/resources/js/reply.js" />"></script>
<script type="text/javascript">

function updatebtn(count, rno) {
	var chk = $("#update" + count).val();
	var searchForm = $("#textArea" + count);
	var url = "/replyRead.do?t=" + Math.random();	
	$.getJSON(url, {
		"rno" : rno
	}, function(data) {
		var replyContents = data.contents;	
		
		if(chk == "댓글수정") {
			$("#replyContent" + count).hide();
			$("#contents" + count).append("<textarea rows='5' id='textArea" + count + "' name='contents' style='resize:none; margin: 0px 1% 1% 0px; height: 100%; width: 100%;'>" + replyContents + "</textarea>");
			$("#update" + count).val('수정완료');
			return false;
		}
	});
	if((!searchForm.val())&&(chk == "수정완료")){
		alert("내용을 입력하세요");
		return false;
	} else if(chk == "수정완료") {
		$("#update" + count).attr("type", "submit");	
		return false;
	}
};

$(document).ready(function() {	
	$("#recommendbtn").click(function() {
		
		var bNo = ${boardDTO.bNo};
//		var page = ${searchDTO.page};
//		var type = ${searchDTO.type};
//		var keyword = ${searchDTO.keyword};
//		var boardType = ${searchDTO.boardType};
//		var url = "/recommend?/recommend?bNo=" + ${boardDTO.bNo} + "&page=" + ${searchDTO.page} + "&type=" + ${searchDTO.type} + "&keyword=" + ${searchDTO.keyword} + "&boardType=" + ${searchDTO.boardType} + "&t=" + Math.random();
		var url = "/recommend?/&t=" + Math.random();

	     // get방식 ajax연동
		$.getJSON(url, { // url을 받아서 json으로 넘겨줌
			"bNo" : bNo		
		}, function(json) {
			// 결과가 전달되는 파라미터에 읽어온 데이터가 담겨 있으며,
			// JSON이므로 별도의 추출 과정 없이 점(.)으로 데이터 계층을 연결하여 사용할 수 있다.
			var result_text = json.result;
			//alert(result_text);
			
			// "true" 혹은 "false"라는 문자열이므로, eval함수를 사용하여 boolean값으로 변경
			var result = eval(result_text); // boolean
			var recommend = ${boardDTO.bLike}+1;
			
			// 결과 출력
			if(result) {
				alert("이미 추천했습니다.");
				return false;
			}
			
			//$("#recommendbtn").val("추천 " + recommend);
			$("#recommendbtn").html("<i class='fa fa-thumbs-o-up' style='color: red;'></i> 추천${boardDTO.bLike+1}");
		});
	     
		/* if(err == 1) {
			alert("이미 추천했습니다.");
			return false;			
		} */
	});
	
	$("#deleteboardbtn").click(function(){ // 댓글삭제
		var delborResult = confirm("해당 글을 삭제 하시겠습니까?");
		if(!delborResult){
			return false;
		}
	});
	
	var replyList = ${REPLY_LIST.size()};
	for(var i = 1; i <= replyList; i++) {
		$("#delete" + i).click(function(){ // 댓글삭제
			var delresult = confirm("댓글을 삭제 하시겠습니까?");
			if(!delresult){
				return false;
			}
		});
	}

	$('#combtn').click(function () { // 댓글에 내용이 없을 때
		var textarea = $("#contents").val();
		if(textarea=="") {
		    alert("내용을 입력해주세요.");
		    return false;
		} else {
			$("#updateReply").submit();
		}
	});
});



 
	



/* console.log("===============");
console.log("JS TEST");

var bnoValue = '<c:out value="${boardDTO.bNo}"/>';

replyService.add(
	{contents:"JSTest", id:"qudals552", bno:bnoValue}
	,
	function (result) {
		alert("RESULT : " + result);
	}
);

$('#replydelete').click(function() {
	replyService.remove(2, function (count) {
		console.log(count);
		
		if(count === "success") {
			alert("REMOVED");
		}
		
	}, function (err) {
		alert('ERROR...');
	});
} */


/*
$(document).ready(function() {
		
	var valueRno = $('#rno').val();

	
});
*/
</script>

</html>