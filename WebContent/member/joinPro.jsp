<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1></h1>
<%
// member/joinPro.jsp 회원가입
// request 한글처리
request.setCharacterEncoding("utf-8");
// 파라미터 변수에 저장(id pass name email post address address2 phone  mobile date)
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String phone=request.getParameter("phone");
String mobile=request.getParameter("mobile");
String post=request.getParameter("post");
String address=request.getParameter("address");
String address2=request.getParameter("address2");
Timestamp reg_date=new Timestamp(System.currentTimeMillis());
// 패키지 member 파일이름 MemberBean 
MemberBean mb=new MemberBean();
// id pass name email post address address2 phone  mobile date
// MemberBean  mb 객체생성. mb 멤버변수 <= 파라미터 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setPhone(phone);
mb.setMobile(mobile);
mb.setPost(post);
mb.setAddress(address);
mb.setAddress2(address2);
mb.setReg_date(reg_date);
// 패키지 member 파일이름 MemberDAO
// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
//  insertMember(mb) 메서드호출
mdao.insertMember(mb);
// login.jsp 이동
// response.sendRedirect("login.jsp");
%>
	<script type="text/javascript">
		alert("회원가입 성공");
		location.href="login.jsp";
	</script>
	<%
%>
</body>
</html>





