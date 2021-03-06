<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		margin-left: 250px;
		text-align: center;
	}
	
	.info {
		margin-top: 15px;
		margin-left: 110px;
		text-align: center;
	}
	
	.info2 {
		margin-right: 40px;
	}
	
	.info3 {
		margin-right: 40px;
	}
	
	.info4 {
			text-align: right;
	}
	
	.info5 {
			text-align: center;
			color: #A9A9A9;
	}
	
	.info6 {
	
		margin-right: 40px;
		text-align: right;
	
	}
	
</style>
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
	%>
		<p id = "p1">
			<h1 class="logo">
				<strong><a href="main.jsp">Let's Cosmetic</a></strong>
			</h1>
			<p class="info5">The beauty of a woman is not facial mode, but the true beauty in a woman is reflected in her soul.</p>
		</p>
		<br>
	<nav class="navbar navbar-light">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<%
				 if (managerID != null) {
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class = "info3"><a href="logoutAction.jsp">LOGOUT</a></li>
				</ul>
				<h4><p class="info"><strong>[????????? ?????? ??????]</strong></p></h4>
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
				<li class = "info3"><a href="logoutAction.jsp">LOGOUT</a></li>
			</ul>
			<h4><p class="info"><strong><%=memberID%></strong>??? ???????????????!!</p></h4>
			
			<%
				}
			%>
			<br>	
		</div>
		
		<div class="container">
		<div class="row">
			<form method="post" action="cosmeticWriteAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">?????? ??????</th>
						</tr>
					</thead>
					<tbody>
					<tr>
						<th><label for="cosmeticKind"><strong>????????????(??????) </strong></label></th>
					    <td><input type="text" name="cosmeticKind"></td>
					</tr>
					 <tr>
					 	<th><label for="cosmeticName"><strong>????????? </strong></label></th>
					    <td><input type="text" name="cosmeticName"></td>
					 </tr>
					 <tr>
					 	<th><label for="cosmeticPrice"><strong>???????????? </strong></label></th>
					    <td><input type="text" name="cosmeticPrice"></td>
					 </tr>
					 <tr>
					 	<th><label for="cosmeticCount"><strong>?????? ??? </strong></label></th>
					    <td><input type="text" name="cosmeticCount"></td>
					 </tr>
					 <tr>
					 	<th><label for="cosmeticImage"><strong>????????? </strong></label></th>
					    <td><input type="file" name="cosmeticImage"></td>
					 </tr>
					 <tr>
					 	<th><label for="cosmeticContent"><strong>???????????? </strong></label></th>
					    <td><textarea name="cosmeticContent" placeholder='?????? ?????? ????????? ???????????????.' cols="30" rows="5"></textarea></td>
					 </tr>
					 <tr>
					</tbody>
				</table>
				<!-- ????????? ?????? ?????? -->
				<input type="submit" class="button pull-right" value="??????">
			</form>
		</div>
	</div>
		<hr>
	<footer class="container">
		<p class = "text-center"> Copyright &copy; Cho Sodam All Rights Reserved.</p>
	</footer>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>