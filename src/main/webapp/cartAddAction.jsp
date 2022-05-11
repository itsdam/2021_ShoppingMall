<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cart.CartDAO" %>
<%@ page import="member.Member" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="cart" class="cart.Cart" scope="page" />
<jsp:setProperty name="cart" property="cartID" />
<jsp:setProperty name="cart" property="memberID" />
<jsp:setProperty name="cart" property="cosmeticID" />
<jsp:setProperty name="cart" property="cosmeticName" />
<jsp:setProperty name="cart" property="buyPrice" />
<jsp:setProperty name="cart" property="buyCount" />
<jsp:setProperty name="cart" property="cosmeticImage" />
<%
	System.out.println(cart);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cosmetic Shop</title>
</head>
<body>
	<%	
		String memberID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		if(cart.getMemberID() == null || cart.getCosmeticName() == null || cart.getBuyPrice() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			CartDAO cartDAO = new CartDAO();
			int result = cartDAO.write(cart.getCartID(), cart.getMemberID(), cart.getCosmeticID(),
					cart.getCosmeticName(), cart.getBuyPrice(), cart.getBuyCount(), cart.getCosmeticImage());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('장바구니 등록에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('장바구니에 등록했습니다!')");
				script.println("location.href = 'memberCart.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>