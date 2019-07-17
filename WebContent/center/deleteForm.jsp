<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
<%
//세션값 가져와서 변수에 저장
int boardNum = (int)session.getAttribute("boardNum");
int num= Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");

//num 파라미터 가져오기
// int num= Integer.parseInt(request.getParameter("num"));
// String pageNum=request.getParameter("pageNum");
//BoardDAO bdao 객체생성
BoardDAO bdao = new BoardDAO();
//BoardBean bb  =  getBoard(num) 메서드호출
BoardBean bb = bdao.getBoard(num, boardNum);
//조회수 증가
//updateReadcount(num);
bdao.updateReadcount(num, boardNum);

String content = bb.getContent();
if(content!=null){
	//			\r\n => <br>바꾸기 문자열.replace("old문자열", "new문자열")
	content=content.replace("\r\n", "<br>");
}


%>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice</a></li>
<li><a href="../center/gallery.jsp">Gallery</a></li>
<li><a href="../center/download.jsp">Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Notice deleteForm</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<tr><td><%=bb.getNum() %></td>
<td><%=bb.getSubject() %></td> 
<td><%=bb.getName() %></td>
<td><%=bb.getDate() %></td>
<td><%=bb.getReadcount() %></td></tr>

<%
if(bb.getFile()!=null){
	%>
	<tr><td>첨부파일</td>
	<td colspan="3">
	<a href="../upload/<%=bb.getFile() %>"><%=bb.getFile() %></a>
	<img src="../upload/<%=bb.getFile()%>" width="100" height="100">
	</td></tr>
<% 
}
%>
</tr>
<tr><td class="twrite">내용</td><td colspan="5"><%=content %></td></tr>
<form action="deletePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr">
<tr><td><input type="hidden" name="num" value="<%=num %>"></td>
<td colspan="5">비밀번호:<input type="password" name="pass">
<input type="submit" value="글삭제"></td></tr>
</form>


<div id="table_search">
<%
// 세션값 가져오기
String id = (String)session.getAttribute("id");
// 세션값 있으면
// 세션값과 글의 작성자와 비교 일치하면 글수정 글삭제 버튼이 보이기
if(id!=null){
	if(id.equals(bb.getName())){
		%>
		<input type="button" value="글수정" class="btn" onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'">
		
		<% 
		
	}
}

%>

<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
</div>
 
</table>

<!-- <div id="table_search"> -->
<!-- <input type="submit" value="글쓰기" class="btn"> -->
<!-- </div> -->

<div class="clear"></div>
<div id="page_control">
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>