<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.qdu.entity.ProductInfo"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Fruit</title>
<!-- JqueryUI -->
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
<!-- Bootstrap -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<!-- Awesome font icons -->
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"
	media="screen">
<!-- Owlcoursel -->
<link rel="stylesheet" type="text/css"
	href="css/owl-coursel/owl.carousel.css">
<link rel="stylesheet" type="text/css"
	href="css/owl-coursel/owl.transitions.css">
<!-- Magnific-popup -->
<link rel="stylesheet" type="text/css"
	href="css/magnific-popup/magnific-popup.css">
<!-- Style -->
<link rel="stylesheet" type="text/css" href="css/style.css"
	media="screen">
<!-- Fw -->
<link rel="stylesheet" type="text/css" href="css/fw.css" media="screen">
	<!-- jQuery -->
	<script src="js/jquery/jquery-2.2.4.min.js"></script>
	<!-- JqueryUI -->
	<script src="js/jquery/jquery-ui.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap/bootstrap.min.js"></script>
	<!-- Owl-coursel -->
	<script src="js/owl-coursel/owl.carousel.js"></script>
	<!-- Magnific-popup -->
	<script src="js/magnific-popup/jquery.magnific-popup.min.js"></script>
	<!-- Script -->
	<script src="js/script.js"></script>
	<script>
	<% 
	request.setCharacterEncoding("UTF-8");	
	String name =(String)session.getAttribute("name");
	%>
    $(function(){ 
		var totlecount = 0;
		
		$.post("addCart",{"action":"totalcount"},function(msg){
			totlecount = totlecount + parseInt(msg);
			$('.totlecount').html(totlecount);
		},"text"); 
    	$('.into').click(function(){  //加入购物车
    		alert("添加成功")		
				$.post("addCart",{"productId":$(this).next().prop("title"),
					"count":$(this).next().next().prop("title"),"action":"add"}
				,function(msg){
					totlecount = totlecount + parseInt(msg);
					$('.totlecount').html(totlecount);
				},"text");
			}) 
    	
        $("#logout").click(function(){       //注销	       
            $.ajax({
                url:"logOut",
                type:"post",
                data:{},
                dataType:"",
                success:function(result){
            	if(result=="true")
            		$("#user").html("");
            	else
            		$("#user").html("");           		
            },
                error : function(){}
            });
        });
    	 $("#yinuserInfo").click(function () {
             $.post("getUserInfo",{"name":$('#user').text()},function(){
           	  window.location.href="userInfo.jsp";
             },"text");
         })
    }); 
    </script>
<%
	List<ProductInfo> list = (List) request.getAttribute("freshList");
