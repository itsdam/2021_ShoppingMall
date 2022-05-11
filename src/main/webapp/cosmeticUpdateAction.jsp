<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cosmetic.CosmeticDAO" %>
<%@ page import="manager.Manager" %>
<%@ page import="cosmetic.CosmeticDAO" %>
<%@ page import="cosmetic.Cosmetic" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>
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
		
		int cosmeticID = 0;
		if (request.getParameter("cosmeticID") != null) {
			cosmeticID = Integer.parseInt(request.getParameter("cosmeticID"));
		}
		
		Cosmetic cosmetic = new CosmeticDAO().getCosmetic(cosmeticID);
		
		if(request.getParameter("cosmeticKind") == null || request.getParameter("cosmeticName") == null || request.getParameter("cosmeticPrice") == null ||
				request.getParameter("cosmeticCount") == null || request.getParameter("cosmeticContent") == null || request.getParameter("cosmeticImage") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			CosmeticDAO cosmeticDAO = new CosmeticDAO();
			int result = cosmeticDAO.update(cosmeticID, request.getParameter("cosmeticKind"), request.getParameter("cosmeticName"), request.getParameter("cosmeticPrice"), 
					request.getParameter("cosmeticCount"), request.getParameter("cosmeticImage"), request.getParameter("cosmeticContent"));
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('상품을 수정했습니다!')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>