<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Map" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="cn.qdu.entity.*" %>
<%@page import="cn.qdu.dao.*" %>
<%--@page import="org.qdu.servlet.*"--%>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Checkout</title>
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
    <!-- Style 购物车样式-->
    <link rel="stylesheet" type="text/css" href="css/style_dqw.css" media="screen">
    <!-- Fw -->
    <link rel="stylesheet" type="text/css" href="css/fw.css" media="screen">
    <script src="js/jquery-3.1.0.min.js"></script>
    <%
        List<ProductInfo> productList = new ArrayList<ProductInfo>();
        List countList = new ArrayList();
        if (null != (List) request.getAttribute("countlist")) {
            countList = (List) request.getAttribute("countlist");
        }
        if (null != (List) request.getAttribute("list")) {
            productList = (List) request.getAttribute("list");
        }
        //int count = (int)request.getSession().getAttribute("count");
    %>
    <script>
        $(function () {
            var totlecount = 0;

            $.post("AddCartServlet", {"action": "totalcount"}, function (msg) {
                totlecount = totlecount + parseInt(msg);
                $('.totlecount').html(totlecount);
            }, "text");

            //删除一条记录
            $('.name61').click(function () {
                alert('是否删除')
                var index = $(this).prop('title');
                $.post("DeleteCartServlet", {"deleteProductId": index}
                    , function () {
                    }, "text");
                //-------
                $(this).parent().detach();
                $('.text').trigger('change')
            })
            //减
            $('.a').click(function () {
                if ($(this).next().prop('value') <= 1) {
                    alert('是否删除？')
                    $(this).parent().parent().parent().detach();
                    $('.text').trigger('change')
                }
                else {
                    //input 显示减1
                    $(this).next().prop('value', $(this).next().prop('value') - 1)
                    $('.text').trigger('change')
                }
            })
            //加
            $('.b').click(function () {
                //input 显示+1
                $(this).prev().prop('value', parseInt($(this).prev().prop('value')) + 1)
                $('.text').trigger('change')
            })
            //change事件
            $('.text').change(function () {
                var $price = $(this).parent().parent().next().text()
                var $count = parseInt($(this).prop('value'))
                $(this).parent().parent().next().next().html('<h6>' + $price * $count + '.00' + '</h6>')
                $totle()
            })

            //总计
            function $totle() {
                var sum = 0;
                $(".name51").each(function () {
                    sum += parseFloat($(this).text());
                    $(".name3_2").text(sum);
                })
            }

            //提交订单
            $('#content4').click(function () {
            })
            //克隆一条记录
            var $clone = $('.content2').clone(true);
            $('.text').trigger('change');
            //
            $('.content2').remove();
            //加入并修改克隆的记录
            <%for(int i=0;i<productList.size();i++){%>
            var $Newclone = $clone.clone(true);
            var $divs = $Newclone.children();
            $($divs[0]).html('<img src="images/<%=productList.get(i).getDefaultImg()%>" width="70" alt="iPhone" title="iPhone">');
            $($divs[1]).html('<h6><%=productList.get(i).getProductName()%></h6>');
            $($divs[2]).children().children(".text").prop('value', <%=countList.get(i)%>);
            $($divs[3]).html('<h6><%=productList.get(i).getProductPrice()%></h6>');
            $($divs[5]).prop('title', <%=productList.get(i).getProductId()%>);
            $('#content3').before($Newclone);
            $('.text').trigger('change');
            <%}%>

            $("#yinuserInfo").click(function () {
                $.post("getUserInfoServlet", {"name": $('#user').text()}, function () {
                    window.location.href = "userInfo.jsp";
                }, "text");
            })
        })

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

                    <li class="hidden-xs"><a id="user" href="#">

                    </a></li>
                    <li class="dropdown hidden-xs"><a href="#"
                                                      class="dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"
                                                      aria-haspopup="true" aria-expanded="false">我的账户 <span
                            class="caret"></span></a>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                            <li><a href="login.jsp">登录</a></li>
                            <li><a href="register.jsp">注册</a></li>
                            <li><a href="#" onclick="return false;" id="logout">注销</a></li>
                        </ul>
                    </li>
                    <li class="pull-right">
                        <div class="cart dropdown">
                            <a href="CartServlet" class="cart-item dropdown-toggle"> <span class="totlecount">0</span><i
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
                           role="button" aria-haspopup="true" aria-expanded="true"><!--  <i
							class="fa fa-bars"> --></i><span class="li_size"> Seven商城 </span>
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
        <h2>付款</h2>
    </div>
