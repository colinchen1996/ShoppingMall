<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"/>
    <style type="text/css">
        #mess1 {
            color: red
        }
        #mess2 {
            color: red
        }
        #mess3 {
            color: red
        }
        #mess4 {
            color: red
        }
    </style>
    <script type="text/javascript" src="js/jquery/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="js/jquery/jquery.md5.js"></script>

    <script>
        $(function () {
            $("#input-first-name").blur(function () {
                $("#mess1").html("");
                var val = this.value;
                if (val.length < 3) {
                    $("#mess1").html("用户名的长度至少3位！");
                    return false;
                } else {
                    $("#mess1").html("");
                }
                $.ajax({
                    url: "registerCheck",
                    type: "get",
                    data: {name: $(this).val()},
                    dataType: "text",
                    success: function (result) {
                        if (result == "true")
                            $("#mess1").html("该用户名已被使用！");
                        else
                            $("#mess1").html("");
                    },
                    error: function () {
                    }
                });
            });

            $("#input-phone").blur(function () {
                $("#mess3").html("");
                var val = this.value;
                if (val.length != 11) {
                    $("#mess3").html("手机号必须为11位！");
                    return false;
                }
                $.ajax({
                    url: "registerCheck",
                    type: "get",
                    data: {phone: $(this).val()},
                    dataType: "text",
                    success: function (result) {
                        if (result == "true")
                            $("#mess3").html("该号码已被使用！");
                        else
                            $("#mess3").html("");
                    },
                    error: function () {
                    }
                });
            });
            $("#input-email").blur(function () {
                $("#mess2").html("");
                var val = this.value;
                if (!val.match(/^\w+@\w+\.\w+$/)) {
                    $("#mess2").html("邮箱格式错误");
                    return false;
                }
                $.ajax({
                    url: "/registerCheck",
                    type: "get",
                    data: {email: $(this).val()},
                    dataType: "text",
                    success: function (result) {
                        if (result == "true")
                            $("#mess2").html("该邮箱已被使用！");
                        else
                            $("#mess2").html("");
                    },
                    error: function () {
                    }
                });
            });

            $("#input-password").blur(function () {
                $("#mess4").html("1111");
                var val = this.value;
                if (val.length < 6) {
                    $("#mess4").html("密码不能小于6位数！");
                    return false;
                }
            });

            $("#register").click(function () {
                var name = $("input[name='name']").prop("value");
                var email = $("input[name='email']").prop("value");
                var phone = $("input[name='phone']").prop("value");
                var password = $.md5($("input[name='password']").prop("value"));
                if (name == "" || email == "" || phone == "" || password == "") {
                    alert("请正确填写注册信息！");
                    return false;
                } else {
                    $.post("/register",
                        {
                            name: name,
                            email: email,
                            phone: phone,
                            password: password
                        },
                        function (result) {
                            if (result == "true") {
                                alert("注册成功！")
                                window.location.href = 'login.jsp';
                            } else {
                                alert("对不起，请重新注册！")
                            }
                        }, "text");
                }
            });
        });
    </script>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>
    <!-- JqueryUI -->
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <!-- Awesome font icons -->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" media="screen">
    <!-- Owlcoursel -->
    <link rel="stylesheet" type="text/css" href="css/owl-coursel/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="css/owl-coursel/owl.transitions.css">
    <!-- Magnific-popup -->
    <link rel="stylesheet" type="text/css" href="css/magnific-popup/magnific-popup.css">
    <!-- Style -->
    <link rel="stylesheet" type="text/css" href="css/style.css" media="screen">
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
                <a href="#" class="logo">
                    <img src="images/logo.png" alt="logo">
                </a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="bg-mn color-inher">
            <div class="row m-0">
                <div class="col-sm-1 col-md-1 col-lg-2 p-0">
                    <div class="dropdown category-bar">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="true">
                            <!--<i class="fa fa-bars"></i>--><span>药店商城</span>
                        </a>
                    </div>
                </div>
                <div class="col-sm-8 col-md-8 col-lg-7 p-0">
                    <div class="main-menu">
                        <nav class="navbar navbar-default menu">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle collapsed m-r-xs-15" data-toggle="collapse"
                                        data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                    <span class="sr-only">导航</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
                        <input type="text" class="form-item" placeholder="搜索....">
                        <%--<button type="submit" class="fa fa-search"></button>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="heading-inner-page">
    <div class="container">
        <h2><span style="color: #0b0b0b;font-weight: bold">注册</span></h2>
        <ul class="breadcrumb">
            <li><a href="#">首页</a></li>
            <li>注册</li>
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
                        <form>
                            <div class="form-group">
                                <label class="control-label" for="input-email">名字</label>
                                <input type="text" name="name" value="" placeholder="名字" id="input-first-name"
                                       class="form-control form-item" style="width: 200px">
                                <span id="mess1" class="pull-right"></span>
                            </div>

                            <div class="form-group">
                                <label class="control-labe" for="input-email">邮箱</label>
                                <input type="text" name="email" value="" placeholder="邮箱" id="input-email"
                                       class="form-control form-item" style="width: 200px">
                                <span id="mess2" class="pull-right"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-email">电话</label>
                                <input type="text" name="phone" value="" placeholder="电话" id="input-phone"
                                       class="form-control form-item" style="width: 200px">
                                <span id="mess3" class="pull-right"></span>
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="input-password">密码</label>
                                <input type="password" name="password" value="" placeholder="密码" id="input-password"
                                       class="form-control form-item" style="width: 200px">
                                <span id="mess4" class="pull-right"></span>
                            </div>
                            <div class="m-t-15">
                                <a href="#" id="register" class="btn ht-btn bg-6" class="pull-right">注册</a>
                                <a href="login.jsp" class="btn ht-btn bg-6" class="pull-right">登录</a>
                            </div>
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
            <p>Copyright &copy; 2017.Company name All rights reserved.<a target="_blank" href="#"></a></p>
        </div>
    </div>
</footer>
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

