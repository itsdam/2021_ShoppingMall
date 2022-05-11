<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@400;700;800&display=swap" rel="stylesheet">
<style type="text/css">

	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
	
	
	h1 {
		text-align: center;
	}
	
	.info {
		margin-right: 100px;
	}
	
	.info2 {
		text-align: center;
	}
	
	.info3 {
			text-align: center;
			color: #A9A9A9;
	}

</style>
<title>Cosmetic Shop</title>
</head>
<body style="font-family: 'Nanum Myeongjo', serif;">
		<p id = "p1">
			<h1 class="logo">
				<strong><a href="main.jsp">Let's Cosmetic</a></strong>
			</h1>
			<p class="info3">The beauty of a woman is not facial mode, but the true beauty in a woman is reflected in her soul.</p>
		</p>
		
		<nav class="navbar navbar-light">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login.jsp">LOGIN</a></li>
				<li class = "info"><a href="join.jsp">JOIN</a></li>
			</ul>
		</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px" >
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align: center;">로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="memberID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="memberPassword" maxlength="20">
					</div>
					<input type="submit" class="button form-control" value="로그인">	
				</form>
			</div>
		</div>
	</div>
				<p class = "info2"><a href="managerLogin.jsp">[관리자 계정으로 로그인하기]</a></p>
	<hr>
	<footer class="container">
		<p class = "text-center"> Copyright &copy; Cho Sodam All Rights Reserved.</p>
	</footer>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>
</html>