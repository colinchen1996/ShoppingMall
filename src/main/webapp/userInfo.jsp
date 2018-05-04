<%@page import="cn.qdu.entity.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- <meta http-equiv="refresh" content="0.001" /> -->
    <title>个人信息</title>
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
    <link rel="stylesheet" type="text/css" href="css/style.css" s
          media="screen">
    <link rel="stylesheet" type="text/css" href="css/newUserInfo.css"
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
    <script src=js/test.js></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=ob1e0uYTSwtPFMPRihg0mzsLWPGX4KvQ">
        //v1.5版本的引用方式：src="http://api.map.baidu.com/api?v=1.5&ak=您的密钥"
        //v1.4版本及以前版本的引用方式：src="http://api.map.baidu.com/api?v=1.4&key=您的密钥&callback=initialize"
    </script>
    <style>
        #l-map {
            height: 500px;
            width: 100%;
        }
    </style>
    <script>
        $(function () {
            region_init("select_province", "select_city", "select_area");//初始化省市区三级联动

            $("#yin_middle_active2").hide();
            $("#active1").click(function () {
                $("#yin_middle_active1").show();
                $("#yin_middle_active2").hide();
            });
            $("#active2").click(function () {
                $("#yin_middle_active1").hide();
                $("#yin_middle_active2").show();
            });

            $("#yin_middle_address_button").click(function () {
                var province = $("#select_province").find("option:selected").text();
                var city = $("#select_city").find("option:selected").text();
                var area = $("#select_area").find("option:selected").text();
                var street = $("#select_street").val();
                var userName = $("#yin_name").val();
                $.post("/addAddress",
                    {
                        "province": province,
                        "city": city,
                        "area": area,
                        "street": street,
                        "userName": userName
                    }, function () {
                        window.location.href = "userInfo.jsp";
                    });
            });

            $.post("/getCartCount",
                function (msg) {
                    $('.totalCount').html(msg);
                }, "text");

            $("#yinuserInfo").click(function () {
                var userName = $('#user').text();
                if (userName != null) {
                    window.location.href = "/getUserInfo";
                }
            });


        });
    </script>

    <!--百度地图接口-->
    <script>
        $(function () {
            $("#select_province").click(function () {
                var str1 = $("#select_province").find("option:selected").text();
                var str2 = $("#select_city").find("option:selected").text();
                var str3 = $("#select_area").find("option:selected").text();
                $("#select_street").val(str1+str2+str3);
            });
            $("#select_city").click(function () {
                var str1 = $("#select_province").find("option:selected").text();
                var str2 = $("#select_city").find("option:selected").text();
                var str3 = $("#select_area").find("option:selected").text();
                $("#select_street").val(str1+str2+str3);
            });
            $("#select_area").click(function () {
                var str1 = $("#select_province").find("option:selected").text();
                var str2 = $("#select_city").find("option:selected").text();
                var str3 = $("#select_area").find("option:selected").text();
                $("#select_street").val(str1+str2+str3);
            });
            $("#select_street").change(function () {
                addrSearch();
            });
            var marker;
            var zoomSize = 18;
            var map = new BMap.Map("l-map");
            var lon = 116.404;  //默认为北京市
            var lat = 39.915;

            //业务处理，获取业务中的经纬度，有则处理，没有则用默认北京
            if (typeof getBizPoint == "function") {
                var pointJson = getBizPoint();
                lon = pointJson.lon;
                lat = pointJson.lat;
            }

            //确定中心位置
            var point = new BMap.Point(lon, lat);
            map.centerAndZoom(point, zoomSize);

            //标注
            marker = new BMap.Marker(point);// 创建标注
            map.addOverlay(marker);             // 将标注添加到地图中
            marker.enableDragging();           // 可拖拽
            marker.addEventListener("dragend", setBizValue);

            // 添加带有定位的导航控件
            var navigationControl = new BMap.NavigationControl({
                // 靠左上角位置
                anchor: BMAP_ANCHOR_TOP_LEFT,
                // LARGE类型
                type: BMAP_NAVIGATION_CONTROL_LARGE,
                // 启用显示定位
                enableGeolocation: true
            });
            map.addControl(navigationControl);

            var geoc = new BMap.Geocoder();

            //输入地址事件处理 start
            var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
                {
                    "input": "select_street"
                    , "location": map
                });

            ac.addEventListener("onhighlight", function (e) {  //鼠标放在下拉列表上的事件
                var str = "";
                var _value = e.fromitem.value;
                var value = "";
                if (e.fromitem.index > -1) {
                    value = _value.province + _value.city + _value.district + _value.street + _value.business;
                }
                str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

                value = "";
                if (e.toitem.index > -1) {
                    _value = e.toitem.value;
                    value = _value.province + _value.city + _value.district + _value.street + _value.business;
                }
                str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
                G("searchResultPanel").innerHTML = str;
            });

            var myValue;
            ac.addEventListener("onconfirm", function (e) {    //鼠标点击下拉列表后的事件
                var _value = e.item.value;
                myValue = _value.province + _value.city + _value.district + _value.street + _value.business;
                G("searchResultPanel").innerHTML = "onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
                setPlace();
            });

            function setPlace() {
                map.clearOverlays();    //清除地图上所有覆盖物
                function myFun() {
                    var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
                    setBizValueForPoint(pp);
                    map.centerAndZoom(pp, zoomSize);
                    marker = new BMap.Marker(pp);
                    marker.enableDragging();           // 可拖拽
                    map.addOverlay(marker);    //添加标注
                    marker.addEventListener("dragend", setBizValue);
                }

                var local = new BMap.LocalSearch(map, { //智能搜索
                    onSearchComplete: myFun
                });
                local.search(myValue);
            }

            function G(id) {
                return document.getElementById(id);
            }
            //输入地址事件处理 end

            //地址转坐标
            function addrSearch(serachAddr) {
                // 创建地址解析器实例
                var myGeo = new BMap.Geocoder();
                // 将地址解析结果显示在地图上,并调整地图视野
                if (!serachAddr) {
                    serachAddr = $("#select_street").val();
                }
                myGeo.getPoint(serachAddr, function (point) {
                    if (point) {
                        setBizValueForPoint(point);
                        map.clearOverlays();
                        map.centerAndZoom(point, zoomSize);
                        marker = new BMap.Marker(point);
                        marker.enableDragging();           // 可拖拽
                        map.addOverlay(marker);    //添加标注
                        marker.addEventListener("dragend", setBizValue);
                    } else {
                        console.log("无搜索结果!")
                    }
                });

            }

            //业务方法 start
            //根据事件，设置经纬度和地址
            function setBizValue(e) {
                var point = e.point;
                setBizValueForPoint(point);
            }

            //根据Point，设置经纬度和地址
            function setBizValueForPoint(point) {
                lon = point.lng;
                lat = point.lat;
                geoc.getLocation(point, function (rs) {
                    var addComp = rs.addressComponents;
                    addr = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                    if (typeof setBizFun == "function") {
                        setBizFun({lon: lon, lat: lat, addr: addr});
                    }
                });

            }

            //根据marker，设置经纬度和地址
            function setBizValueForMarker() {
                var point = marker.getPosition();
                setBizValueForPoint(point);
            }
        })
    </script>
