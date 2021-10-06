<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/font-awesome/css/font-awesome.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/plugins/iCheck/custom.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/animate.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

<!-- Mainly scripts -->
<%-- <script src="<c:url value="/resources/js/jquery-2.1.1.js" />"></script> --%>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.4.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/plugins/iCheck/icheck.min.js" />"></script>
<script type="text/javascript">
var regbtn = [];

function chkId() {	
	if((regbtn[0]=='id')&&(regbtn[1]=='nick')&&(regbtn[2]=='pw')&&(regbtn[3]=='chk')) {
 		$("#reg").prop("disabled", false); // 가입버튼 클릭가능
 	} else {
 		$("#reg").prop("disabled", true);
 	}

}
function chkNick() {	
	if((regbtn[1]=='nick')&&(regbtn[0]=='id')&&(regbtn[2]=='pw')&&(regbtn[3]=='chk')) {
 		$("#reg").prop("disabled", false); // 가입버튼 클릭가능
 	} else {
 		$("#reg").prop("disabled", true);
 	}
}
function chkPw() {	
	if((regbtn[2]=='pw')&&(regbtn[0]=='id')&&(regbtn[1]=='nick')&&(regbtn[3]=='chk')) {
 		$("#reg").prop("disabled", false); // 가입버튼 클릭가능
 	} else {
 		$("#reg").prop("disabled", true);
 	}
}
function chkChkBox() {	
	if((regbtn[3]=='chk')&&(regbtn[0]=='id')&&(regbtn[1]=='nick')&&(regbtn[2]=='pw')) {
 		$("#reg").prop("disabled", false); // 가입버튼 클릭가능
 	} else {
 		$("#reg").prop("disabled", true);
 	}
}

     $(document).ready(function() {
    	 
     	$("#id").keyup(function () { // 아이디 중복검사
     		var input_value = $("input[name='id']").val();
			
			if(!input_value) {
				$(".console").html("<span style='color:red'>아이디를 입력해주세요. </span>");
	 			$("input[name='id']").focus();
	 			regbtn[0] = null;
	 			chkId();
	 			return false;
	 		}
			
			var url = "/IdChkCtrl.do?t=" + Math.random();
	     	
		     // get방식 ajax연동
			$.getJSON(url, { // url을 받아서 json으로 넘겨줌
				"id" : input_value
			}, function(json) {
				// 결과가 전달되는 파라미터에 읽어온 데이터가 담겨 있으며,
				// JSON이므로 별도의 추출 과정 없이 점(.)으로 데이터 계층을 연결하여 사용할 수 있다.
				var result_text = json.result;
				
				// alert(result_text);
				
				// "true" 혹은 "false"라는 문자열이므로, eval함수를 사용하여 boolean값으로 변경
				var result = eval(result_text); // boolean으로 캐스팅
				
				// 결과 출력
				if(result) {
					$(".console").html("<span style='color:blue'>사용할 수 있는 아이디입니다. </span>");
					regbtn[0] = 'id';		
				} else {
					$(".console").html("<span style='color:red'>사용할 수 없는 아이디입니다. </span>");
					regbtn[0] = null;
				}
				chkId();
			});		    
			
    	});
     	
     	$("#nick").keyup(function () { // 닉네임 중복검사
     		var input_value = $("input[name='nickName']").val();
			
			if(!input_value) {
				$(".consoleNick").html("<span style='color:red'>닉네임을 입력해주세요. </span>");
	 			$("input[name='nickName']").focus();
	 			regbtn[1] = null;
	 			chkNick();
	 			return false;
	 		}
			
			var url = "/NickChkCtrl.do?t=" + Math.random();
	     	
		     // get방식 ajax연동
			$.getJSON(url, { // url을 받아서 json으로 넘겨줌
				"nickName" : input_value
			}, function(json) {
				// 결과가 전달되는 파라미터에 읽어온 데이터가 담겨 있으며,
				// JSON이므로 별도의 추출 과정 없이 점(.)으로 데이터 계층을 연결하여 사용할 수 있다.
				var result_text = json.result;
				
				// alert(result_text);
				
				// "true" 혹은 "false"라는 문자열이므로, eval함수를 사용하여 boolean값으로 변경
				var result = eval(result_text); // boolean으로 캐스팅
				
				// 결과 출력
				if(result) {
					$(".consoleNick").html("<span style='color:blue'>사용할 수 있는 닉네임입니다. </span>");
					regbtn[1] = 'nick';					
				} else {
					$(".consoleNick").html("<span style='color:red'>사용할 수 없는 닉네임입니다. </span>");
					regbtn[1] = null;					
				}
				chkNick();
			});		     
			
    	});
     	
     	$("#password").keyup(function() { // 비밀번호
    		var pwd = $("#password").val();
    		var pwdCon = $("#passwordConfrim").val();
    		if((pwd != "")&&(pwdCon != "")&&(pwd == pwdCon)){
    			$("#confirmMsg").html("<span style='color:blue'>비밀번호가 일치합니다</span>");
    			regbtn[2] = 'pw'; 
    		} else if(pwd.length < 6) { // 비번이 6자 이상 안되면
    			$("#confirmMsg").html("<span style='color:red'>비밀번호를 6자 이상 입력하세요</span>");
    			regbtn[2] = null; 
    		} else if(pwd != pwdCon){
    			$("#confirmMsg").html("<span style='color:red'>비밀번호가 일치하지 않습니다.</span>");
    			regbtn[2] = null;
    		}
    		chkPw();
    	});
     	
     	 $("#passwordConfrim").keyup(function() { // 비밀번호 확인
    		var pwd = $("#password").val();
    		var pwdCon = $("#passwordConfrim").val();
    		if((pwd != "")&&(pwdCon != "")&&(pwd == pwdCon)){
    			$("#confirmMsg").html("<span style='color:blue'>비밀번호가 일치합니다</span>");
    			regbtn[2] = 'pw';
    		} else  if(pwd.length < 6) { // 비번이 6자 이상 안되면
    			$("#confirmMsg").html("<span style='color:red'>비밀번호를 6자 이상 입력하세요</span>");
    			regbtn[2] = null; 
    		} else if(pwd != pwdCon){
    			$("#confirmMsg").html("<span style='color:red'>비밀번호가 일치하지 않습니다.</span>");
    			regbtn[2] = null;
    		}  		
    		chkPw();
    	});
     	
    	 $("#checkbox").change(function() {
//      		alert("체크함");
      		if($("#checkbox").is(":checked")) {
//      			alert("체크함");
          		regbtn[3] = 'chk';
          	} else {
//          		alert("체크해제");
          		regbtn[3] = null;          		
          	}
      		chkChkBox();      		
 		});
     });
 </script>
 <script type="text/javascript">
 $(document).ready(function () {
	 $('.i-checks').iCheck({
         checkboxClass: 'icheckbox_square-green',
         radioClass: 'iradio_square-green',
     });
});
 </script>

