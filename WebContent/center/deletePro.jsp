
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
// request 한글처리
request.setCharacterEncoding("utf-8");
int boardNum = (int)session.getAttribute("boardNum");

//id, pass, name, subject, content 파라미터 가져와서 변수에 저장
int num= Integer.parseInt(request.getParameter("num"));
// String name=request.getParameter("name");
String pass=request.getParameter("pass");
// String subject=request.getParameter("subject");
// String content=request.getParameter("content");
String pageNum=request.getParameter("pageNum");

//BoardBean mb 객체생성
BoardBean bb=new BoardBean();
//bb 멤버변수에 <- 파라미터 가져온 변수 저장
bb.setNum(num);
// bb.setName(name);
bb.setPass(pass);
// bb.setSubject(subject);
// bb.setContent(content);
//BoardDAO 객체 생성
BoardDAO bdao=new BoardDAO();
// 리턴값 저장변수  = userCheck(함수처리할때 필요한 id, pass, namem, subject, content 가져가기)
int check=bdao.userCheck(num, pass, boardNum);
//  리턴값이 1 이면 아이디 비밀번호 일치  
//              삭제작업 deleteboard(bb) 메서드호출
//              세션값 초기화
//              list.jsp 이동
//  리턴값이 0 이면 비밀번호틀림 뒤로이동
//  리턴값이 -1 이면 아이디없음 뒤로이동
if(check==1){
	bdao.deleteboard(bb, boardNum);
// 	session.invalidate(); // 이거 살려두면 게시물 삭제하고나서 로그아웃됨
// 	response.sendRedirect("../center/notice.jsp?num="+num+"*pageNum="+pageNum);
	%>
	<script type="text/javascript">
		<%if(boardNum==1){%>
		alert("게시물 삭제");
		location.href="../center/notice.jsp?num=<%=num%>*pageNum=<%=pageNum%>";
		<%}else if(boardNum==2){%>
		alert("게시물 삭제");
		location.href="../center/download.jsp?num=<%=num%>*pageNum=<%=pageNum%>";
		<%}%>
		</script>
	<%

}else if(check==0){
	%>
	<script type="text/javascript">
		alert("비밀번호 불일치");
		history.back();
	</script>
	<%
}
%>
</body>
</html>