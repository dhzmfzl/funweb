
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
<h1>center/updatePro.jsp</h1>
<%
	// request 한글처리
request.setCharacterEncoding("utf-8");
// 파라미터 가져오기
String pageNum=request.getParameter("pageNum");

int boardNum = (int)session.getAttribute("boardNum");
String pass=null;
int num =-1;
BoardBean bb=new BoardBean();
	if (boardNum == 1) {
		num= Integer.parseInt(request.getParameter("num"));
		String name = request.getParameter("name");
		pass = request.getParameter("pass");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		bb.setNum(num);
		bb.setName(name);
		bb.setPass(pass);
		bb.setSubject(subject);
		bb.setContent(content);
	}else if(boardNum ==2){
		String realPath=request.getRealPath("/upload");
		System.out.println(realPath);
		int maxSize=5*1024*1024; 
		MultipartRequest multi=new MultipartRequest(request,realPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		num = Integer.parseInt(multi.getParameter("num"));
		String name=multi.getParameter("name");
		pass=multi.getParameter("pass");
		String subject=multi.getParameter("subject");
		String content=multi.getParameter("content");
		String file=multi.getFilesystemName("file");
		String orifile=multi.getParameter("orifile");
		bb.setNum(num);
		bb.setName(name);
		bb.setPass(pass);
		bb.setSubject(subject);
		bb.setContent(content);
		if(file!=null){
			bb.setFile(file);
		}else{
			bb.setFile(orifile);
			
		}

	}
	// BoardBean mb 객체생성
	// bb 멤버변수에 <- 파라미터 가져온 변수 저장

	//BoardDAO 객체 생성
	BoardDAO bdao = new BoardDAO();
	// int check = numCheck(num,pass)
	// check==1 이면 updateBoard(bb) 호출
	int check = bdao.userCheck(num, pass, boardNum);
	if (check == 1) {
		bdao.updateBoard(bb, boardNum);
		// 	response.sendRedirect("content.jsp?num"+num);
%>
	<script type="text/javascript">
		alert("게시물 수정");
		location.href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>";
	</script>
	<%
}else if(check==0){
//  리턴값이 0 이면 비밀번호틀림 뒤로이동
	%>
	<script type="text/javascript">
		alert("비밀번호틀림!!!");
		history.back();
	</script>
	<%
}
%>
</body>
</html>