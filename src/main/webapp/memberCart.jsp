<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="cart.CartDAO" %>
<%@ page import="cart.Cart" %>
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
		
		int cartID = 0;
		if (request.getParameter("cartID") != null) {
			cosmeticID = Integer.parseInt(request.getParameter("cartID"));
		}
		
		Cart cart = new CartDAO().getCart(cartID);
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
				<h4><p class="info9"><strong>[????????? ?????? ??????]</strong></p></h4>
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
				<li class = "info3"><a href="memberCart.jsp">????????????</a></li>
				<li class = "info3"><a href="memberOrder.jsp">????????????</a></li>
				<li class = "info3"><a href="logoutAction.jsp">LOGOUT</a></li>
			</ul>
			<h4><p class="info"><strong><%=memberID%></strong>??? ???????????????!!</p></h4>
			
			<%
				}
			%>
			<br>	
		</div>
			<form method="post" class="pull-center" action="srchCosmetic.jsp">
			<fieldset>
			    	<select name = "srchKey">
                    	<option ${(param.srchKey == "cosmeticKind")? "selected" : ""} value = "cosmeticKind">??????</option>
                    </select>
                    <input type = "text" name = "srchText" value = "${param.srchText}" placeholder="???????????? ???????????????!"/>
                    <input type = "submit" class="button" value = "??????" >                
               </fieldset>       
            </form>    
            
            <%
            	if (managerID != null) {
            %>
            	<div> <div class="info6" style= "text-align : right">
	            <button><a href="cosmeticWrite.jsp">????????????</a></button>
				<button class="info6"><a href="memberView.jsp">????????????</a></button>
				<button class="info6"><a href="orderView.jsp">????????????</a></button>
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
						aria-expanded="false">???????????????<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="skincare.jsp">????????????</a></li>
						<li><a href="suncare.jsp">?????????</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">?????????????????????<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="foundation.jsp">???????????????</a></li>
						<li><a href="contouring.jsp">????????????</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">??????????????????<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="eyebrow.jsp">???????????????</a></li>
						<li><a href="eyeliner.jsp">???????????????</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">???????????????<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="tint.jsp">??????</a></li>
						<li><a href="lipstick.jsp">?????????</a></li>
					</ul>
				</li>

				</li>
			</ul>
		</div>
	</nav>
	<div style="text-align:center;"><h3><strong>????????????</strong></h3></div><br>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: right; border: 1px solid #dddddd">
				<colgroup>
         			<col width="170px">
          			<col width="*">
          			<col width="170px">
            		<col width="200px">
           			<col width="70px">
     		      	<col width="180px">
     			</colgroup>
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">??????</th>
						<th style="background-color: #eeeeee; text-align: center;">?????????</th>
						<th style="background-color: #eeeeee; text-align: center;">??????</th>
						<th style="background-color: #eeeeee; text-align: center">??????</th>
						<th style="background-color: #eeeeee; text-align: center"></th>
						<th style="background-color: #eeeeee; text-align: center"></th>
				</thead>
				<tbody style="background-color : white;">
					<%
						CartDAO cartDAO = new CartDAO();
						ArrayList<Cart> list = cartDAO.getList(pageNumber);
						int pageNum = (pageNumber - 1) * 10 + 1; //??? ?????? ??????
						for(int i = 0; i < list.size(); i++) {
							
					%>
					
					<%
               			if(memberID != null && memberID.equals(list.get(i).getMemberID())) {
                  
            		%>
					<tr>
						<td style="text-align: center;"><img src="<%= list.get(i).getCosmeticImage()%>" width="100" height="100"></td>
						<td style="text-align: center;"><%= list.get(i).getCosmeticName() %></td>
						<td style="text-align: center;"><%= list.get(i).getBuyCount()%></td>
						<td style="text-align: center;"><%= list.get(i).getBuyPrice() %></td>
						<td><button><a onclick="return confirm('?????? ????????? ??????????????????????')" href="buyWriteAction.jsp?memberID=<%=memberID%>&cosmeticID=<%=list.get(i).getCosmeticID()%>&cosmeticName=<%=list.get(i).getCosmeticName()%>&buyPrice=<%=list.get(i).getBuyPrice()%>&cosmeticImage=<%=list.get(i).getCosmeticImage()%>&cartID=<%=list.get(i).getCartID()%>">??????</a></button></td>
						<td><button><a onclick="return confirm('?????????????????? ?????????????????????????')" href="cartDeleteAction.jsp?cartID=<%=list.get(i).getCartID()%>">??????????????????</a></button></td>					
					<%
						}
					%>
					</tr>			
					<%
						}
					%>
			</tbody>
		</table>
		</div>
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