<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="cn.qdu.entity.ProductInfo" %>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>

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
        $(function () {
            $.post("/getCartCount",
                function (msg) {
                    $('.totalCount').html(msg);
                }, "text");

            $.post("/getRecommendProduct", {a: "s"}, function (msg) {
                $.each(msg, function (i, list) {   //循环下部分商品推荐
                    $("#ca_1").append(			//循环输出首页中部商品推荐内容
                        "<div class='col-sm-6 col-md-4 col-lg-3'>"
                        + "<div class='product-item'>"
                        + "<a href='/getProductDetail?idd=" + list.productId + "'>"
                        + "<img src='images/" + list.defaultImg + "' alt='image'>"
                        + "</a><div class='product-caption'>"
                        + "<h4 class='product-name'>"
                        + "<a>" + list.productName + "</a>"
                        + "</h4><div class='product-price-group'>"
                        + "<span class='product-price''>$" + list.productPrice + "</span>"
                        + "</div>"
                        + "<div class='ht-btn-group' >"
                        + "<a href='#' onclick='return false;' class='into'>加入购物车</a>"
                        + "<div title='" + list.productId + "'></div>"
                        + "</a></div></div></div></div>"
                    );

                });

                $('.into').click(function () {  //加入购物车
                    alert("添加成功!");
                    $.post("/addCart",
                        {
                            "productId": $(this).next().prop("title"),
                            "count": 1
                        }
                        , function (msg) {
                            $('.totalCount').html(msg);
                        }, "text");
                })
            }, "json");

            $("#logout").click(function () {//注销
                alert("注销成功!");
                $("#user").html("");
                $.get("/logout");
            });

            <%
              request.setCharacterEncoding("UTF-8");
              String name =(String)session.getAttribute("name");
            %>
            $("#yinuserInfo").click(function () {
                var userName = $('#user').text();
                if (userName != null) {
                    window.location.href = "/getUserInfo";
                }
            });
        })
    </script>
</head>

<body class="bg-m">
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
                    <li class="dropdown hidden-xs">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"
                           aria-haspopup="true" aria-expanded="false">我的账户 <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                            <li><a href="login.jsp">登录</a></li>
                            <li><a href="register.jsp">注册</a></li>
                            <li><a href="#" onclick="return false;" id="logout">注销</a></li>
                        </ul>
                    </li>
                    <li class="pull-right">
                        <div class="cart dropdown">
                            <a href="/countCart" class="cart-item dropdown-toggle"> <span class="totalCount">0</span>
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
                            <!--  <i class="fa fa-bars"></i>--><span class="li_size"> 药店商城 </span>
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
<!-- Banner -->
<section class="m-t-0">
    <div class="container">
        <div class="row slider slider-1">
            <div class="owl" data-items="4" data-itemsDesktop="3"
                 data-itemsDesktopSmall="2" data-itemsTablet="2" data-itemsMobile="1"
                 data-transitionstyle="fade" data-singleItem="true"
                 data-autoplay="true" data-pag="false" data-buttons="false">
                <div class="col-sm-8 col-md-9 pull-right">
                    <div class="slider-item">
                        <img src="images/bg-12.png" alt="image">
                        <div class="slider-caption">
                            <h3 class="heading-size-3">100% 纯天然</h3>
                            <h2 class="heading-size-1">中药</h2>
                            <h4 class="heading-size-5">药材品种齐全，物美价廉</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8 col-md-9 pull-right">
                    <div class="slider-item">
                        <img src="images/bg-13.png" alt="image">
                        <div class="slider-caption">
                            <h3 class="heading-size-3">严格质检</h3>
                            <h2 class="heading-size-1">西药</h2>
                            <h4 class="heading-size-5">保障药品安全、有效、均一、稳定</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8 col-md-9 pull-right">
                    <div class="slider-item">
                        <img src="images/bg-21.png" alt="image">
                        <div class="slider-caption">
                            <h3 class="heading-size-3">安全用药</h3>
                            <h1 class="heading-size-1">儿童药品</h1>
                            <h4 class="heading-size-5">规范药物使用，降低儿童用药风险</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="m-t-0">
    <div class="container">
        <div class="row m-0">
            <div class="col-sm-4 m-b-30 p-0">
                <div class="banner bg-img-8 bg-2">
                    <div class="caption">
                        <h2 class="heading-size-4">中药</h2>
                        <h3 class="heading-size-6 f-normal">有效成分不易散失</h3>
                        <a href="/getProducts?productTypeId=1" class="btn ht-btn ht-btn-bg-2">商品详情</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 m-b-30 p-0">
                <div class="banner bg-img-0 bg-6">
                    <div class="caption">
                        <h2 class="heading-size-4">西药</h2>
                        <h3 class="heading-size-6 f-normal">短期内效果明显</h3>
                        <a href="/getProducts?productTypeId=2" class="btn ht-btn ht-btn-bg-2">商品详情</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 p-0">
                <div class="banner bg-img-7 bg-3">
                    <div class="caption">
                        <h2 class="heading-size-4">儿童药品</h2>
                        <h3 class="heading-size-6 f-normal">降低儿童用药风险</h3>
                        <a href="/getProducts?productTypeId=3" class="btn ht-btn ht-btn-bg-2">商品详情</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Product tabs -->
