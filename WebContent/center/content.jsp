<%@page import="java.util.List"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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
</head>
<body>

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
<%
// num, pageNum 파라미터 가져오기
request.setCharacterEncoding("utf-8");
int boardNum = (int)session.getAttribute("boardNum");
int num= Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");
//BoardDAO bdao 객체생성
BoardDAO bdao = new BoardDAO();
//조회수 증가
//updateReadcount(num);
bdao.updateReadcount(num,boardNum);
//BoardBean bb  =  getBoard(num) 메서드호출
BoardBean bb = bdao.getBoard(num,boardNum);
String content = bb.getContent();
if(content!=null){
	//			\r\n => <br>바꾸기 문자열.replace("old문자열", "new문자열")
	content=content.replace("\r\n", "<br>");
}

%>
<article>
<h1>Notice content</h1>
<form action="writePro.jsp" method="get" name="">
<table id="notice">
	<tr>
		<th class="tno">No.</th>
	    <th class="ttitle">Title</th>
	    <th class="twrite">Writer</th>
	    <th class="tdate">Date</th>
	    <th class="tread">Read</th>
	</tr>
	<tr>
		<td><%=bb.getNum() %></td>
		<td><%=bb.getSubject() %></td> 
		<td><%=bb.getName() %></td>
		<td><%=bb.getDate() %></td>
		<td><%=bb.getReadcount() %></td>
	</tr>
	<%if(boardNum==2){ %>
		<%if(bb.getFile()!=null){ %>
		<tr><td>첨부파일</td>
	<td colspan="3">
	<a href="file_down.jsp?file_name=<%=bb.getFile() %>"><%=bb.getFile() %></a>
	<img src="../upload/<%=bb.getFile()%>" width="100" height="100">
	</td></tr>
	<% }
	}%>
	<tr>
		<td class="twrite">내용</td>
		<td colspan="5"><%=content %></td>
	</tr>
</table>

<div id="table_search">
<%
// 세션값 가져오기
String id = (String)session.getAttribute("id");
// 세션값 있으면
// 세션값과 글의 작성자와 비교 일치하면 글수정 글삭제 버튼이 보이기
if(id!=null){
	if(id.equals(bb.getName())){
		%>
		<input type="button" value="글수정" class="btn" onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'" style="float: right;">
 		<input type="button" value="글삭제" class="btn" onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'" style="float: right;">
		<% 
	}
}
%>
<%if(boardNum==1){ %>
<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'" style="float: right;">
<%}else if(boardNum==2){ %>
<input type="button" value="글목록" class="btn" onclick="location.href='download.jsp?pageNum=<%=pageNum%>'" style="float: right;">

<%} %>

</div>
</form>

<%if(boardNum==1){ %>
 <form action="commentPro.jsp?pageNum=<%=pageNum%>&boardNum=<%=boardNum%>" method="get">
 <div id="comment">
<br>
<br>
<br>
<%
List<BoardBean> commentList =null;

commentList = bdao.getCommentList(num);
%>
<table id="comment">
<tr><th class="twrite">작성자</th>
    <th class="tread">내용</th></tr>
    <%
    for(int i=0;i<commentList.size();i++){
    	//BoardBean bb=(BoardBean)boardList.get(i);
    	BoardBean bb2=commentList.get(i);
    	%>
<tr>
    <td class="left">
    <%=bb2.getId() %></td>
    <td><%=bb2.getComment() %></td></tr>
    <% 
    }
    %>
</table>



<input type="hidden" name="num" id="num" value="<%=num%>"> 
<input type="hidden" name="id" id="id" value="<%=id%>">
<textarea rows="5" cols="78" class="w3-input w3-border" placeholder="댓글 작성" name="comment" id="comment"></textarea>
<br>
<input type="submit" value="댓글 등록" class="btn" style="float: right;">
</div>
</form>
<%} %>

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