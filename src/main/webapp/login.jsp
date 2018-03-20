<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zxx">
<head>
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="js/jquery/jquery.md5.js"></script>

    <script>
        var code; //在全局定义验证码
        $(function () {
            function createCode() {
                code = "";
                var codeLength = 4;//验证码的长度
                var checkCode = $("#code");
                var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
                    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');//随机数
                for (var i = 0; i < codeLength; i++) {//循环操作
                    var index = Math.floor(Math.random() * 36);//取得随机数的索引（0~35）
                    code += random[index];//根据索引取得随机数加到code上
                }
                $("#code").val(code);//把code值赋给验证码
            }

            createCode();


            $("#chance").click(function () {
                createCode();
            });


            $("#input-name").blur(function () {
                $("#error").html("");
            });


            $("#input-password").blur(function () {
                $("#error").html("");
            });


            $("#input").blur(function () {
                var inputCode = $("#input").val().toUpperCase(); //取得输入的验证码并转化为大写
                if (inputCode.length <= 0) { //若输入的验证码长度为0
                    $("#error").html("请输入验证码"); //则弹出请输入验证码
                } else if (inputCode != code) { //若输入的验证码与产生的验证码不一致时
                    $("#error").html("验证码输入错误"); //则弹出验证码输入错误
                    createCode();//刷新验证码
                    $("#input").val("");//清空文本框
                    $("#button").click(function () {
                        return false;
                    });
                } else { //输入正确时
                    $("#error").html(""); //弹出
                    $("#button").click(function () {
                        $.post("/login",
                            {
                                userName: $("input[name='name']").prop("value"),
                                userPass: $.md5($("input[name='password']").prop("value"))
                            },
                            function (result) {
                                if (result == "true") {
                                    window.location.href = 'index.jsp';
                                }
                                else if (result == "admin") {
                                    window.location.href = 'management.jsp';
                                }
                                else if (result == "false") {
                                    $("#error").html("账户或密码错误");
                                }
                                else {
                                    $("#error").html("您的账户存在风险,已被锁定！");
                                }
                            }, "text");
                    });
                }
            });
        });
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
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

                    <li class="pull-right">
                        <div class="cart dropdown">

                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                                <li>
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#"> <img class="media-object" src="images/9.jpg"
                                                              width="50" alt="...">
                                            </a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="product-name">Lorem ipsum dolor</h4>
                                            <p>
                                                $15.0<span> x 3</span> <i class="fa fa-remove"></i>
                                            </p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#"> <img class="media-object" src="images/8.jpg"
                                                              width="50" alt="...">
                                            </a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="product-name">Lorem ipsum dolor</h4>
                                            <p>
                                                $15.0<span> x 3</span> <i class="fa fa-remove"></i>
                                            </p>
                                        </div>
                                    </div>
                                </li>
                                <li class="table-div">
                                    <ul class="table-content">
                                        <li class="row m-0">
                                            <div class="col col-xs-6">
                                                <strong>合计:</strong>
                                            </div>
                                            <div class="col col-xs-6 color-3 f-bold">$240.00</div>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <p>
                                        <a href="#" class="btn ht-btn bg-3">结账</a> <a href="#"
                                                                                      class="btn ht-btn bg-6">购物车</a>
                                    </p>
                                </li>
                            </ul>
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
                           role="button" aria-haspopup="true" aria-expanded="true"> <i
                                class="fa fa-bars"></i><span>分类</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="#"><span><img src="images/25.jpg"
                                                       width="50" alt="image"></span>蔬菜</a></li>
                            <li><a href="#"><span><img src="images/18.jpg"
                                                       width="50" alt="image"></span>西兰花</a></li>
                            <li><a href="#"><span><img src="images/16.jpg"
                                                       width="50" alt="image"></span>卷心菜</a></li>
                            <li><a href="#"><span><img src="images/22.jpg"
                                                       width="50" alt="image"></span>豆荚</a></li>
                            <li><a href="#"><span><img src="images/21.jpg"
                                                       width="50" alt="image"></span>西红柿</a></li>
                            <li><a href="#"><span><img src="images/20.jpg"
                                                       width="50" alt="image"></span>水果</a></li>
                            <li><a href="#"><span><img src="images/19.jpg"
                                                       width="50" alt="image"></span>有机</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-8 col-md-8 col-lg-7 p-0">
                    <div class="main-menu">
                        <nav class="navbar navbar-default menu">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle collapsed m-r-xs-15"
                                        data-toggle="collapse"
                                        data-target="#bs-example-navbar-collapse-1"
                                        aria-expanded="false">
                                    <span class="sr-only">导航</span> <span class="icon-bar"></span> <span
                                        class="icon-bar"></span> <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="collapse navbar-collapse"
                                 id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav">
                                    <li><a href="index.jsp">主页</a></li>
                                    <li><a href="fruit.jsp">鲜果</a></li>
                                    <li><a href="fresh.jsp">生鲜</a></li>
                                    <li><a href="vegetables.jsp">蔬菜</a></li>
                                    <li><a href="about.jsp">商城简介</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
                <div class="col-sm-3 col-md-3 col-lg-3 p-0">
                    <div class="search-box m-l-xs-15 m-r-xs-15">
                        <input type="text" class="form-item" placeholder="搜索.....">
                        <button type="submit" class="fa fa-search"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="heading-inner-page">
    <div class="container">
        <h2>登录</h2>
        <ul class="breadcrumb">
            <li><a href="index.jsp">首页</a></li>
            <li>登录</li>
        </ul>
    </div>
</div>
<!-- Login page -->
<div class="m-t-60">
    <div class="container">
        <div class="bg-img-2 position-left">
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3">
                    <div class="box p-40 p-xs-20 bg-white">
                        <form action="LoginServlet" method="post">
                            <div class="form-group">
                                <label class="control-label" for="input-name">用户名</label> <input
                                    type="text" name="name" value="" placeholder="用户名"
                                    id="input-name" class="form-control form-item"
                                    style="width: 200px">
                            </div>
                            <div class="form-group m-t-30">
                                <label class="control-label" for="input-password">密码</label> <input
                                    type="password" name="password" value="" placeholder="密码"
                                    id="input-password" class="form-control form-item"
                                    style="width: 200px"> <input id="input"
                                                                 style="width: 100px" placeholder="输入验证码"> <span><a
                                    href="" id="chance" onclick="return false">换一换</a></span> <input
                                    id="code" class="from-control" value="" style="width: 50px"
                                    readonly="readonly"> <span id="error"
                                                               style="color: red "> </span>

                            </div>
                            <input type="button" id="button" value="登录"
                                   class="btn ht-btn bg-6 "> <a href="register.jsp"
                                                                class="btn ht-btn bg-6" class="pull-right">注册</a>
                        </form>

                    </div>
                </div>
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

<!-- jQuery -->

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
</body>
</html>
