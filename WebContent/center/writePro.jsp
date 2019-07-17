<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
// center/writePro.jsp
// 한글처리
int boardNum = (int)session.getAttribute("boardNum");
request.setCharacterEncoding("utf-8");
//BoardBean bb 객체 생성
BoardBean bb = new BoardBean();
// 파라미터값 변수에 저장
if (boardNum==1){
String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
}

if(boardNum==2){
	String realPath=request.getRealPath("/upload");
	System.out.println(realPath);
	// 업로드할 파일의 크기 제한
	int maxSize=5*1024*1024; //5M
	// MultipartRequest 객체생성 => 파일업로드 , multi 정보 저장
	MultipartRequest multi=new MultipartRequest(request,realPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
	// 파라미터값 가져오셔서 변수에 저장
	String name=multi.getParameter("name");
	String pass=multi.getParameter("pass");
	String subject=multi.getParameter("subject");
	String content=multi.getParameter("content");
	String file=multi.getFilesystemName("file");
	String m = multi.getParameter("m");
	// BoardBean bb 객체생성
	// 멤버변수 <= 파라미터값 저장;
	bb.setName(name);
	bb.setPass(pass);
	bb.setSubject(subject);
	bb.setContent(content);
	bb.setFile(file);
	bb.setM(m);
}

// 멤버변수 <= 파라미터 값 저장


// BoardDAO bdao 객체 생성
BoardDAO bdao = new BoardDAO();
// insertBoard bb 
bdao.insertBoard(bb, boardNum);

%>
<script type="text/javascript">
	alert("게시물 등록완료");
	<%if(boardNum==1){%>
	location.href="../center/notice.jsp";
	<%}else if(boardNum==2){%>
	location.href="../center/download.jsp";
	<%}%>
</script>
<%

%>
</body>
</html>