<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="buy.BuyDAO" %>
<%@ page import="buy.Buy" %>
<%@ page import="cart.CartDAO" %>
<%@ page import="cart.Cart" %>
<%@ page import="buyinfo.BuyinfoDAO" %>
<%@ page import="buyinfo.Buyinfo" %>
<%@ page import="member.Member" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="buy" class="buy.Buy" scope="page" />
<jsp:useBean id="buyinfo" class="buyinfo.Buyinfo" scope="page" />
<jsp:setProperty name="buy" property="memberID" />
<jsp:setProperty name="buy" property="orderID" />
<jsp:setProperty name="buyinfo" property="orderID" />
<jsp:setProperty name="buyinfo" property="cosmeticID" />
<jsp:setProperty name="buyinfo" property="cosmeticName" />
<jsp:setProperty name="buyinfo" property="buyPrice" />
<jsp:setProperty name="buyinfo" property="cosmeticImage"/>


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
		int cartID = 0;
		if (request.getParameter("cartID") != null) {
			cartID = Integer.parseInt(request.getParameter("cartID"));
		}
		if(buy.getMemberID() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BuyDAO buyDAO = new BuyDAO();
			CartDAO cartDAO = new CartDAO();
			int buyResult = buyDAO.write(buy.getMemberID());
			
			BuyinfoDAO buyinfoDAO = new BuyinfoDAO();
			int buyInfoResult = buyinfoDAO.write(buyinfo.getCosmeticID(), buyinfo.getCosmeticName(), buyinfo.getBuyPrice(), buyinfo.getCosmeticImage());
			int cartResult = cartDAO.delete(cartID);
			if (buyResult == -1 || buyInfoResult == -1 || cartResult == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('결제 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('결제가 완료됐습니다!')");
				script.println("location.href = 'memberOrder.jsp'");
				script.println("</script>");
			}
		}
			%>
</body>
</html>