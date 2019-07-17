<%@page import="board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />

<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>Web Hosting Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="security">
<h3>Web Security Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="payment">
<h3>Web Payment Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">Security</span> News</h3>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis anteProin 
quis ante......</dd>
</dl>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis ante	Proin 
quis ante......</dd>
</dl>
</div>
<div id="news_notice">
<h3 class="brown">News &amp; Notice</h3>


<table>
<%
// BoardDAO bdao  객체생성
BoardDAO bdao = new BoardDAO();
// int count=getBoardCount() 메서드 호출

int count = bdao.getBoardCount(1);

int pageSize = 5;
int startRow = 1;

String pageNum=request.getParameter("pageNum");
//pageNum 이 없으면 "1"로 설정
if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);

//int startRow = 구하기
//int startRow = (currentPage-1)*pageSize+1;
//int endRow = 구하기
int endRow=currentPage*pageSize;

List<BoardBean> boardList = null;
// 게시판 글 있으면
// boardList = getBoardList(시작행, 가져올 글 개수)
if(count!=0){
	boardList=bdao.getBoardList(startRow, pageSize,1);
	for(int i = 0; i < boardList.size(); i++){
		BoardBean bb=boardList.get(i);
		%>
		<tr>
		<td class="contxt">
		<a href="../center/content.jsp?num=<%=bb.getNum()%>&pageNum=1"><%=bb.getSubject() %></a>
		</td>
    	<td>
    	<%=bb.getDate() %>
    	</td>
    	</tr>
		<%
	}
}
%>
</table>
	
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />


</div>
</body>
</html>