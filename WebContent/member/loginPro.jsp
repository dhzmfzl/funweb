<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// member/loginPro.jsp
// 한글처리
// id,pass 파라미터 가져와서 변수에 저장
String id=request.getParameter("id");
String pass=request.getParameter("pass");

// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// int check=userCheck(함수처리할때 필요한 id,pass 가져가기)메서드호출
int check=mdao.userCheck(id, pass);
// check==1  아이디 비밀번호 일치  세션값생성 "id",id  main/main.jsp이동
// check==0  "비밀번호틀림" 뒤로이동
// check==-1 "아이디없음" 뒤로이동
if(check==1){
	// 세션값 생성  "id",id
			session.setAttribute("id", id);
			// 이동  main.jsp
// 			response.sendRedirect("../main/main.jsp");
			%>
			<script type="text/javascript">
				alert("로그인 성공");
				location.href="../main/main.jsp";
			</script>
			<%
}else if(check==0){
	%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
		alert("아이디없음");
		history.back();
	</script>
	<%
}
%>
</body>
</html>


