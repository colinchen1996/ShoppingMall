<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Organic Management System</title>

<script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script src="js/bootstrap.js" type="text/javascript"></script>
<script src="js/management.js" type="text/javascript"></script>
<script src="jquery-easyui-1.5.2/jquery.easyui.min.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.5.2/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.5.2/themes/icon.css" />
<script>
	
</script>
<style>
#top {
	position: relative;
}

#top img {
	height: 200px;
}

#top div {
	border: 1px solid white;
	color: white;
	position: absolute;
	top: 70px;
	left: 500px;
}

.h1 {
	height: 60px;
	color: #337ab7;
	line-height: 40px;
}

li {
	text-align: center;
}

#middle-right {
	background-color: whitesmoke;
}

table {
	text-align: center;
	background-color: white;
}

.middle-right-table {
	margin: 20px 30px 100px 50px;
}

th {
	text-align: center;
	color: white;
	background-color: rgb(51, 122, 183);
}

#bottom h6 {
	color: rgb(51, 122, 183);
	text-align: center;
}

.red {
	border-color: red;
}
</style>

</head>
<body>
	<div class="container-fluid">
		<div id="top" class="row col-md-12">
			<img src="images/slide-img2.jpg" />
			<div>
				<h1>Organic购物商城后台管理</h1>
			</div>
		</div>
		<div id="middle" class="row">
			<div id="middle-left" class="col-md-2">
				<div class="nav nav-pills">
					<ul class="nav nav-pills nav-stacked">
						<li role="presentation" class="active"><a href="#">商品种类管理</a></li>
						<li role="presentation"><a href="#" class="li11">商品种类操作</a></li>
					</ul>
					<ul class="nav nav-pills nav-stacked">
						<li role="presentation" class="active"><a href="#">商品管理</a></li>
						<li role="presentation"><a href="#" class="li21">商品增删改查</a></li>
					</ul>
					<ul class="nav nav-pills nav-stacked">
						<li role="presentation" class="active"><a href="#">订单管理</a></li>
						<li role="presentation"><a href="#" class="li31">用户订单管理</a></li>
					</ul>
					<ul class="nav nav-pills nav-stacked">
						<li role="presentation" class="active"><a href="#">用户管理</a></li>
						<li role="presentation"><a href="#" class="li41">用户信息管理</a></li>
					</ul>
				</div>
			</div>
			<div id="middle-right" class="col-md-10">
				<div id="title">
					<ol class="breadcrumb">
						<li><a id="home">首页</a></li>
						<li><button id="prev">上一页</button></li>
						<li><button id="next">下一页</button></li>
					</ol>
				</div>
				<div class="middle-right-table">
					<table class="table table-bordered li11">
						<tr>
							<th>商品种类编号</th>
							<th>商品种类名称</th>
							<th>操作</th>
						</tr>
						<tr>
							<td><input type="text" name="productTypeId"></td>
							<td><input type="text" name="productType"></td>
							<td><button class="btn-success li111">添加</button></td>
						</tr>
					</table>

					<table class="table table-bordered li21">
						<tr>
							<th>商品编号</th>
							<th>商品名称</th>
							<th>商品单价</th>
							<th>商品库存</th>
							<th>商品描述</th>
							<th>商品类型</th>
							<th>商品图片</th>
							<th>操作</th>
						</tr>
						<tr>
							<td><input class="form-control col-sm-1" type="text"
								name="productId"></td>
							<td><input class="form-control col-sm-1" type="text"
								name="productName"></td>
							<td><input class="form-control col-md-1" type="text"
								name="productPrice"></td>
							<td><input class="form-control col-md-1" type="text"
								name="productInventory"></td>
							<td><textarea name="productDetail" cols="20" rows="2"></textarea></td>
							<td><select name="productType"></select></td>
							<td><input class="form-control col-lg-6" type="file"
								name="defaultImg"></td>
							<td><button class="li211 btn-success">添加</button></td>
						</tr>

					</table>

					<table class="table table-bordered li31">
						<tr>
							<th>订单号</th>
							<th>订单日期</th>
							<th>购买物品</th>
							<th>物品略缩图</th>
							<th>收货地址</th>
							<th>用户姓名</th>
							<th>电话号码</th>
							<th>订单总额</th>
							<th>订单状态</th>
						</tr>
					</table>

					<table class="table table-bordered li41">
						<tr>
							<th>用户ID</th>
							<th>用户名</th>
							<th>密码</th>
							<th>邮箱</th>
							<th>电话</th>
							<th>用户状态</th>
						</tr>
						<!--<tr>
							<td>904</td>
							<td>图书音像</td>
							<td><button class="btn-danger li112">删除</button></td>
						</tr>-->
					</table>
				</div>
			</div>
		</div>
		<div id="bottom">
			<h6>CopyRight 2001-2017@CHENXIN 版权所有</h6>
		</div>
	</div>

</body>
</html>