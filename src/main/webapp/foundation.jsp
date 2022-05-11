<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="cosmetic.CosmeticDAO" %>
<%@ page import="cosmetic.Cosmetic" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.Member" %>
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
<title>Cosmetic Shop</title>
<style type="text/css">
	a, a:hover {
				color: #000000;
				text-decoration: none;
	}
	
	h1 {
		text-align: center;
	}
	fieldset {
				text-align: center;
	}
	.dropdown {
				margin-left: 230px;
				text-align: center;
	}
	
	.info {
			margin-top: 15px;
			margin-left: 230px;
			text-align: center;
	}
	
	.info2 {
			margin-right: 40px;
	}
	
	.info3 {
			margin-right: 0px;
	}
	
	.info4 {
			text-align: right;
	}
	
	.info5 {
			text-align: center;
			color: #A9A9A9;
	}
	
	.info6 {
			text-align: right;
	}
	
	
	.info7 {
			margin-left: 130px;
			text-align: left;
	}
	
	.info8 {
			text-align : center;
	}
	
	.info9 {
		margin-top: 15px;
		margin-left: 80px;
		text-align: center;
	}
	
	.info10 {
	
		margin-right: 80px;
		text-align: right;
	
	}
	
</style>
</head>
<body style="font-family: 'Nanum Myeongjo', serif">
	<%
		request.setCharacterEncoding("utf-8");
		String memberID = null;
		String managerID = null;
		String cosmeticKind = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		if(session.getAttribute("managerID") != null) {
			managerID = (String) session.getAttribute("managerID");
		}
		if(session.getAttribute("cosmeticKind") != null) {
			cosmeticKind = (String) session.getAttribute("cosmeticKind");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		int cosmeticID = 0;
		if (request.getParameter("cosmeticID") != null) {
			cosmeticID = Integer.parseInt(request.getParameter("cosmeticID"));
		}
		System.out.println(cosmeticID);
		
		Cosmetic cosmetic = new CosmeticDAO().getCosmetic(cosmeticID);
		
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
			</ul>
		</div>
	</nav>
		<div class="container">
			<div>
			<%
		 		CosmeticDAO cosmeticDAO = new CosmeticDAO();
				ArrayList<Cosmetic> list = cosmeticDAO.getList(pageNumber);
				int pageNum = (pageNumber - 1) * 10 + 1; //글 번호 순번
				for(int i = 6; i == 6; i++) {
			%>
			<div class="info7" style= "border:1px; float:left;">
			<tr>
				<td class="alignL"><a href="<%=list.get(i).getCosmeticKind()%>1.jsp?cosmeticID=<%= list.get(i).getCosmeticID() %>&cosmeticName=<%= list.get(i).getCosmeticName() %>&cosmeticImage=<%list.get(i).getCosmeticImage();%>&cosmeticPrice=<%list.get(i).getCosmeticPrice();%>&cosmeticContent=<%list.get(i).getCosmeticContent();%>&cosmeticCount=<%list.get(i).getCosmeticCount();%>"><img src=<%= list.get(i).getCosmeticImage()%> width="200" height="200"></a></td><br>
				<td class="alignL"><strong><a href="<%=list.get(i).getCosmeticKind()%>1.jsp?cosmeticID=<%= list.get(i).getCosmeticID() %>&cosmeticName=<%= list.get(i).getCosmeticName() %>&cosmeticImage=<%list.get(i).getCosmeticImage();%>&cosmeticPrice=<%list.get(i).getCosmeticPrice();%>&cosmeticContent=<%list.get(i).getCosmeticContent();%>&cosmeticCount=<%list.get(i).getCosmeticCount();%>"><%=list.get(i).getCosmeticName()%></a></strong></td><br>
				<td style= "text-align: center"><strong><%= list.get(i).getCosmeticPrice().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>원</strong></td>
			</tr>
			</div>
			
			<%
				}
			%>
			</div>
		</div>
		<br><br><br><br>
	<hr>
	<footer class="container">
		<p class = "text-center"> Copyright &copy; Cho Sodam All Rights Reserved.</p>
	</footer>
		<br><br><br><br>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>