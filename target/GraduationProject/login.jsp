<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zxx">
<head>
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="js/jquery/jquery.md5.js"></script>

    <script>
        $(function () {
            var code = ""; //在全局定义验证码

            //生成验证码
            function createCode() {
                var showCode = "";
                var codeLength = 4;//验证码的长度
                var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
                    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');//随机数
                for (var i = 0; i < codeLength; i++) {//循环操作
                    var index = Math.floor(Math.random() * 62);//取得随机数的索引（0~35）
                    code += random[index];//用于判断的验证码
                    showCode += random[index] + " ";//用于显示的验证码
                }
                return showCode;
            }

            /*干扰线的随机x坐标值*/
            function lineX() {
                var ranLineX = Math.floor(Math.random() * 90);
                return ranLineX;
            }

            /*干扰线的随机y坐标值*/
            function lineY() {
                var ranLineY = Math.floor(Math.random() * 40);
                return ranLineY;
            }

            function clickChange() {
                //var mycanvas=document.getElementById('mycanvas');
                //var cxt=mycanvas.getContext('2d');
                var cxt = $("#mycanvas").get(0).getContext('2d');
                cxt.fillStyle = '#000';
                cxt.fillRect(0, 0, 90, 40);
                /*生成干扰线20条*/
                for (var j = 0; j < 20; j++) {
                    cxt.strokeStyle = '#fff';
                    cxt.beginPath(); //若省略beginPath，则每点击一次验证码会累积干扰线的条数
                    cxt.moveTo(lineX(), lineY());
                    cxt.lineTo(lineX(), lineY());
                    cxt.lineWidth = 0.5;
                    cxt.closePath();
                    cxt.stroke();
                }
                cxt.fillStyle = 'red';
                cxt.font = 'bold 20px Arial';
                cxt.fillText(createCode(), 20, 25); //把rand()生成的随机数文本填充到canvas中
            }

//            clickChange();
//            /*点击验证码更换*/
//            mycanvas.onclick=function(e){
//                e.preventDefault(); //阻止鼠标点击发生默认的行为
//                clickChange();
//            };

            //createCode();
            clickChange();//第一次生成验证码

//            $("#chance").click(function () {
//                createCode();
//            });

            $("#input-name").blur(function () {
                $("#error").html("");
            });

            $("#input-password").blur(function () {
                $("#error").html("");
            });

            //验证码点击更换事件
            $("#mycanvas").click(function () {
                clickChange();
            });

            $("#validateCode").blur(function () {
                var inputCode = $("#validateCode").val().toUpperCase(); //取得输入的验证码并转化为大写
                if (inputCode.length <= 0) { //若输入的验证码长度为0
                    $("#error").html("请输入验证码"); //则弹出请输入验证码
                } else if (inputCode != code.toUpperCase()) { //若输入的验证码与产生的验证码不一致时
                    $("#error").html("验证码输入错误"); //则弹出验证码输入错误
                    code = "";//把全局验证码变量置空
                    clickChange();//刷新验证码
                    $("#input").val("");//清空文本框
                    $("#login").click(function () {
                        return false;
                    });
                } else { //输入正确时
                    $("#error").html(""); //弹出
                    $("#login").click(function () {
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
        </div>
    </div>
    <div class="container">
        <div class="bg-mn color-inher">
            <div class="row m-0">
                <div class="col-sm-1 col-md-1 col-lg-2 p-0">
                    <div class="dropdown category-bar">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"
                           role="button" aria-haspopup="true" aria-expanded="true">
                            <!--  <i class="fa fa-bars"></i>--><span class="li_size"> 药店商城</span>
                        </a>
                    </div>
                </div>
                <div class="col-sm-8 col-md-8 col-lg-7 p-0">
                    <div class="main-menu">
                        <nav class="navbar navbar-default menu">
                            <div class="collapse navbar-collapse"
                                 id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav li_size">
                                    <li><a href="index.jsp">主页</a></li>
                                    <li><a href="/getProducts?productTypeId=1">中药</a></li>
                                    <li><a href="/getProducts?productTypeId=2">西药</a></li>
                                    <li><a href="/getProducts?productTypeId=3">儿童药品</a></li>
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
        <h2><span style="color: #0b0b0b;font-weight: bold">登录</span></h2>
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
                        <div class="form-group">
                            <label class="control-label" for="input-name">用户名</label>
                            <input type="text" name="name" value="" placeholder="用户名"
                                   id="input-name" class="form-control form-item" style="width: 200px">
                        </div>
                        <div class="form-group m-t-30">
                            <label class="control-label" for="input-password">密码</label>
                            <input type="password" name="password" value="" placeholder="密码"
                                   id="input-password" class="form-control form-item" style="width: 200px">
                        </div>
                        <!--
                        <input id="input" style="width: 100px" placeholder="请输入验证码">
                        <span><a href="" id="chance" onclick="return false">换一换</a></span>
                        <input id="code" class="from-control" value="" style="width: 50px" readonly="readonly">
                        -->
                        <div>
                            <input type="text" name="input-validateCode" value="" placeholder="请输入验证码"
                                   id="validateCode" class="form-control form-item"
                                   style="width: 200px;float: left">
                            <canvas id="mycanvas" width='90' height='40' style="float: left">
                                您的浏览器不支持canvas，请换个浏览器试试~
                            </canvas>
                            <!--用于显示错误验证码提示信息-->
                            <div style="float: left;">
                                <span id="error" style="color: red;"></span>
                            </div>
                        </div>
                        <div style="clear: both">
                            <input type="button" id="login" value="登录" class="btn ht-btn bg-6 ">
                            <a href="register.jsp" class="btn ht-btn bg-6" class="pull-right">注册</a>
                        </div>

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