<title>회원가입</title>
</head>
<body class="gray-bg">

    <div class="middle-box text-center loginscreen   animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name"><a href="loginForm">Moody</a></h1>

            </div>
            <h3>회원가입</h3> <br>
            <form class="m-t" action="insertUser" method="post" role="form" >
                <div class="form-group">
                    <input type="text" id="id" name="id" class="form-control" placeholder="아이디" maxlength="10" required >
                    <br>
                    <div class="console"></div>
                </div>
                
                <div class="form-group">
                    <input type="text" id="nick" name="nickName" class="form-control" placeholder="닉네임" maxlength="10" required>
                	<div class="consoleNick"></div>
                </div>
                <div class="form-group">
                    <input type="email" name="email" class="form-control" placeholder="이메일" maxlength="30">
                </div>
                <div class="form-group">
                    <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호" required maxlength="20"> 
                </div>
                <div class="form-group">
                    <input type="password" name="passwordConfrim" id="passwordConfrim" class="form-control" placeholder="비밀번호 확인" required maxlength="20"><span id ="confirmMsg"></span>
                <span id ="confirmMsg"></span>
                </div>
                
                <div class="form-group">
                		<textarea rows="10" readonly="readonly"
                		style="user-select:none; border:none; resize:none; margin: 0px 1% 1% 0px; height: 100%; width: 100%;">가. 개인정보의 수집 및 이용 목적
                		
① MoodyMoody는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

1. MoodyMoody 서비스 제공을 위한 회원관리
1) 공간정보 다운로드, 오픈API 신청 및 활용 등 포털 서비스 제공과 서비스 부정이용 방지를 목적으로 개인정보를 처리합니다.
   

나. 수집하는 개인정보의 항목
① MoodyMoody 회원정보(필수): 이름, 아이디, 비밀번호

다. 개인정보의 보유 및 이용기간
① MoodyMoody은 법령에 따른 개인정보 보유ㆍ이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유ㆍ이용기간 내에서 개인정보를 처리ㆍ보유합니다.

MoodyMoody 회원정보
- 수집근거: 정보주체의 동의
- 보존기간: 회원 탈퇴 요청 전까지(1년 경과 시 재동의)
- 보존근거: 정보주체의 동의

라. 동의 거부 권리 및 동의 거부에 따른 불이익
위 개인정보의 수집 및 이용에 대한 동의를 거부할 수 있으나, 동의를 거부할 경우 회원 가입이 제한됩니다.</textarea>

                        <!-- <div class="iCheck i-checks"> -->
                        	<label><input id="checkbox" name="checkbox" type="checkbox"><i></i> 약관 및 정책에 동의합니다 </label>
                        <!-- </div> -->
                </div>
                <button type="submit" id="reg" class="btn btn-primary block full-width m-b" disabled="disabled">회원가입</button>
				
                <p class="text-muted text-center"><small>이미 회원이십니까??</small></p>
                <a class="btn btn-sm btn-white btn-block" href="loginForm">로그인</a>
            </form>
        </div>
    </div>
</body>

</html>