<div>
    <div class="container text-center m-t-30">
        <div class="ht-tabs ht-tabs-product text-center">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs m-b-20" role="tablist">
                <li role="presentation">
                    <a>
                        <p><img src="images/bg-7.png" alt="image"></p>
                        <h3 class="title f-30">商</h3>
                    </a>
                </li>
                <li role="presentation">
                    <a>
                        <p><img src="images/bg-8.png" alt="image"></p>
                        <h3 class="title f-30">品</h3>
                    </a>
                </li>
                <li role="presentation">
                    <a>
                        <p><img src="images/bg-9.png" alt="image"></p>
                        <h3 class="title f-30">推</h3>
                    </a>
                </li>
                <li role="presentation">
                    <a>
                        <p><img src="images/bg-10.png" alt="image"></p>
                        <h3 class="title f-30">荐</h3>
                    </a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="tab-description">
                    <div class="row" id="ca_1">
                        <!-- 	/* <div class="col-sm-6 col-md-4 col-lg-3">
                                <div class="product-item">
                                    <a href="product_detail.html"> <img src="images/14.jpg"
                                        alt="image">
                                    </a>
                                    <div class="product-caption">
                                        <h4 class="product-name">
                                            <a href="#">菠萝</a>
                                        </h4>
                                        <div class="product-price-group">
                                            <span class="product-price" title="3">$64.00</span>
                                        </div>
                                        <div class="ht-btn-group">

                                            <a class="into" title="2" href="#">加入购物车</a>
                                        </div>
                                    </div>
                                </div>
                            </div> */ -->
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="tab-review">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Product slider-->
<!-- <section class="text-center">
	<div class="container">
		<h3 class="title f-30">特色商品</h3>

		<div class="row">
			<div class="owl" data-items="4" data-itemsDesktop="3"
				data-itemsDesktopSmall="2" data-itemsTablet="2" data-itemsMobile="1"
				data-transitionstyle="backslide" data-singleItem="false"
				data-autoplay="false" data-pag="false" data-buttons="false">
				<div  id="ca_2"></div>
				<div class="col-lg-12">
					Product item
					<div class="product-item">
						<a href="product_detail.html"> <img src="images/8.jpg"
							alt="image">
						</a>
						<div class="product-caption">
							<h4 class="product-name">
								<a href="#">甜椒</a>
							</h4>
							<div class="product-price-group">
								<span class="product-price">$64.00</span>
							</div>
							<div class="ht-btn-group">
								<a href="#" class="wishlist_btn"><i class="fa fa-heart-o"></i></a>
								<a href="#">加入购物车</a> <a href="#" class="compare_btn"><i
									class="fa fa-exchange"></i></a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-12">
					Product item
					<div class="product-item">
						<a href="product_detail.html"> <img src="images/14.jpg"
							alt="image">
						</a>
						<div class="product-caption">
							<h4 class="product-name">
								<a href="#">菠萝</a>
							</h4>
							<div class="product-price-group">
								<span class="product-price">$64.00</span>
							</div>
							<div class="ht-btn-group">
								<a href="#" class="wishlist_btn"><i class="fa fa-heart-o"></i></a>
								<a href="#">加入购物车</a> <a href="#" class="compare_btn"><i
									class="fa fa-exchange"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section> -->
