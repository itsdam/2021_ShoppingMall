<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cosmetic.CosmeticDAO" %>
<%@ page import="manager.Manager" %>
<%@ page import="member.Member" %>
<%@ page import="cart.CartDAO" %>
<%@ page import="cart.Cart" %>
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
		
		Cart cart = new CartDAO().getCart(cartID);
		
		if (cartID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 상품입니다.')");
			script.println("location.href = 'memberCart.jsp'");
			script.println("</script>");
		} else {
				CartDAO cartDAO = new CartDAO();
				int result = cartDAO.delete(cartID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('장바구니 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} 
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('장바구니에서 삭제했습니다.')");
					script.println("location.href = 'memberCart.jsp'");
					script.println("</script>");
					
				}
			}
	%>
</body>
</html>