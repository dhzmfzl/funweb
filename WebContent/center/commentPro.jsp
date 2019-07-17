<%@page import="board.BoardDAO"%>
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
request.setCharacterEncoding("utf-8");
int num= Integer.parseInt(request.getParameter("num"));
String id=request.getParameter("id");
String pageNum=request.getParameter("pageNum");
int boardNum = (int)session.getAttribute("boardNum");
String comment=request.getParameter("comment");

BoardDAO bdao = new BoardDAO();

bdao.insertComment(num, id, comment);
response.sendRedirect("content.jsp?num=" + num);

%>
<script type="text/javascript">
location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>&boardNum=<%=boardNum%>";
</script>
</body>
</html>