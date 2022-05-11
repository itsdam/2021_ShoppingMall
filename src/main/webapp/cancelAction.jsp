<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cosmetic.CosmeticDAO" %>
<%@ page import="manager.Manager" %>
<%@ page import="member.Member" %>
<%@ page import="buy.BuyDAO" %>
<%@ page import="buy.Buy" %>
<%@ page import="buyinfo.BuyinfoDAO" %>
<%@ page import="buyinfo.Buyinfo" %>
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
		String memberID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		
		int cartID = 0;
		if (request.getParameter("cartID") != null) {
			cartID = Integer.parseInt(request.getParameter("cartID"));
		}
		
		int orderID = 0;
		if (request.getParameter("orderID") != null) {
			orderID = Integer.parseInt(request.getParameter("orderID"));
		}
		
		Buy buy = new BuyDAO().getBuy(orderID);
		Buyinfo buyinfo = new BuyinfoDAO().getBuyinfo(orderID);
		
		if (orderID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 상품입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else {
				BuyDAO buyDAO = new BuyDAO();
				BuyinfoDAO buyinfoDAO = new BuyinfoDAO();
				int result = buyDAO.delete(orderID);
				int result2 = buyinfoDAO.delete(orderID);
				if (result == -1 || result2 == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('주문 취소 실패!')");
					script.println("history.back()");
					script.println("</script>");
				} 
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('주문이 취소되었습니다.')");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
					
				}
			}
	%>
</body>
</html>