<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="../member/emailSend.jsp" method="post">
			<table>
				<tr>
					<th colspan="2">메일전송</th>
				</tr>
				<tr>
					<td>보내는사람</td>
					<td><input type="text" name="from" value="psnproject88@gmail.com" /></td>
				</tr>
				<tr>
					<td>받는 사람</td>
					<td><input type="text" name="to" /></td>
				</tr>
				<tr>
					<td>제 목</td>
					<td><input type="text" name="subject" /></td>
				</tr>
				<tr>
					<td>내 용</td>
					<td><textarea name="content"
							style="width: 170px; height: 200px;"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;"><input
						type="submit" value="전 송" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>