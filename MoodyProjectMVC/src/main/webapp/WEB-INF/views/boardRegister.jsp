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
	
	<link href='<c:url value="/resources/css/plugins/iCheck/custom.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/plugins/summernote/summernote.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/plugins/summernote/summernote-bs3.css" />' rel="stylesheet">
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
   
    <!-----------여기서 밑으로 쭉 글쓰기 파트에요. 위에는 헤더부분 붙여둔거니까 지우시면 돼요.------------>
            <div class="row gray-bg">
                <div class="col-lg-3">
                    <div class="ibox float-e-margins">                        
                    </div>
                </div>
                <div class="col-lg-8 animated fadeInRight">
                <div class="mail-box-header">
                    <!-- <div class="pull-right tooltip-demo">
                        <a href="mailbox.html" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="top" title="cancel write"><i class="fa fa-times"></i> 취소</a>
                    </div> -->
                    <h2>글쓰기</h2>
                </div>
                    <div class="mail-box">                    
                    <div class="mail-body">                     
                        <form role="form" id="insertBoard" action="insertBoard" class="form-horizontal" method="post">
                            <div class="form-group"><label class="col-sm-2 control-label">제목:</label>
                                <div class="col-md-4"><input id="contitle" name="bTitle" type="text" class="form-control" value="${board.bTitle}"></div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">작성자:</label>
                                <div class="col-md-4"><input name="writer" type="text" class="form-control" value="${user.nickName}" readonly="readonly"></div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">무디:</label>
                                <div class="col-md-4">
    
                                    <select class="select2_demo_3 form-control" name="bMood">
                                        <option value="1">1. 행복해요! </option>
                                        <option value="2">2. 기뻐요! </option>
                                        <option value="3">3. 보통이에요! </option>
                                        <option value="4">4. 슬퍼요! </option>
                                        <option value="5">5. 화나요! </option>
                                    </select>

                                </div>
                            </div>
                            <div class="mail-text">
                            <div class="mail-body" id="content">
                                <textarea class="input-moody" rows="10" name="bContent" id="contents"
                                style="margin: 0px 1% 1% 0px; height: 100%; width: 100%;"></textarea>
                            </div>
                            <div class="clearfix"></div>
                        	</div>
                        	<div class="mail-body text-right tooltip-demo">
                        		<input type="hidden" name="id" value="${user.id}"/>
                            	<button id="writebtn" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="write"><i class="fa fa-reply"></i> 작성하기</button>
                            	<a href="getBoardList" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="top" title="cancel write"><i class="fa fa-times"></i> 작성취소</a>
                        	</div>
                        </form>                           
                    </div>

                            <!-----------이까지 반복문으로 덧글넣으면 돼요 ----------->                     
                        <div class="clearfix"></div>
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

<!-- iCheck -->
<script type="text/javascript" src="<c:url value="/resources/js/plugins/iCheck/icheck.min.js" />"></script>

<!-- SUMMERNOTE -->
<script type="text/javascript" src="<c:url value="/resources/js/plugins/summernote/summernote.min.js" />"></script>

<script>
$(document).ready(function() {
	
	$('.summernote').summernote();
	
	$('#writebtn').click(function () {
		var texttitle = $("#contitle").val();
		var textarea = $("#contents").val();
		
		if(texttitle=="") {
		    alert("제목을 입력해주세요.");
		    return false;
		} else {
			if(textarea=="") {
			    alert("내용을 입력해주세요.");
			    return false;
			} else {
				$("#insertBoard").submit();
			}
		}
	});	
});

</script>


</html>