<!-- Testimonials -->
<section class="text-center m-t-30">
    <div class="container">
        <div class="bg-img-1">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-4">
                    <div class="testimonials">
                        <h3 class="title f-30">种类介绍</h3>
                        <div class="owl" data-items="4" data-itemsDesktop="3"
                             data-itemsDesktopSmall="2" data-itemsTablet="2"
                             data-itemsMobile="1" data-transitionstyle="fade"
                             data-singleItem="true" data-autoplay="true" data-pag="true"
                             data-buttons="false">
                            <div class="testimonial-item">
                                <span><img src="images/黄芪.jpg" alt="image"></span>
                                <p>
                                    根圆柱形，有的有分枝，上端较粗，略扭曲，长30～90cm，直径0.7～3.5cm。表面淡棕黄色至淡棕褐色，有不规则纵皱纹及横长皮孔，栓皮易剥落而露出黄白色皮部，有的可见网状纤维束。质坚韧，断面强纤维性。气微，味微甜，有豆腥味。</p>
                                <strong>黄芪</strong>
                            </div>
                            <div class="testimonial-item">
                                <span><img src="images/铁皮石斛.jpg" alt="image"></span>
                                <p>
                                    铁皮石斛又名黑节草，属气生兰科草本植物。石斛可分为黄草、金钗、马鞭等数十种，铁皮石斛为石斛之极品，它因表皮呈铁绿色而得名。铁皮石斛具有独特的药用价值，生于树上和岩石上。多加工成枫斗。原产中国安徽大别山、浙东天台山、福建宁化、广西天峨、云南文山以及四川等地，多分布于海拔近千米的山地半阴湿岩石上，一般均能耐－5℃的低温。</p>
                                <strong>铁皮石斛</strong>
                            </div>
                            <div class="testimonial-item">
                                <span><img src="images/何首乌.jpg" alt="image"></span>
                                <p>
                                    本品呈团块状或不规则纺锤形，长6～15cm，直径4～12cm。表面红棕色或红褐色，皱缩不平，有浅沟，并有横长皮孔及细根痕。体重，质坚实，不易折断，断面浅黄棕色或浅红棕色，显粉性，皮部有4～11个类圆形异型维管束环列，形成云锦状花纹，中央木部较大，有的呈木心。气微，味微苦而甘涩。</p>
                                <strong>何首乌</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Product slider-->
<!-- 	<section class="text-center"> -->
<!-- <div class="container">
    <h3 class="title f-30">特色商品</h3>

    <div class="row" >
        <div class="owl" data-items="4" data-itemsDesktop="3"
            data-itemsDesktopSmall="2" data-itemsTablet="2" data-itemsMobile="1"
            data-transitionstyle="backslide" data-singleItem="false"
            data-autoplay="false" data-pag="false" data-buttons="false"  >

            <div id="ca_2"></div>
            <div class="col-lg-12">
                <div class="product-item">
                    <a href="Product_detail_Servlet?idd=1"> <img
                        src="images/8.jpg" alt="image">
                    </a>
                    <div class="product-caption">
                        <h4 class="product-name">
                            <a href="#">2椒</a>
                        </h4>
                        <div class="product-price-group">
                            <span class="product-price">$64.00</span>
                        </div>
                        <div class="ht-btn-group">
                            <a href="#" class="wishlist_btn"><i class="fa fa-heart-o"></i></a>
                            <a href="#">加入购物车</a> <a href="#" class="compare_btn">
                            <i class="fa fa-exchange"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="product-item">
                    <a href="Product_detail_Servlet?idd=1"> <img
                        src="images/8.jpg" alt="image">
                    </a>
                    <div class="product-caption">
                        <h4 class="product-name">
                            <a href="#">1椒</a>
                        </h4>
                        <div class="product-price-group">
                            <span class="product-price">$64.00</span>
                        </div>
                        <div class="ht-btn-group">
                            <a href="#" class="wishlist_btn"><i class="fa fa-heart-o"></i></a>
                            <a href="#">加入购物车</a> <a href="#" class="compare_btn">
                            <i class="fa fa-exchange"></i></a>
                        </div>
                    </div>
                </div>
            </div>
                <div class="col-lg-12">
                        Product item
                        <div class="product-item">
                            <a href="product_detail.html">
                                <img src="images/25.jpg" alt="image">
                            </a>
                            <div class="product-caption">
                                <h4 class="product-name">
                                    <a href="#">玉米</a>
                                </h4>
                                <div class="product-price-group">
                                    <span class="product-price">$64.00</span>
                                </div>
                                <div class="ht-btn-group">
                                    <a href="#" class="wishlist_btn"><i class="fa fa-heart-o"></i></a>
                                    <a href="#">加入购物车</a>
                                    <a href="#" class="compare_btn"><i class="fa fa-exchange"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>


        </div>
    </div>
