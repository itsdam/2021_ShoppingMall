<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.ManagerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="manager" class="manager.Manager" scope="page" />
<jsp:setProperty name="manager" property="managerID" />
<jsp:setProperty name="manager" property="managerPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cosmetic Shop</title>
</head>
<body>
	<%
		String managerID = null;
		if(session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		if(managerID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		ManagerDAO managerDAO = new ManagerDAO();
		int result = managerDAO.login(manager.getManagerID(), manager.getManagerPassword());
		if (result == 1) {
			session.setAttribute("managerID", manager.getManagerID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자님 안녕하세요!')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} 
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
	%>
</body>
</html>