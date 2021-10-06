<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    
	<link href='<c:url value="/resources/css/bootstrap.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/font-awesome/css/font-awesome.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/animate.css" />' rel="stylesheet">
    <link href="<c:url value="/resources/css/plugins/iCheck/custom.css" />" rel="stylesheet">
    <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
	
</head>
<body class="gray-bg">
    <div class="middle-box text-center loginscreen   animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name"><a href="getBoardList">Moody</a></h1>

            </div>
            <h3>회원정보수정</h3> <br>
            <form class="m-t" role="form" action="updateUser" method="post">
                <div class="form-group">
                    <input type="text" name="id" class="form-control" value="${user.id}" readonly>
                </div>
                <div class="form-group">
                   <input type="text" name="nickName" class="form-control" value="${user.nickName}" readonly>
                </div>
                <p> 이메일 수정 </p>
                <div class="form-group">
                    <input type="email" name="email" class="form-control" value="${user.email}">
                </div>
                <p> 비밀번호 수정 </p>
                <div class="form-group">
                   <input id="oldPassword" name="oldPassword" type="password" class="form-control" placeholder="기존 비밀번호">
                   <br>
                   <span class="console"></span>
                </div>
                <div class="form-group">
                    <input id="password" name="password" type="password" class="form-control" placeholder="새 비밀번호" >
                </div>
                <div class="form-group">
                    <input id="passwordConfrim" type="password" class="form-control" placeholder="비밀번호 확인">
                	<span id ="confirmMsg"></span>
                </div>                
               
                <button id="updatebtn" type="submit" class="btn btn-primary block full-width m-b" disabled="disabled">수정완료</button>

                <p class="text-muted text-center"><small>이전 페이지로 돌아가시겠습니까?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="getBoardList">돌아가기</a>
                <br>
                <a class="btn btn-sm btn-white btn-block" id="deleteUserbtn" href="deleteUser">회원탈퇴</a>
                
            </form>
        </div>
    </div>
</body>
<!-- Mainly scripts -->
<script type="text/javascript" src="<c:url value="/resources/js/jquery-2.1.1.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<!-- iCheck -->
<script type="text/javascript" src="<c:url value="/resources/js/plugins/iCheck/icheck.min.js" />"></script>
<script>
var regbtn = [];

function chkOld() {	
	if((regbtn[0]=='old')&&(regbtn[1]=='pw')) {
 		$("#updatebtn").prop("disabled", false); // 수정버튼 클릭가능
 	} else {
 		$("#updatebtn").prop("disabled", true);
 	}
}
function chkPw() {
	if((regbtn[1]=='pw')&&(regbtn[0]=='old')) {
 		$("#updatebtn").prop("disabled", false); // 수정버튼 클릭가능
 	} else {
 		$("#updatebtn").prop("disabled", true);
 	}
}

$(document).ready(function(){
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    });
    
    $("#oldPassword").keyup(function () { // 비밀번호 중복검사
 		var input_value = $("input[name='oldPassword']").val();
		if(!input_value) {
			$(".console").html("<span style='color:red'>이전 비밀번호를 입력해주세요. </span>");
 			$("#oldPassword").focus();
 			regbtn[0] = null;
 			chkOld();
 			return false;
 		}
		
		var url = "/PassChkCtrl.do?t=" + Math.random();
     	
	     // get방식 ajax연동
		$.getJSON(url, {
			"password" : input_value
		}, function(json) {
			var result_text = json.result;

			var result = eval(result_text); // boolean으로 캐스팅
			
			// 결과 출력
			if(result) {
				$(".console").html("<span style='color:blue'>비밀번호가 일치합니다. </span>");
				regbtn[0] = 'old';		
			} else {
				$(".console").html("<span style='color:red'>비밀번호가 일치하지 않습니다. </span>");
				regbtn[0] = null;
			}
			chkOld();
		});		
	});
    
    $("#password").keyup(function() { // 비밀번호
		var pwd = $("#password").val();
		var pwdCon = $("#passwordConfrim").val();
		if((pwd != "")&&(pwdCon != "")&&(pwd == pwdCon)){
			$("#confirmMsg").html("<span style='color:blue'>비밀번호가 일치합니다</span>");
			regbtn[1] = 'pw'; 
		} else if(pwd.length < 6) { // 비번이 6자 이상 안되면
			$("#confirmMsg").html("<span style='color:red'>비밀번호를 6자 이상 입력하세요</span>");
			regbtn[1] = null; 
		} else if(pwd != pwdCon){
			$("#confirmMsg").html("<span style='color:red'>비밀번호가 일치하지 않습니다.</span>");
			regbtn[1] = null;
		}
		chkPw();
	});
 	
 	$("#passwordConfrim").keyup(function() { // 비밀번호 확인
		var pwd = $("#password").val();
		var pwdCon = $("#passwordConfrim").val();
		if((pwd != "")&&(pwdCon != "")&&(pwd == pwdCon)){
			$("#confirmMsg").html("<span style='color:blue'>비밀번호가 일치합니다</span>");
			regbtn[1] = 'pw';
		} else  if(pwd.length < 6) { // 비번이 6자 이상 안되면
			$("#confirmMsg").html("<span style='color:red'>비밀번호를 6자 이상 입력하세요</span>");
			regbtn[1] = null; 
		} else if(pwd != pwdCon){
			$("#confirmMsg").html("<span style='color:red'>비밀번호가 일치하지 않습니다.</span>");
			regbtn[1] = null;
		}  		
		chkPw();
	});
    
 	$("#deleteUserbtn").click(function(){ // 회원삭제
		var result = confirm("정말 탈퇴 하시겠습니까?");
		if(!result){
			return false;
		}
	});
 	
});

</script>

</html>