</div> -->
<!-- 	</section> -->
<section class="m-t-30">
    <div class="container text-center">
        <h3 class="title f-30">博客文章</h3>

        <div class="row m-t-30">
            <div class="owl" data-items="3" data-itemsDesktop="3"
                 data-itemsDesktopSmall="2" data-itemsTablet="2" data-itemsMobile="1"
                 data-transitionstyle="fade" data-singleItem="false"
                 data-autoplay="false" data-pag="false" data-buttons="false">
                <div class="col-sm-12">
                    <div class="blog-item m-b-0">
                        <a class="blog-img"> <img src="images/banner1.jpg"
                                                  alt="image">
                        </a>
                        <div class="blog-caption">
                            <ul class="blog-date">
                                <li><i class="fa fa-clock-o"></i>五月 04, 2018</li>
                                <li><a><i class="fa fa-comments-o"></i>红参</a></li>
                            </ul>
                            <h3 class="blog-heading">
                                <a>中药的一种，属伞形目、五加科植物</a>
                            </h3>
                            <p>红参环纹不明显，有枝根痕，根茎上部土黄色，顶端有芦碗，习称“油盏头”。本品特征：质坚，体重且脆，气香，味微苦。</p>
                            <a href="https://baike.baidu.com/item/%E7%BA%A2%E5%8F%82/5132842?fr=aladdin"
                               class="btn ht-btn ht-btn-1">
                                <i class="fa fa-long-arrow-right"></i>读取更多</a>
                        </div>
                    </div>
                </div>
                <!--end blog-->
                <div class="col-sm-12">
                    <div class="blog-item m-b-0">
                        <a class="blog-img">
                            <img src="images/banner2.jpg" alt="image">
                        </a>
                        <div class="blog-caption">
                            <ul class="blog-date">
                                <li><i class="fa fa-clock-o"></i>五月 04, 2018</li>
                                <li><a><i class="fa fa-comments-o"></i>阿莫西林</a></li>
                            </ul>
                            <h3 class="blog-heading">
                                <a>抗生素类药，杀菌作用强</a>
                            </h3>
                            <p>阿莫西林是目前应用较为广泛的口服青霉素之一，其制剂有胶囊、片剂、颗粒剂、分散片等等。青霉素过敏及青霉素皮肤试验阳性患者禁用。</p>
                            <a href="https://baike.baidu.com/item/%E9%98%BF%E8%8E%AB%E8%A5%BF%E6%9E%97/113694?fr=aladdin"
                               class="btn ht-btn ht-btn-1">
                                <i class="fa fa-long-arrow-right"></i>读取更多</a>
                        </div>
                    </div>
                </div>
                <!--end blog-->
                <div class="col-sm-12">
                    <div class="blog-item m-b-0">
                        <a class="blog-img">
                            <img src="images/banner3.jpg" alt="image">
                        </a>
                        <div class="blog-caption">
                            <ul class="blog-date">
                                <li><i class="fa fa-clock-o"></i>五月 04, 2018</li>
                                <li><a><i class="fa fa-comments-o"></i>儿童药品</a></li>
                            </ul>
                            <h3 class="blog-heading">
                                <a>指14岁以下未成年人使用的专用药品</a>
                            </h3>
                            <p>儿童作为特殊的用药群体，他们有自己独特的生理特点。儿科疾病的药物治疗比成人要复杂得多，应根据不同时期孩子特点和具体病情确定治疗方案。</p>
                            <a href="https://baike.baidu.com/item/%E5%84%BF%E7%AB%A5%E8%8D%AF%E5%93%81/12778062"
                               class="btn ht-btn ht-btn-1">
                                <i class="fa fa-long-arrow-right"></i>读取更多</a>
                        </div>
                    </div>
                </div>
                <%--<div class="col-sm-12">
                    <div class="blog-item m-b-0">
                        <a class="blog-img"> <img src="images/banner4.jpg"
                                                  alt="image">
                        </a>
                        <div class="blog-caption">
                            <ul class="blog-date">
                                <li><i class="fa fa-clock-o"></i>五月 04, 2018</li>
                                <li><a><i class="fa fa-comments-o"></i>3</a></li>
                            </ul>
                            <h3 class="blog-heading">
                                <a>非转基因的西红柿</a>
                            </h3>
                            <p>场出现了很多转基因食品。如西红柿，油，玉米等。当我们去超市选购转基因食品时，面对商家的广告语，作为消费者，真的能辨别吗？</p>
                            <a
                                    href="https://jingyan.baidu.com/article/e2284b2b289ab6e2e6118d31.html"
                                    class="btn ht-btn ht-btn-1"><i
                                    class="fa fa-long-arrow-right"></i>读取更多</a>
                        </div>
                    </div>
                </div>--%>
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

            <p>
                Copyright &copy; 2017.Company name All rights reserved.<a
                    target="_blank" href="#"></a>
            </p>
        </div>
    </div>
</footer>

</body>
</html>