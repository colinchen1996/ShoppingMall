<%@page import="cn.qdu.entity.ProductInfo" %>
<%@page import="cn.qdu.entity.ProductImgInfo" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    ProductInfo productInfo = (ProductInfo) request.getAttribute("productInfo");
    List<ProductInfo> sameTypeProductList = (List<ProductInfo>) request.getAttribute("sameTypeProductList");
    List<ProductImgInfo> productImgInfoList = (List<ProductImgInfo>) request.getAttribute("productImgInfoList");
    List<ProductInfo> historyProductList = (List<ProductInfo>) request.getAttribute("historyProductList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product detail</title>

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
        $(function () {
            $.post("/getCartCount",
                function (msg) {
                    $('.totalCount').html(msg);
                }, "text");

            //减少
            $(".name41 input:eq(0)").click(function () {
                var va1 = $(this).next().attr("value");
                if (va1 <= 1) {
                    alert("商品数量不能小于1!")
                } else {
                    $(this).next().attr("value", $(this).next().attr("value") - 1);
                }

            })
            //--------------------------------------------------------------------------------------------------
            //增加
            $(".name41 input:eq(2)").click(function () {
                var va2 = $(this).prev().attr("value");
                if (va2 >= <%out.print(productInfo.getProductInventory());%>) {
                    alert("库存不足!");
                } else {
                    $(this).prev().attr("value", parseInt($(this).prev().attr("value")) + 1);

                }
            })
            //--------------------------------------------------------------------------------------------------
            $("#logout").click(function () {//注销
                alert("注销成功!");
                $("#user").html("");
                $.get("/logout");
            });

            //加入购物车
            $('.into').click(function () {
                alert("添加成功");
                $.post("/addCart", {
                    "productId": $(this).next().prop("title"),
                    "count": $(this).prev().find("input").eq(1).prop("value")
                }, function (msg) {
                    $('.totalCount').html(msg);
                }, "text");
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
<%
    request.setCharacterEncoding("UTF-8");
    String name = (String) session.getAttribute("name");

%>
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
                        if (name == null)
                            out.print("");
                        else {
                            out.print(name);
                        }
                    %></a></li>

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
                           role="button" aria-haspopup="true" aria-expanded="true"> <span
                                class="li_size"> 药店商城 </span>
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
        <h2><span style="color: #0b0b0b;font-weight: bold">商品详情</span></h2>
    </div>
</div>
<!-- Product -->
<section class="m-t-30">
    <div class="container">
        <div class="row">
            <!-- Product image gallery -->
            <div class="col-sm-6 col-md-7">
                <ul class="thumbnails p-0">
                    <li>
                        <a class="thumbnail img-large image-zoom"
                           href="images/<%out.print(productInfo.getDefaultImg());%>">
                            <img src="images/<%out.print(productInfo.getDefaultImg());%>">
                        </a>
                    </li>
                    <%
                        for (int i = 0; i < productImgInfoList.size(); i++) {
                    %>
                    <li class="image-additional">
                        <a class="thumbnail image-zoom"
                           href="images/<%out.print(productImgInfoList.get(i).getProductImg());%>">
                            <img src="images/<%out.print(productImgInfoList.get(i).getProductImg());%>">
                        </a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>

            <!-- Product decr -->
            <div class="col-sm-6 col-md-5">
                <div class="product-pare m-t-xs-60">
                    <h1>
                        <%
                            out.print(productInfo.getProductName());
                        %>
                    </h1>
                    <ul class="list-unstyled m-b-20">
                        <li><span>Fruit size:</span>4.5 inches by 4 inches</li>
                        <li><span>Matures:</span>70 to 80 days</li>
                        <li><span>Plant spacing:</span>18 to 24 inches apart</li>
                        <li><span>Plant size:</span>24 to 36 inches tall, 18 to 24
                            inches wide
                        </li>
                    </ul>
                    <button class="btn ht-btn bg-3 m-t-0">
                        库存：<%out.print(productInfo.getProductInventory());%>
                    </button>
                    <p class="product-price">
                        <%
                            out.print("$" + productInfo.getProductPrice());
                        %>
                    </p>

                    <div class="name41" style="padding-bottom: 20px">
                        <input type="button" value="-" class="a">
                        <input type="text" value="1" name="num" class="text" readonly="readonly"
                               style="width: 50px; text-align: center; ">
                        <input type="button" value="+" class="b">
                    </div>
                    <button type="button" class="btn ht-btn bg-3 m-t-0 into">加入购物车</button>
                    <div title="<%out.print(productInfo.getProductId());%>"></div>
                    <!--<div class="m-t-30">-->
                    <!--<a href="#">0 reviews</a> / <a href="#">写评论</a>-->
                    <!--</div>-->
                </div>
            </div>
        </div>
        <!-- End row -->
        <!-- Tabs -->
        <div class="row m-t-30">
            <div class="col-sm-9">
                <div class="p-30 bore">
                    <h2 class="title">商品描述</h2>
                    <h6>
                        <%
                            out.print(productInfo.getProductDetail());
                        %>
                    </h6>
                    <h5>营养成分</h5>
                    <ul class="list-border width-auto-xs">
                        <li>Calories: 46</li>
                        <li>Carbohydrates: 9g</li>
                        <li>Dietary fiber: 3g</li>
                        <li>Protein: 1g</li>
                        <li>Sugars: 6g</li>
                        <li>Vitamin A: 93% DV</li>
                        <%--<li>Vitamin C: 317%</li>
                        <li>Vitamin E: 12%</li>
                        <li>Vitamin K: 9%</li>
                        <li>Thiamin: 6%</li>
                        <li>Vitamin B6: 22%</li>
                        <li>Folate: 17%</li>
                        <li>Manganese: 8%</li>
                        <li>Potassium: 9%</li>--%>
                    </ul>
                </div>
                <!--<form class="form-horizontal p-30 bore m-t-30">

                            <h3 class="title">写评价</h3>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label m-b-10" for="input-name">您的名字</label>
                                    <input type="text" name="name" value="" id="input-name" class="form-control form-item">
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label m-b-10" for="input-review">您的意见</label>
                                    <textarea name="text" rows="5" id="input-review" class="form-control form-item"></textarea>
                                </div>
                            </div>
                            <div class="buttons clearfix">
                                <div class="">
                                    <button type="button" class="btn btn-primary ht-btn bg-6">提交</button>
                                </div>
                            </div>
                        </form>-->
            </div>
            <div class="col-sm-3">
                <div class="banner bg-img-13">
                    <div class="caption text-center">
                        <h2 class="heading-size-3 f-bold">100%</h2>
                        <h3 class="heading-size-5 f-normal">新鲜</h3>
                        <a class="btn ht-btn ht-btn-bg-2">健康美味</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Product relaed -->
<section>
    <div class="container">
        <h3 class="title">相关产品</h3>
        <div class="row product-bor">
            <div class="owl" data-items="4" data-itemsDesktop="3"
                 data-itemsDesktopSmall="2" data-itemsTablet="2" data-itemsMobile="1"
                 data-transitionstyle="backslide" data-singleItem="false"
                 data-autoplay="false" data-pag="false" data-buttons="false">
                <%
                    for (int i = 0; i < sameTypeProductList.size(); i++) {
                %>
                <div class="col-lg-12">
                    <!-- Product item -->
                    <div class="product-item">
                        <a href="/getProductDetail?idd=<%out.print(sameTypeProductList.get(i).getProductId());%>">
                            <img src="images/<% out.print(sameTypeProductList.get(i).getDefaultImg());%>">
                        </a>
                        <div class="product-caption">
                            <h4 class="product-name">
                                <a href="#"><% out.print(sameTypeProductList.get(i).getProductName()); %></a>
                            </h4>
                            <div class="product-price-group">
								<span class="product-price">
									<%
                                        out.print("$" + sameTypeProductList.get(i).getProductPrice());
                                    %>
								</span>
                            </div>
                            <div class="ht-btn-group">
                                <a href="#" onclick="return false;" class="into">加入购物车</a>
                                <div title="<% out.print(sameTypeProductList.get(i).getProductId());%>"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</section>
<section>
    <div class="container">
        <h3 class="title">浏览历史</h3>
        <div class="row product-bor">
            <div class="owl" data-items="4" data-itemsDesktop="3"
                 data-itemsDesktopSmall="2" data-itemsTablet="2" data-itemsMobile="1"
                 data-transitionstyle="backslide" data-singleItem="false"
                 data-autoplay="false" data-pag="false" data-buttons="false">
                <%
                    for (int i = historyProductList.size() - 1; i >= 0; i--) {
                %>
                <div class="col-lg-12">
                    <!-- Product item -->
                    <div class="product-item">
                        <a href="getProductDetail?idd=<%out.print(historyProductList.get(i).getProductId());%>">
                            <img src="images/<% out.print(historyProductList.get(i).getDefaultImg());%>">
                        </a>
                        <div class="product-caption">
                            <h4 class="product-name">
                                <a href="#"><% out.print(historyProductList.get(i).getProductName());%></a>
                            </h4>
                            <div class="product-price-group">
								<span class="product-price">
									<%
                                        out.print("$" + historyProductList.get(i).getProductPrice());
                                    %>
								</span>
                            </div>
                            <div class="ht-btn-group">
                                <a href="#" onclick="return false;" class="into">加入购物车</a>
                                <div title="<% out.print(historyProductList.get(i).getProductId());%>"></div>
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
    </div>
</section>
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

