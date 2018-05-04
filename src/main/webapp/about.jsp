<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us</title>
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
    <script src="js/jquery/jquery-2.2.4.min.js"></script>

    <script>
        <%
            request.setCharacterEncoding("UTF-8");
            String name =(String)session.getAttribute("name");
        %>
        $(function () {
            $.post("/getCartCount",
                function (msg) {
                    $('.totalCount').html(msg);
                }, "text");

            $("#logout").click(function () {//注销
                alert("注销成功!");
                $("#user").html("");
                $.get("/logout");
            });

            $("#yinuserInfo").click(function () {
                var userName = $('#user').text();
                if (userName != null) {
                    window.location.href = "/getUserInfo";
                }
            });
        });
    </script>
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
                    <li class="hidden-xs" id="yinuserInfo">
                        <a id="user"><%
                            if (name == null)
                                out.print("");
                            else {
                                out.print(name);
                            }
                        %></a>
                    </li>
                    <li class="hidden-xs">
                        <%--<a id="user"></a>--%>
                    </li>
                    <li class="dropdown hidden-xs">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"
                           aria-haspopup="true" aria-expanded="false">我的账户
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                            <li><a href="login.jsp">登录</a></li>
                            <li><a href="register.jsp">注册</a></li>
                            <li><a href="#" onclick="return false;" id="logout">注销</a></li>
                        </ul>
                    </li>
                    <li class="pull-right">
                        <div class="cart dropdown">
                            <a href="countCart" class="cart-item dropdown-toggle"> <span class="totalCount">0</span>
                                <i class="fa fa-cart-plus"></i>
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
                            <span class="li_size"> 药店商城 </span>
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
        <h2><span style="color: #0b0b0b;font-weight: bold">关于我们</span></h2>
    </div>
</div>
<!-- About -->
<section>
    <div class="container">
        <div class="bg-img-2">
            <div class="row">
                <div class="col-sm-9 pull-right">
                    <div class="box p-40 bg-white">
                        <h1 class="title f-30 m-b-0">欢迎进入本商城</h1>
                        <h6>
                            鲜果之家是一家基于互联网技术的现代鲜果服务供应商，提供高品质鲜果产品和个性化鲜果服务。公司于厦门起航，致力于与您共同行动，改善中国水果安全现状，成为中国优质水果提供者。我们精选全球鲜果美食，搭建从产地到消费者之间的直供平台，自建冷库，冷链物流。便利宅送，全年无休。主营中高端水果产品，包括进口鲜果和国内优质鲜果。</h6>
                        <h6>鲜果之家拥有网站订购，电话订购，电视购物（东方CJ）、企业直供（大客户定制）和实体服务点等多元供应渠道。团体大客户，可享受量身定制产品的服务。</h6>
                        <h6>产品特色来自美国、新西兰、意大利、澳大利亚、智利、墨西哥、东南亚、韩国等地的世界优质单品鲜果，国内精品鲜果，以及品种丰富的鲜果礼篮礼盒，鲜果储值卡、提货券等。</h6>
                        <h6>
                            国内领先的水果团购平台，超过十万会员网购水果！全球超过30家果园新鲜直供进口水果、台湾水果,水果礼盒,水果篮！全程冷链、24小时新鲜直达！在水果安全每况愈下的今天，我们的想法很简单，就是想让自己的亲人不用忧虑，朋友不用担心，从此可以像吃饭一样地吃水果。我们希望能与你一起，共同行动，建筑优质水果生态链，让生活原汁原味。</h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
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

</body>
</html>