%>
</head>
<body>



	<div class="preloader">
		<i class="fa fa-spinner"></i>
	</div>
	<header>
	<div class="container">
		<div class="row top-header">
			<div class="col-sm-3 text-left">
				<a href="#" class="logo"> <img src="images/logo.png" alt="logo">
				</a>
			</div>
			<div class="col-sm-9">
				<ul class="top-link pull-right">
					<!--<li class="hidden-xs"><a href="">收藏夹</a></li>-->
					<!--<li class="hidden-xs"><a href="#">分类</a></li>-->
					<li class="hidden-xs" id="yinuserInfo"><a id="user"><% 
					if(name==null)
						out.print("");
					else{
					out.print(name);
					}
					%></a></li>
					<li class="hidden-xs"><a id="user">
					
					
					</a></li>
					<li class="dropdown hidden-xs"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"
						aria-haspopup="true" aria-expanded="false">我的账户 <span
							class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<li><a href="login.jsp">登录</a></li>
							<li><a href="register.jsp">注册</a></li>
							<li><a href="#" onclick="return false;"id="logout">注销</a></li>
						</ul></li>
					<li class="pull-right">
						<div class="cart dropdown">
							<a href="countCart" class="cart-item dropdown-toggle" > <span class="totlecount">0</span><i
								class="fa fa-cart-plus"></i>
							</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
		<div class="container">
		<div class="bg-mn color-inher">
			<div class="row m-0">
				<div class="col-sm-1 col-md-1 col-lg-2 p-0">
					<div class="dropdown category-bar">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"
							role="button" aria-haspopup="true" aria-expanded="true"> 
							<span class="li_size"> Seven商城 </span>
						</a>
						
						
					</div>
				</div>
				<div class="col-sm-8 col-md-8 col-lg-7 p-0">
					<div class="main-menu">
						<nav class="navbar navbar-default menu">
						<!-- <div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed m-r-xs-15"
								data-toggle="collapse"
								data-target="#bs-example-navbar-collapse-1"
								aria-expanded="false">
								<span class="sr-only">侧边栏导航</span> <span class="icon-bar"></span>
								<span class="icon-bar"></span> <span class="icon-bar"></span>
							</button>
						</div> -->
						<div class="collapse navbar-collapse"
							id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav li_size">
								<li><a href="index.jsp">主页</a></li>
								<li><a href="/getFruit">鲜果</a></li>
								<li><a href="/getFresh">生鲜</a></li>
								<li><a href="/getVegetables">蔬菜</a></li>
								<li><a href="about.jsp">商城简介</a></li>
							</ul>
						</div>
						</nav>
					</div>
				</div>
				<div class="col-sm-3 col-md-3 col-lg-3 p-0">
					<div class="search-box m-l-xs-15 m-r-xs-15">
						<input type="text" class="form-item" placeholder="搜索...">
						<button type="submit" class="fa fa-search"></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</header>
	<div class="heading-inner-page">
		<div class="container">
			<h2>生鲜</h2>
			<!--<ul class="breadcrumb">-->
			<!--<li><a href="#">首页</a></li>-->
			<!--<li>生鲜</li>-->
			<!--</ul>-->
		</div>
	</div>
	<!-- Login page -->
	<div>
		<div class="container text-center m-t-30">


			<div class="ht-tabs ht-tabs-product text-center">

				<!-- Tab panes -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="tab-description">
						<div class="row">
							<%
								for (int i = 0; i < list.size(); i++) {
							%>
							<div class="col-sm-6 col-md-4 col-lg-3">
								<!-- Product item -->
								<div class="product-item">
									<a
										href="Product_detail_Servlet?idd=<%out.print(list.get(i).getProductId());%>">
										<img
										src="images/<%out.print(list.get(i).getDefaultImg());%>"
										alt="image">
									</a>

									<div class="product-caption">
										<h4 class="product-name">
											<a >
												<%
													out.print(list.get(i).getProductName());
												%>
											</a>
										</h4>
										<div class="product-price-group">
											<span class="product-price">
												<%
													out.print("$" + list.get(i).getProductPrice());
												%>
											</span>
										</div>
										<div class="ht-btn-group">
											<a href="#" onclick="return false;" class="into">加入购物车</a>
											<div title="<%out.print(list.get(i).getProductId());%>"></div>
											<div title="1"></div>
										</div>
									</div>
								</div>
							</div>
							<%
								}
							%>
						<%
								for (int i = 0; i < list.size(); i++) {
							%>
							<div class="col-sm-6 col-md-4 col-lg-3">
								<!-- Product item -->
								<div class="product-item">
									<a
										href="Product_detail_Servlet?idd=<%out.print(list.get(i).getProductId());%>">
										<img
										src="images/<%out.print(list.get(i).getDefaultImg());%>"
										alt="image">
									</a>

									<div class="product-caption">
										<h4 class="product-name">
											<a >
												<%
													out.print(list.get(i).getProductName());
												%>
											</a>
										</h4>
										<div class="product-price-group">
											<span class="product-price">
												<%
													out.print("$" + list.get(i).getProductPrice());
												%>
											</span>
										</div>
										<div class="ht-btn-group">
											<a href="#" onclick="return false;" class="into">加入购物车</a>
											<div title="<%out.print(list.get(i).getProductId());%>"></div>
											<div title="1"></div>
										</div>
									</div>
								</div>
							</div>
							<%
								}
							%>
						</div>
					</div>
					<div role="tabpanel" class="tab-pane" id="tab-review"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- Process order -->
	<section class="process">
	<div class="container">
		<div class="row">
			<div class="col-sm-6 col-md-4">
				<div class="media ht-media">
					<div class="media-left">
						<i class="fa fa-phone bg-6"></i>
					</div>
					<div class="media-body">
						<h5 class="media-heading">支持 24/7: 0123-456-789</h5>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-md-4">
				<div class="media ht-media">
					<div class="media-left">
						<i class="fa fa-truck bg-2"></i>
					</div>
					<div class="media-body">
						<h5 class="media-heading">所有订单上的免费送货</h5>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-md-4">
				<div class="media ht-media">
					<div class="media-left">
						<i class="fa fa-undo bg-3"></i>
					</div>
					<div class="media-body">
						<h5 class="media-heading">100% 保证退款</h5>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
	<!-- Footer -->
	<footer class="color-inher">
	<div class="footer-top">
		<div class="container">
			<div class="row">
				<div class="col-sm-3 m-b-xs-30">
					<h3 class="title">信息</h3>
					<ul>
						<li><a href="#">关于我们</a></li>
						<li><a href="#">配送信息</a></li>
						<li><a href="#">隐私权政策</a></li>
						<li><a href="#"> 购物须知, 条款</a></li>
					</ul>
				</div>
				<div class="col-sm-3 m-b-xs-30">
					<h3 class="title">我的帐户</h3>
					<ul>
						<li><a href="#">我的帐户</a></li>
						<li><a href="#">订单历史记录</a></li>
						<li><a href="#">希望清单</a></li>
						<li><a href="#">使用指南</a></li>
					</ul>
				</div>
				<div class="col-sm-3 m-b-xs-30">
					<h3 class="title">额外部分</h3>
					<ul>
						<li><a href="#">品牌</a></li>
						<li><a href="#">礼券</a></li>
						<li><a href="#">联播电台</a></li>
						<li><a href="#">降价</a></li>
					</ul>
				</div>
				<div class="col-sm-3 m-b-xs-30">
					<h3 class="title">售后服务</h3>
					<ul>
						<li><a href="#">联系方式</a></li>
						<li><a href="#">退货</a></li>
						<li><a href="#">网站导航</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="footer-bottom">
		<div class="container">
			<p>
				Copyright &copy; 2017.Company name All rights reserved.<a
					target="_blank" href="#"></a>
			</p>
		</div>
	</div>
	</footer>


</body>
</html>