</head>

<body>
<%
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
                           aria-haspopup="true" aria-expanded="false">我的账户
                            <span class="caret"></span>
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
<div class="heading-inner-page">
    <div class="container">
        <h2><span style="color: #0b0b0b;font-weight: bold">个人信息</span></h2>
        <ul class="breadcrumb">
            <li><a href="#">首页</a></li>
            <li>个人信息</li>
        </ul>
    </div>
</div>
<!-- Login page -->
<div class="m-t-60">
    <div class="container">
        <div id="yin_middle">
            <div id="yin_middle_top">
                <ul class="nav nav-pills" style="width: 100%">
                    <li class="active" id="active1"
                        style="width: 49.9%; float: left; text-align: center"><a
                    >个人信息</a></li>
                    <li class="active" id="active2"
                        style="width: 49.9%; float: right; text-align: center"><a
                    >订单查询</a></li>
                </ul>
            </div>

            <div id="yin_middle_active1">
                <div id="yin_middle_middle">
                    <div>
                        <%
                            UserInfo userInfo = (UserInfo) request.getSession().getAttribute("loginUserInfo");
                        %>
                    </div>
                    <!-- 个人信息 -->
                    <form action="/updateUserInfo" method="post">
                        <ul id="yin_middle_middle_ul1">
                            <li class="yin_middle_middle_li">
                                <span class="yin_middle_middle_li1">姓名：</span>
                                <input type="text" id="yin_name" name="userName" class="yin_middle_middle_li2"
                                       value="<%out.print(name);%>" readonly style="border: 0px"></li>
                            <li class="yin_middle_middle_li"><span class="yin_middle_middle_li1">邮箱：</span>
                                <input type="text" id="yin_email" name="email" class="yin_middle_middle_li2"
                                       value="<%out.print(userInfo.getEmail());%>">
                            </li>
                            <li class="yin_middle_middle_li">
                                <span class="yin_middle_middle_li1">电话：</span>
                                <input type="text" id="yin_tel" name="phoneNumber" class="yin_middle_middle_li2"
                                       value="<%out.print(userInfo.getPhoneNumber());%>">
                            </li>
                            <input type="submit" class="yin_middle_middle_li1" id="yin_middle_middle_submit"
                                   value="确认更改个人信息">
                        </ul>
                        <div id="yin_middle_address">
                            <span id="yin_middle_totel">管理收货地址:</span>
                            <ol>
                                <%
                                    List<AddressInfo> addressList = (ArrayList<AddressInfo>) request.getSession().getAttribute("addressList");
                                    for (int i = 0; i < addressList.size(); i++) {
                                %>
                                <div id="yin_middle_middle_address">
									<span class="yin_middle_middle_li"> 
                                        <textarea id="yin_address" class="yin_address">
                                            <%
                                                out.print(addressList.get(i).getProvince()+"/");
                                                out.print(addressList.get(i).getCity()+"/");
                                                out.print(addressList.get(i).getArea()+"/");
                                                out.print(addressList.get(i).getStreet());
                                            %>
                                        </textarea>
									</span>
                                    <a class="yin_delete"
                                       href="deleteUserAddress?addressId=<%=addressList.get(i).getAddressId()%>">删除</a>
                                </div>
                                <%
                                    }
                                %>
                            </ol>
                        </div>
                    </form>
                </div>

                <div id="yin_middle_newaddress">
                    <span>新增收货地址:</span>
                    <div data-role="controlgroup" id="select_p_c_a" data-ajax="false">
                        <select id="select_province" name="province"></select>
                        <select id="select_city" name="city"></select>
                        <select id="select_area" name="area"></select>
                        <input type="text" id="select_street" name="street" style="width: 300px">
                        <input type="button" id="yin_middle_address_button" value="确认">
                    </div>
                </div>
            </div>

            <div id="yin_middle_active2">
                <%
                    List<OrderInfo> orderList = (ArrayList<OrderInfo>) request.getSession().getAttribute("orderList");
                    for (int m = 0; m < orderList.size(); m++) {
                        int orderId = orderList.get(m).getOrderId();
                        String orderDate = orderList.get(m).getOrderDate();
                        String orderStatus = orderList.get(m).getOrderStatusInfo().getOrderStatus();

                        AddressInfo addressInfo = orderList.get(m).getAddressInfo();
                        String province = addressInfo.getProvince();
                        String city = addressInfo.getCity();
                        String area = addressInfo.getArea();
                        String street = addressInfo.getProvince();
                        String address = province + city + area + street;

                        ArrayList<OrderItem> orderItemList = (ArrayList<OrderItem>) orderList.get(m).getOrderItemList();
                        int size = orderItemList.size();
                        float price = orderList.get(m).getOrderPrice();
                %>
                <table id="active2_table">
                    <tr class="active2_table_tr">
                        <th class="active2_table_th1">订单号</th>
                        <th class="active2_table_th2">订单日期</th>
                        <th class="active2_table_th3">购买物品</th>
                        <th class="active2_table_th3">购买数量</th>
                        <th class="active2_table_th4">物品略缩图</th>
                        <th class="active2_table_th5">收货地址</th>
                        <th class="active2_table_th6">订单总额</th>
                        <th class="active2_table_th3">订单状态</th>
                    </tr>
                    <tr class="active2_table_tr">
                        <td style="width: 130px" rowspan=<%=size %>><%=orderId %>
                        </td>
                        <td style="width: 150px" rowspan=<%=size %>><%=orderDate %>
                        </td>
                        <td style="width: 80px"><%
                            out.print(orderItemList.get(0).getProductInfo().getProductName());%>
                        </td>
                        <td style="width: 80px"><%out.print(orderItemList.get(0).getProductCount());%>
                        </td>
                        <td style="width: 80px"><img
                                src="images/<%out.print(orderItemList.get(0).getProductInfo().getDefaultImg());%>"
                                style="width: 30px;height: 25px">
                        </td>
                        <td style="width: 410px" rowspan=<%=size %>><%=address %>
                        </td>
                        <td style="width: 130px" rowspan=<%=size %>><%=price %>
                        </td>
                        <td style="width: 80px" rowspan=<%=size %>><%=orderStatus %>
                        </td>
                    </tr>
                    <%
                        for (int i = 1; i < size; i++) {
                    %>
                    <tr class="active2_table_tr">
                        <td style="width: 110px">
                            <%out.print(orderItemList.get(i).getProductInfo().getProductName());%>
                        </td>
                        <td style="width: 110px">
                            <%out.print(orderItemList.get(i).getProductCount());%>
                        </td>
                        <td style="width: 110px">
                            <img src="images/<%out.print(orderItemList.get(i).getProductInfo().getDefaultImg());%>"
                                 style="width: 30px;height: 25px">
                        </td>
                    </tr>
                    <%} %>
                </table>
                <%}%>
            </div>
        </div>

        <div id="searchResultPanel"
             style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
        <div id="l-map"></div>
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
                Copyright &copy; 2017.Company name All rights reserved.
                <a target="_blank" href="#"></a>
            </p>
        </div>
    </div>
</footer>
</body>
</html>