<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="buy.BuyDAO" %>
<%@ page import="buy.Buy" %>
<%@ page import="buyinfo.BuyinfoDAO" %>
<%@ page import="buyinfo.Buyinfo" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html;>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="C:\Users\User\eclipse-workspace\SHOPP\src\css\custom.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@400;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="shopCSS.css">
<title>Cosmetic Shop</title>
</head>
<body style="font-family: 'Nanum Myeongjo', serif">
	<%
		request.setCharacterEncoding("utf-8");
		String memberID = null;
		String managerID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		if(session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		int cosmeticID = 0;
		if (request.getParameter("cosmeticID") != null) {
			cosmeticID = Integer.parseInt(request.getParameter("cosmeticID"));
		}
		
		int orderID = 0;
		if (request.getParameter("orderID") != null) {
			orderID = Integer.parseInt(request.getParameter("orderID"));
		}
		
		int buyID = 0;
		if (request.getParameter("buyID") != null) {
			buyID = Integer.parseInt(request.getParameter("buyID"));
		}
		
		int buyAvailable = 0;
		if (request.getParameter("buyAvailable") != null) {
			buyAvailable = Integer.parseInt(request.getParameter("buyAvailable"));
		}
		
		int buyinfoAvailable = 0;
		if (request.getParameter("buyinfoAvailable") != null) {
			buyinfoAvailable = Integer.parseInt(request.getParameter("buyinfoAvailable"));
		}
		
		Buy buy = new BuyDAO().getBuy(orderID);
		Buyinfo buyinfo = new BuyinfoDAO().getBuyinfo(orderID);
	%>
		<p id = "p1">
			<h1 class="logo">
				<strong><a href="main.jsp">Let's Cosmetic</a></strong>
			</h1>
			<p class="info5">The beauty of a woman is not facial mode, but the true beauty in a woman is reflected in her soul.</p>
		</p>
	<nav class="navbar navbar-light">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<%
				 if (managerID != null) {
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class = "info3"><a href="logoutAction.jsp">LOGOUT</a></li>
				</ul>
				<h4><p class="info9"><strong>[관리자 모드 실행]</strong></p></h4>
			<% 
				} else if(memberID == null) {
		
			%>
			<ul class="nav navbar-nav navbar-right">
						<li><a href="login.jsp">LOGIN</a></li>
						<li class = "info2"><a href="join.jsp">JOIN</a></li>
			</ul>
			
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class = "info3"><a href="memberCart.jsp">장바구니</a></li>
				<li class = "info3"><a href="memberOrder.jsp">주문조회</a></li>
				<li class = "info3"><a href="logoutAction.jsp">LOGOUT</a></li>
			</ul>
			<h4><p class="info"><strong><%=memberID%></strong>님 어서오세요!!</p></h4>
			
			<%
				}
			%>
			<br>	
		</div>
			<form method="post" class="pull-center" action="srchCosmetic.jsp">
			<fieldset>
			    	<select name = "srchKey">
                    	<option ${(param.srchKey == "cosmeticKind")? "selected" : ""} value = "cosmeticKind">전체</option>
                    </select>
                    <input type = "text" name = "srchText" value = "${param.srchText}" placeholder="검색어를 입력하세요!"/>
                    <input type = "submit" class="button" value = "검색" >                
               </fieldset>       
            </form>    
            
            <%
            	if (managerID != null) {
            %>
            	<div> <div class="info6" style= "text-align : right">
	            <button><a href="cosmeticWrite.jsp">상품추가</a></button>
				<button class="info6"><a href="memberView.jsp">회원조회</a></button>
				<button class="info6"><a href="orderView.jsp">주문조회</a></button>
	            </div> </div>
	        <%
            	} 
	        %>
	</nav>
		<nav class="navbar navbar-default"> 
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-center">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">기초화장품<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="skincare.jsp">스킨케어</a></li>
						<li><a href="suncare.jsp">선케어</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">페이스메이스업<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="foundation.jsp">파운데이션</a></li>
						<li><a href="contouring.jsp">컨투어링</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">아이메이크업<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="eyebrow.jsp">아이브로우</a></li>
						<li><a href="eyeliner.jsp">아이라이너</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">립메이크업<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="tint.jsp">틴트</a></li>
						<li><a href="lipstick.jsp">립스틱</a></li>
					</ul>
				</li>

				</li>
			</ul>
		</div>
	</nav>
	<div style="text-align:center;"><h3><strong>주문내역</strong></h3></div><br>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: right; border: 1px solid #dddddd">
				<colgroup>
         			<col width="200px">
          			<col width="*">
            		<col width="200px">
            		<col width="170px">
            		<col width="230px">
     			</colgroup>
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">주문상품</th>
						<th style="background-color: #eeeeee; text-align: center;">상품명</th>
						<th style="background-color: #eeeeee; text-align: center;">총 금액</th>
						<th style="background-color: #eeeeee; text-align: center;">주문수량</th>
						<th style="background-color: #eeeeee; text-align: center;">주문일자</th>
				</thead>
				<tbody style="background-color : white;">
					<%
						BuyDAO buyDAO = new BuyDAO();
						BuyinfoDAO buyinfoDAO = new BuyinfoDAO();
						ArrayList<Buy> list = buyDAO.orderList(pageNumber);
						ArrayList<Buyinfo> list1 = buyinfoDAO.orderList(pageNumber, list);
						int pageNum = (pageNumber - 1) * 10 + 1; //글 번호 순번
						for (int i = 0; i < list.size(); i++) {
							for (int j = 0; j < list1.size(); j++) {
					%>
					
					<%
               			if(memberID != null && memberID.equals(list.get(i).getMemberID()) && list.get(i).getOrderID() == list1.get(j).getOrderID()) {
                  
            		%>
					<tr>
						<td style="text-align: center;"><img src="<%= list1.get(j).getCosmeticImage()%>" width="100" height="100"></td>
						<td style="text-align: center;"><%= list1.get(j).getCosmeticName()%></td>
						<td style="text-align: center;"><%= list1.get(j).getBuyPrice()%></td>					
						<td style="text-align: center;"><%= list1.get(j).getBuyCount()%></td>
						<td style="text-align: center;"><%= list.get(i).getBuyDate().substring(0, 11) + list.get(i).getBuyDate().substring(11, 13) + ":" + list.get(i).getBuyDate().substring(14, 16)%></td>

					</tr>			
					<%
						}
					%>
				<%
					}
				%>
				
			<%
				}
			%>
				
			</tbody>
		</table>
		</div>
		<br>
	<hr>
	<footer class="container">
		<p class = "text-center"> Copyright &copy; Cho Sodam All Rights Reserved.</p>
	</footer>
		<br><br><br><br>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>