</div>
<!-- Checkout -->

<div id="Checkout">
    <div id="content1">
        <div class="name2"><h6>图片</h6></div>
        <div class="name3"><h6>商品名称</h6></div>
        <div class="name4"><h6>数量</h6></div>
        <div class="name5"><h6>单价</h6></div>
        <div class="name6"><h6>金额</h6></div>
        <div class="name7"><h6>操作</h6></div>
    </div>
    <div class="content2">
        <div class="name21"><img src="images/1.jpg" width="70" alt="iPhone" title="iPhone"></div>
        <div class="name31"><h6>
            名称
        </h6></div>
        <div class="name41">
            <div class="name41_1" style="margin-left:40px">
                <input type="button" value="-" class="a">
                <input type="text" value="5" name="num" class="text">
                <input type="button" value="+" class="b">
            </div>
        </div>
        <div class="name51_1"><h6>
            5
        </h6></div>
        <div class="name51"><h6>10.00</h6></div>
        <div class="name61" title="a"><a><h6>删除</h6></a></div>
    </div>
    <div id="content3">
        <div class="name3_1">合计 :</div>
        <div class="name3_2">00.00</div>
        <div class="name3_1">邮费 :</div>
        <div class="name3_2_1">00.00</div>
        <div class="name3_1">总计 :</div>
        <div class="name3_2">00.00</div>
    </div>
    <div id="content4">
        <a style="float:right;margin-right:180px;" class="btn btn-primary" href="countOrder">提交订单</a>
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

<!-- jQuery -->
<script src="js/jquery/jquery-2.2.4.min.js"></script>
<!--<script src="jquery-3.1.0.min.js" type="text/javascript"></script>-->
<!-- JqueryUI -->
<script src="js/jquery/jquery-ui.js"></script>
<script src="js/jquery/jquery-dqw.js"></script>
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
        'use strict';
        //Slider
        var $owl = $('.owl');
        $owl.each(function () {
            var $a = $(this);
            $a.owlCarousel({
                transitionStyle: $a.attr('data-transitionstyle'),
                autoPlay: JSON.parse($a.attr('data-autoplay')),
                singleItem: JSON.parse($a.attr('data-singleItem')),
                items: $a.attr('data-items'),
                itemsDesktop: [1199, $a.attr('data-itemsDesktop')],
                itemsDesktopSmall: [992, $a.attr('data-itemsDesktopSmall')],
                itemsTablet: [797, $a.attr('data-itemsTablet')],
                itemsMobile: [479, $a.attr('data-itemsMobile')],
                navigation: JSON.parse($a.attr('data-buttons')),
                pagination: JSON.parse($a.attr('data-pag')),
                navigationText: ["", ""]
            });
        });
        //Preloader
        $(window).load(function () {
            $('.preloader i').fadeOut();
            $('.preloader').delay(500).fadeOut('slow');
            $('body').delay(600).css({'overflow': 'visible'});
        });
        //Magnific-popup
        $('.image-zoom').magnificPopup({
            type: 'image',
            gallery: {
                enabled: true
            },
        });
        //Menu
        $('.navbar-toggle').on('click', function () {
            height_w();
        });

        function height_w() {
            $('.navbar-nav').css('max-height', $(window).height() - 165);
        }

        window.onresize = function () {
            height_w();
        }
        //cart dropdown
        $('.cart .dropdown-menu').on('click', function (e) {
            e.stopPropagation();
        });
        $('.category-bar a').on('click', function (e) {

            if ($('.category-bar .dropdown-menu').hasClass('display-block')) {
                $('.category-bar .dropdown-menu').removeClass('hidden-xs');
                $('.category-bar .dropdown-menu').removeClass('display-block');
                $('.category-bar .dropdown-menu').addClass('display-none');
            }
            else {
                $('.category-bar .dropdown-menu').addClass('display-block');
                $('.category-bar .dropdown-menu').removeClass('display-none');
            }
        });
        //Filter price
        $(".slider-range").slider({
            range: true,
            min: 0,
            max: 2000,
            step: 50,
            values: [500, 1000],
            slide: function (event, ui) {
                $(".slider_amount").val("$" + ui.values[0].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " - $" + ui.values[1].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                aaaa();
            }
        });
        $(".slider_amount").val("$" + $(".slider-range").slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " - $" + $(".slider-range").slider("values", 1).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));

    });
</script>
</body>
</html>