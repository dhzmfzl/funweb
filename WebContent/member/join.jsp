<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 <script type="text/javascript">
 function idcheck() {
	// id 텍스트 상자가 비어있으면  "아이디입력" 제어
	fid=document.fr.id.value;
	if(fid==""){
		alert("아이디입력");
		document.fr.id.focus();
		return;
	}
	//  아이디 입력되어있으면 새창열기  "idcheck.jsp"
// 	window.open("파일이름","창이름","옵션");
	window.open("idcheck.jsp?fid="+fid,"","width=400,height=200");
 }
 function check(){
	if(document.fr.id.value==""){
		alert("아이디를 입력하세요.");
		document.fr.id.focus();
		return false;
	} 
	if(document.fr.pass.value==""){
		alert("비밀번호를 입력하세요.");
		document.fr.pass.focus();
		return false;
	} 
	if(document.fr.pass2.value==""){
		alert("비밀번호 확인을 입력하세요.");
		document.fr.pass2.focus();
		return false;
	}
	if(document.fr.pass.value!=document.fr.pass2.value){
		alert("비밀번호가 일치 하지 않습니다.");
		document.fr.pass2.focus();
		return false;
	}
	if(document.fr.email.value==""){
		alert("이메일 입력하세요");
		document.fr.email.focus();
		return false;
	}
 }
 </script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>회원가입</h1>
<form action="joinPro.jsp" id="join" method="post" name="fr" onsubmit="return check()">
<fieldset>
<legend>기본 정보</legend>
<label>아이디</label>
<input type="text" name="id" class="id">
<input type="button" value="중복체크" class="dup" onclick="idcheck()"><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
<label>비밀번호 체크</label>
<input type="password" name="pass2"><br>
 <script type="text/javascript">
	function name() {
		
	}
 </script>
<label>닉네임</label>
<input type="text" name="name"><br>
<label>이메일</label>
<input type="email" id="email" name="email">
<input type="button" value="이메일 인증" class="dup" onclick="window.open('../member/emailConfirm.jsp', 'witdh=600, height=400');"><br>

</fieldset>

<fieldset>
<legend>Optional</legend>
<label>주소</label>
<input type="text" id="post" placeholder="우편번호" name="post">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="dup"><br>
<label>도로명 주소</label>
<input type="text" id="address" placeholder="도로명주소" name="address"><br>
<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
<span id="guide" style="color:#999;display:none"></span>
<label>상세 주소</label>
<input type="text" id="address2" placeholder="상세주소" name="address2"><br>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                 }
                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                 if(extraRoadAddr !== ''){
                     extraRoadAddr = ' (' + extraRoadAddr + ')';
                 }

                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
                 document.getElementById('post').value = data.zonecode;
                 document.getElementById("address").value = roadAddr;

                 var guideTextBox = document.getElementById("guide");

            }
        }).open();
    }
</script>


<!-- <label>주소</label> -->
<!-- <input type="text" name="id" class="id"> -->
<!-- <label></label> -->
<!-- <input type="text" name="address" class="address" value ="상세주소"><br> -->
<label>전화번호</label>
<input type="text" name="phone"><br>
<label>휴대폰 번호</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>