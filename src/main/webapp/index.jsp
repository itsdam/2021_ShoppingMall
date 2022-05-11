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
		margin-left: 100px;
		text-align: center;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
		<p id = "p1">
			<h1 class="logo">
				<a href="main.jsp">Let's Cosmetic</a>
			</h1>
		</p>
	<nav class="navbar navbar-light">

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<% 
				if(userID == null) {
		
			%>
			<ul class="nav navbar-nav navbar-right">
						<li><a href="login.jsp">LOGIN</a></li>
						<li><a href="join.jsp">JOIN</a></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
						<li><a href="logoutAction.jsp">LOGOUT</a></li>
			</ul>
			<%
				}
			%>		
		</div>
			<form method="post" class="pull-center" action="srchbbs.jsp">
			<fieldset>
					<select name="searchType">
						<option value="All">전체</option>
						<option value="Hair">Skin</option>
						<option value="Face">Face</option>
						<option value="Eyes">Eyes</option>
						<option value="Lip">Lip</option>
						<option value="Lip">Hair</option>
						<option value="Lip">Body</option>
						<option value="Lip">Etc</option>
					</select>
					<input type="text" size="40" placeholder="검색어를 입력하세요!" name="keyword">
					<button>검색</button>
            </fieldset> 
            </form>   
	</nav>
	<div class="container">
	  <div id="myCarousel" class="carousel slide" data-ride="carousel">
	      <ol class="carousel-indicators">
	       <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	       <li data-target="#myCarousel" data-slide-to="1"></li>
	       <li data-target="#myCarousel" data-slide-to="2"></li>
	     </ol>
	 <div class="carousel-inner">
	    <div class="item active"> 
	     	<img src="1.png">
	    </div>
	    <div class="item">
	     	<img src="2.png">
	    </div>
	    <div class="item">
	     	<img src="3.png">
	    </div>
	    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
	     	<span class="glyphicon glyphicon-chevron-left"></span>
	    </a>
	   	<a class="right carousel-control" href="#myCarousel" data-slide="next">
	     	<span class="glyphicon glyphicon-chevron-right"></span>
	    </a>
	   </div>
	  </div>
	 </div>

	<nav class="navbar navbar-default"> 
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-center">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">기초화장품<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="skincare.jsp">스킨케어</a></li>
						<li><a href="cleansing.jsp">클렌징</a></li>
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
						<li><a href="powder.jsp">파우더&팩트</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">아이메이크업<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="eyebrow.jsp">아이브로우</a></li>
						<li><a href="eyeshadow.jsp">아이섀도우</a></li>
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
						<li><a href="lip-balm.jsp">립밤</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">헤어케어<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="shampoo.jsp">샴푸/린스</a></li>
						<li><a href="treatment.jsp">트리트먼트/헤어팩</a></li>
						<li><a href="dyeing.jsp">염색약/펌</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">바디케어<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="deodorant.jsp">데오도란트</a></li>
						<li><a href="lotion.jsp">로션/크림</a></li>
						<li><a href="depilation.jsp">제모용품</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">건강/위생용품<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="dentalcare.jsp">덴탈케어</a></li>
						<li><a href="spotpatch.jsp">스팟패치/의료용품</a></li>
						<li><a href="eyecare.jsp">아이케어</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<hr>
	<body>
	<footer class="container">
		<p class = "text-center"> Copyright &copy; Cho Sodam All Rights Reserved.</p>
	</footer>
</body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>