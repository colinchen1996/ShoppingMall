<%@page import="cn.qdu.entity.ProductInfo" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单</title>
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
    <!--订单引入css-->
    <link rel="stylesheet" type="text/css" href="css/fw.css" media="screen">
    <link rel="stylesheet" type="text/css" href="css/order_base.css">
    <link rel="stylesheet" type="text/css" href="css/order_check.css"/>
    <script type="text/javascript" src="js/jquery/order_jqueryr.js"></script>
    <script src="js/jquery-3.1.0.min.js"></script>
    <%
        List<ProductInfo> productList = new ArrayList<ProductInfo>();
        List countList = new ArrayList();
        if (null != (List) request.getAttribute("countList")) {
            countList = (List) request.getAttribute("countList");
        }
        if (null != (List) request.getAttribute("productInfoList")) {
            productList = (List) request.getAttribute("productInfoList");
        }
    %>
    <script>
        $(function () {

            var totlecount = 0;

            $.post("addCart", {"action": "totalcount"}, function (msg) {
                totlecount = totlecount + parseInt(msg);
                $('.totlecount').html(totlecount);
            }, "text");

            $("#logout").click(function () {       //注销
                $.ajax({
                    url: "logOut",
                    type: "post",
                    data: {},
                    dataType: "",
                    success: function (result) {
                        if (result == "true")
                            $("#user").html("");
                        else
                            $("#user").html("");
                    },
                    error: function () {
                    }
                });
            });
            var $clone = $('.add').clone(true);
            $('.add').remove();
            <%for(int i=0;i<productList.size();i++){%>
            var $Newclone = $clone.clone(true);
            var $divs = $Newclone.children();
            $divs.find('.img').html('<img src="images/<%=productList.get(i).getDefaultImg()%>"  width="40" height="40" />')
            $divs.find('.name').html('<%=productList.get(i).getProductName()%>')
            $Newclone.find('.price').html('<%=productList.get(i).getProductPrice()%>')
            $Newclone.find('.count').html('<%=countList.get(i)%>')
            var $totle =
            <%=countList.get(i)%> * <%=productList.get(i).getProductPrice()%>
            $Newclone.find('.totle').html($totle)
            $('.d').append($Newclone);
            <%}%>

            $("#yinuserInfo").click(function () {
                $.post("getUserInfo", {"name": $('#user').text()}, function () {
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
                            <a href="countOrder" class="cart-item dropdown-toggle"> <span class="totlecount">0</span>
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
        <h2>订单</h2>
    </div>
</div>
<!-- order-->
<!--收货地址body部分开始-->
<div class="border_top_cart">
    <script type="text/javascript">
        var checkoutConfig = {
            addressMatch: 'common',
            addressMatchVarName: 'data',
            hasPresales: false,
            hasBigTv: false,
            hasAir: false,
            hasScales: false,
            hasGiftcard: false,
            totalPrice: 244.00,
            postage: 10,//运费
            postFree: true,//活动是否免邮了
            bcPrice: 150,//计算界值
            activityDiscountMoney: 0.00,//活动优惠
            showCouponBox: 0,
            invoice: {
                NA: "0",
                personal: "1",
                company: "2",
                electronic: "4"
            }
        };
        var miniCartDisable = true;
    </script>
    <div class="container">
        <div class="checkout-box">
            <form id="checkoutForm" action="#" method="post">
                <div class="checkout-box-bd">
                    <!-- 地址状态 0：默认选择；1：新增地址；2：修改地址 -->
                    <input type="hidden" name="Checkout[addressState]" id="addrState" value="0">
                    <!-- 收货地址 -->
                    <div class="xm-box">
                        <div class="box-hd ">
                            <h2 class="title">收货地址</h2>
                            <!---->
                        </div>
                        <div class="box-bd">
                            <div class="clearfix xm-address-list" id="checkoutAddrList">
                                <dl class="item">
                                    <dt>
                                        <strong class="itemConsignee">小狗</strong>
                                        <span class="itemTag tag">家</span>
                                    </dt>
                                    <dd>
                                        <p class="tel itemTel">15900112233</p>
                                        <p class="itemRegion">北京 大兴区 亦庄</p>
                                        <p class="itemStreet">青年公寓</p>
                                        <!--编辑默认信息-->
                                        <!--span class="edit-btn J_editAddr">编辑</span-->
                                    </dd>
                                    <dd style="display:none">
                                        <input type="radio" name="Checkout[address]" class="addressId"
                                               value="10140916720030323">
                                    </dd>
                                </dl>
                                <div class="item use-new-addr" id="J_useNewAddr" data-state="off">
                                    <span class="iconfont onticon-add"><img src="images/add_cart.png"/></span>
                                    <div id="newaddress">使用新地址</div>
                                </div>
                            </div>
                        </div>
                        <!-- 收货地址 END-->
                        <div id="checkoutPayment">
                            <!-- 支付方式 -->
                            <div class="xm-box">
                                <div class="box-hd ">
                                    <h2 class="title">支付方式</h2>
                                </div>
                                <div class="box-bd">
                                    <ul id="checkoutPaymentList" class="checkout-option-list clearfix J_optionList">
                                        <li class="item selected">
                                            <input type="radio" name="Checkout[pay_id]" checked="checked" value="1">
                                            <p>
                                                在线支付 <span></span>
                                            </p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!-- 支付方式 END-->
                            <div class="xm-box">
                                <div class="box-hd ">
                                    <h2 class="title">配送方式</h2>
                                </div>
                                <div class="box-bd">
                                    <ul id="checkoutShipmentList" class="checkout-option-list clearfix J_optionList">
                                        <li class="item selected">
                                            <input type="radio" data-price="0" name="Checkout[shipment_id]"
                                                   checked="checked" value="1">
                                            <p>
                                                快递配送（免运费） <span></span>
                                            </p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!-- 配送方式 END-->                    <!-- 配送方式 END-->
                        </div>
                        <!-- 送货时间 -->
                        <div class="xm-box">
                            <div class="box-hd">
                                <h2 class="title">送货时间</h2>
                            </div>
                            <div class="box-bd">
                                <ul class="checkout-option-list clearfix J_optionList">
                                    <li class="item selected"><input type="radio" checked="checked"
                                                                     name="Checkout[best_time]" value="1">
                                        <p>不限送货时间<span>周一至周日</span></p></li>
                                    <li class="item "><input type="radio" name="Checkout[best_time]" value="2">
                                        <p>工作日送货<span>周一至周五</span></p></li>
                                    <li class="item "><input type="radio" name="Checkout[best_time]" value="3">
                                        <p>双休日、假日送货<span>周六至周日</span></p></li>
                                </ul>
                            </div>
                        </div>
                        <!-- 送货时间 END-->
                        <!-- 发票信息 -->
                        <div id="checkoutInvoice">
                            <div class="xm-box">
                                <div class="box-hd">
                                    <h2 class="title">发票信息</h2>
                                </div>
                                <div class="box-bd">
                                    <ul class="checkout-option-list checkout-option-invoice clearfix J_optionList J_optionInvoice">
                                        <li class="hide">
                                            电子个人发票4
                                        </li>
                                        <li class="item selected">
                                            <!--<label><input type="radio"  class="needInvoice" value="0" name="Checkout[invoice]">不开发票</label>-->
                                            <input type="radio" checked="checked" value="4" name="Checkout[invoice]">
                                            <p>电子发票（非纸质）</p>
                                        </li>
                                        <li class="item ">
                                            <input type="radio" value="1" name="Checkout[invoice]">
                                            <p>普通发票（纸质）</p>
                                        </li>
                                    </ul>
                                    <p id="eInvoiceTip" class="e-invoice-tip ">
                                        电子发票是税务局认可的有效凭证，可作为售后维权凭据，不随商品寄送。开票后不可更换纸质发票，如需报销请选择普通发票。<a
                                            href="http://bbs.xiaomi.cn/thread-9285999-1-1.html"
                                            target="_blank">什么是电子发票？</a>
                                    </p>
                                    <div class="invoice-info nvoice-info-1" id="checkoutInvoiceElectronic"
                                         style="display:none;">

                                        <p class="tip">电子发票目前仅对个人用户开具，不可用于单位报销 ，不随商品寄送</p>
                                        <p>发票内容：购买商品明细</p>
                                        <p>发票抬头：个人</p>
                                        <p>
                                            <span class="hide"><input type="radio" value="4"
                                                                      name="Checkout[invoice_type]" checked="checked"
                                                                      id="electronicPersonal"
                                                                      class="invoiceType"></span>
                                        <dl>
                                            <dt>什么是电子发票?</dt>
                                            <dd>&#903; 电子发票是纸质发票的映像，是税务局认可的有效凭证，与传统纸质发票具有同等法律效力，可作为售后维权凭据。</dd>
                                            <dd>&#903; 开具电子服务于个人，开票后不可更换纸质发票，不可用于单位报销。</dd>
                                            <dd>&#903; 您在订单详情的"发票信息"栏可查看、下载您的电子发票。<a
                                                    href="http://bbs.xiaomi.cn/thread-9285999-1-1.html" target="_blank">什么是电子发票？</a>
                                            </dd>
                                        </dl>
                                        </p>
                                    </div>
                                    <div class="invoice-info invoice-info-2" id="checkoutInvoiceDetail"
                                         style="display:none;">
                                        <p>发票内容：购买商品明细</p>
                                        <p>
                                            发票抬头：请确认单位名称正确,以免因名称错误耽搁您的报销。注：合约机话费仅能开个人发票
                                        </p>
                                        <ul class="type clearfix J_invoiceType">
                                            <li class="hide">
                                                <input type="radio" value="0" name="Checkout[invoice_type]"
                                                       id="noNeedInvoice">
                                            </li>
                                            <li class="">
                                                <input class="invoiceType" type="radio" id="commonPersonal"
                                                       name="Checkout[invoice_type]" value="1">
                                                个人
                                            </li>
                                            <li class="">
                                                <input class="invoiceType" type="radio" name="Checkout[invoice_type]"
                                                       value="2">
                                                单位
                                            </li>
                                        </ul>
                                        <div id='CheckoutInvoiceTitle' class=" hide  invoice-title">
                                            <label for="Checkout[invoice_title]">单位名称：</label>
                                            <input name="Checkout[invoice_title]" type="text" maxlength="49" value=""
                                                   class="input"> <span class="tip-msg J_tipMsg"></span>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- 发票信息 END-->
                    </div>
                    <div class="checkout-box-ft">
                        <!-- 商品清单 -->
                        <div id="checkoutGoodsList" class="checkout-goods-box">
                            <div class="xm-box">
                                <div class="box-hd">
                                    <h2 class="title">确认订单信息</h2>
                                </div>
                                <div class="box-bd">
                                    <dl class="checkout-goods-list">
                                        <dt class="clearfix">
                                            <span class="col col-1">商品名称</span>
                                            <span class="col col-2">购买价格</span>
                                            <span class="col col-3">购买数量</span>
                                            <span class="col col-4">小计（元）</span>
                                        </dt>
                                        <dd class="item clearfix d">
                                            <div class="item-row add">
                                                <div class="col col-1">
                                                    <div class="g-pic img">
                                                        <img src="images/1.jpg" width="40" height="40"/>
                                                    </div>
                                                    <div class="g-info name">
                                                        苹果
                                                    </div>
                                                </div>

                                                <div class="col col-2 price">10</div>
                                                <div class="col col-3 count">1</div>
                                                <div class="col col-4 totle">00000</div>
                                            </div>

                                        </dd>
                                    </dl>
                                    <div class="checkout-count clearfix">
                                        <div class="checkout-count-extend xm-add-buy">
                                            <h3 class="title">会员留言</h3></br>
                                            <input type="text"/>
                                        </div>
                                        <!-- checkout-count-extend -->
                                        <div class="checkout-price">
                                            <ul>
                                                <li>
                                                    订单总额：<span>39元</span>
                                                </li>
                                                <li>
                                                    活动优惠：<span>-0元</span>
                                                    <script type="text/javascript">
                                                        checkoutConfig.activityDiscountMoney = 0;
                                                        checkoutConfig.totalPrice = 39.00;
                                                    </script>
                                                </li>
                                                <li>
                                                    优惠券抵扣：<span id="couponDesc">-0元</span>
                                                </li>
                                                <li>
                                                    运费：<span id="postageDesc">0元</span>
                                                </li>
                                            </ul>
                                            <p class="checkout-total">应付总额：<span><strong
                                                    id="totalPrice">39</strong>元</span></p>
                                        </div>
                                        <!--  -->
                                    </div>
                                </div>
                            </div>

                            <!--S 加价购 产品选择弹框 -->
                            <div class="modal hide modal-choose-pro" id="J_choosePro-664">
                                <div class="modal-header">
                                    <span class="close" data-dismiss='modal'><i class="iconfont">&#xe617;</i></span>
                                    <h3>选择产品</h3>
                                    <div class="more">
                                        <div class="xm-recommend-page clearfix">
                                            <a class="page-btn-prev   J_carouselPrev iconfont"
                                               href="javascript: void(0);">&#xe604;</a><a
                                                class="page-btn-next  J_carouselNext iconfont"
                                                href="javascript: void(0);">&#xe605;</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-body J_chooseProCarousel">
                                    <div class="J_carouselWrap modal-choose-pro-list-wrap">
                                        <ul class="clearfix J_carouselList">
                                        </ul>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <a href="#" class="btn btn-disabled J_chooseProBtn">加入购物车</a>
                                </div>
                            </div>
                            <!--E 加价购 产品选择弹框 -->

                            <!--S 保障计划 产品选择弹框 -->


                        </div>
                        <!-- 商品清单 END -->
                        <input type="hidden" id="couponType" name="Checkout[couponsType]">
                        <input type="hidden" id="couponValue" name="Checkout[couponsValue]">
                        <div class="checkout-confirm">

                            <a href="#" class="btn btn-lineDakeLight btn-back-cart">返回购物车</a>
                            <!--  input type="submit" class="btn btn-primary" value="立即下单" id="checkoutToPay" />-->
                            <a class="btn btn-primary" href="order_succeed.jsp">立即下单</a>
                        </div>
                    </div>
                </div>

            </form>

        </div>
        <!-- 禮品卡提示 S-->
        <div class="modal hide lipin-modal" id="lipinTip">
            <div class="modal-header">
                <h2 class="title">温馨提示</h2>
                <p> 为保障您的利益与安全，下单后礼品卡将会被使用，<br>
                    且订单信息将不可修改。请确认收货信息：</p>
            </div>
            <div class="modal-body">
                <ul>
                    <li><strong>收&nbsp;&nbsp;货&nbsp;&nbsp;人：</strong><span id="lipin-uname"></span></li>
                    <li><strong>联系电话：</strong><span id="lipin-uphone"></span></li>
                    <li><strong>收货地址：</strong><span id="lipin-uaddr"></span></li>
                </ul>
            </div>
            <div class="modal-footer">
                <span class="btn btn-primary" id="useGiftCard">确认下单</span><span class="btn btn-dakeLight"
                                                                                id="closeGiftCard">返回修改</span>
            </div>
        </div>
        <!--  禮品卡提示 E-->
        <!-- 预售提示 S-->
        <div class="modal hide yushou-modal" id="yushouTip">
            <div class="modal-body">
                <h2>请确认收货地址及发货时间</h2>
                <ul class="list">
                    <li>
                        <strong>请确认配送地址，提交后不可变更：</strong>
                        <p id="yushouAddr"></p>
                        <span class="icon-common icon-1"></span>
                    </li>
                    <li>
                        <strong>支付后发货</strong>
                        <p>如您随预售商品一起购买的商品，将与预售商品一起发货</p>
                        <span class="icon-common icon-2"></span>
                    </li>
                    <li>
                        <strong>以支付价格为准</strong>
                        <p>如预售产品发生调价，已支付订单价格将不受影响。</p>
                        <span class="icon-common icon-3"></span>
                    </li>
                </ul>
            </div>
            <div class="modal-footer">
                <p id="yushouOk" class="yushou-ok">
                    <span class="icon-checkbox"><i class="iconfont">&#xe626;</i></span>
                    我已确认收货地址正确，不再变更</p>
                <span class="btn btn-lineDakeLight" data-dismiss="modal">返回修改地址</span>
                <span class="btn btn-primary" id="yushouCheckout">继续下单</span>

            </div>
        </div>
        <!--  预售提示 E-->

        <script type="text/javascript" src="js/jquery/order_base.min.js"></script>
        <script type="text/javascript" src="js/jquery/order_address_all.js"></script>
        <script type="text/javascript" src="js/jquery/order_checkout.min.js"></script>
    </div>

    <!--收货地址body部分结束-->
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