<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cosmetic.CosmeticDAO" %>
<%@ page import="manager.Manager" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="cosmetic" class="cosmetic.Cosmetic" scope="page" />
<jsp:setProperty name="cosmetic" property="cosmeticName" />
<jsp:setProperty name="cosmetic" property="cosmeticContent" />
<jsp:setProperty name="cosmetic" property="cosmeticKind" />
<jsp:setProperty name="cosmetic" property="cosmeticPrice" />
<jsp:setProperty name="cosmetic" property="cosmeticCount" />
<jsp:setProperty name="cosmetic" property="cosmeticImage" />
<%
	System.out.println(cosmetic);
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
		if(cosmetic.getCosmeticKind() == null || cosmetic.getCosmeticName() == null || cosmetic.getCosmeticPrice() == null ||
				cosmetic.getCosmeticCount() == null || cosmetic.getCosmeticContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			CosmeticDAO cosmeticDAO = new CosmeticDAO();
			int result = cosmeticDAO.write(cosmetic.getCosmeticKind(), cosmetic.getCosmeticName(), cosmetic.getCosmeticPrice(),
					cosmetic.getCosmeticCount(), cosmetic.getCosmeticImage(), cosmetic.getCosmeticContent());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('상품 등록에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('상품을 등록했습니다!')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>