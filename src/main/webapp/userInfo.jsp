<%@page import="cn.qdu.entity.*" %>
<%@page import="java.util.ArrayList" %>
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
    <script>
        $(function () {
            var totlecount = 0;

            $.post("addCart", {"action": "totalcount"}, function (msg) {
                totlecount = totlecount + parseInt(msg);
                $('.totlecount').html(totlecount);
            }, "text");
        });
    </script>
</head>
<body>
<% String str = "";
    int n = 0;
    String name = "";
    int userId = 0;
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
                            <a href="countCart" class="cart-item dropdown-toggle"> <span class="totlecount">0</span>
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
                                    <li><a href="Fruit_Servlet">鲜果</a></li>
                                    <li><a href="Fresh_Servlet">生鲜</a></li>
                                    <li><a href="Vegetables_Servlet">蔬菜</a></li>
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
        <h2>个人信息</h2>
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
                            UserInfo userInfo = (UserInfo)session.getAttribute("userInfo");
                            name = userInfo.getUserName();
                        %>
                    </div>
                    <!-- 这里是个人信息 -->
                    <form action="updateUserInfoServlet" method="post">
                        <ul id="yin_middle_middle_ul1">
                            <li class="yin_middle_middle_li"><span
                                    class="yin_middle_middle_li1">姓名：</span> <input type="text"
                                                                                    id="yin_name" name="name"
                                                                                    class="yin_middle_middle_li2"
                                                                                    value="<%out.print(userInfo.getUserName());%>"
                                                                                    readonly style="border: 0px"></li>
                            <li class="yin_middle_middle_li"><span class="yin_middle_middle_li1">邮箱：</span><input
                                    type="text"

                                    id="yin_email" name="email" class="yin_middle_middle_li2"
                                    value="<%out.print(userInfo.getEmail());%>"></li>
                            <li class="yin_middle_middle_li">
                                <spam
                                        class="yin_middle_middle_li1">电话：
                                </spam>
                                <input type="text"
                                       id="yin_tel" name="phoneNumeber" class="yin_middle_middle_li2"
                                       value="<%out.print(userInfo.getPhoneNumber());%>"></li>
                            <input type="submit" class="yin_middle_middle_li1" id="yin_middle_middle_submit"
                                   value="确认更改个人信息">
                        </ul>
                        <div id="yin_middle_address">
                            <%
                                ArrayList<AddressInfo> addresslist = (ArrayList<AddressInfo>) request.getSession().getAttribute("addresslist");
                                int a = addresslist.size();
                            %>
                            <span id="yin_middle_totel">管理收货地址:</span>
                            <ol>
                                <%
                                    for (int i = 0; i < a; i++) {
                                %>
                                <div id="yin_middle_middle_address">
									<span class="yin_middle_middle_li"> 
									<textarea id="yin_address" class="yin_address"
                                              name="<% out.print(addresslist.get(i).getAddressId());%>"><%
                                        out.print(addresslist.get(i).getProvince());
                                        out.print(addresslist.get(i).getCity());
                                        out.print(addresslist.get(i).getArea());
                                        out.print(addresslist.get(i).getStreet());
                                    %>
								</textarea>
									</span>
                                    <% n = addresslist.get(i).getAddressId();%>
                                    <a class="yin_delete" href="deleteUserAddress?addressId=<%=n%>">删除</a>

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
                        <select id="select_province" name="province"></select> <select
                            id="select_city" name="city"></select> <select id="select_area"
                                                                           name="area"></select>
                        <input type="text" id="select_street" name="street" value="香港东路">
                        <input type="button" id="yin_middle_address_button" value="确认">
                    </div>
                </div>
            </div>


            <div id="yin_middle_active2">

                <%
                    ArrayList<OrderInfo> orderlist = (ArrayList<OrderInfo>) request.getSession().getAttribute("orderList");
                    ArrayList<Object> addlist = (ArrayList<Object>) request.getSession().getAttribute("list1");
                    ArrayList<Object> prolist = (ArrayList<Object>) request.getSession().getAttribute("list2");
                    ArrayList<Object> orderItemlist = (ArrayList<Object>) request.getSession().getAttribute("list3");


                    for (int m = 0; m < orderlist.size(); m++) {
                        int orderId = orderlist.get(m).getOrderId();
                        String orderDate = orderlist.get(m).getOrderDate();
                        String orderStatus = orderlist.get(m).getOrderStatusInfo().getOrderStatus();

                        ArrayList<AddressInfo> addressList2 = (ArrayList) addlist.get(m);
                        String province = addressList2.get(0).getProvince();
                        String city = addressList2.get(0).getCity();
                        String area = addressList2.get(0).getArea();
                        String street = addressList2.get(0).getProvince();
                        String address = province + city + area + street;

                        ArrayList<ProductInfo> productlist = (ArrayList) prolist.get(m);
                        ArrayList<OrderItem> arrorderItemlist = (ArrayList) orderItemlist.get(m);


                        int size = productlist.size();
                        String productName = productlist.get(0).getProductName();
                        int productcount = arrorderItemlist.get(0).getProductCount();


                        String defaultImg = productlist.get(0).getDefaultImg();
                        float price = orderlist.get(m).getOrderPrice();


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
                        <td style="width: 80px"><%=productName %>
                        </td>
                        <td style="width: 80px"><%=productcount %>
                        </td>
                        <td style="width: 80px"><img src="images/<%=defaultImg %>" style="width: 30px;height: 25px">
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
                        <td style="width: 110px"><%out.print(productlist.get(i).getProductName());%></td>
                        <td style="width: 110px"><%out.print(arrorderItemlist.get(0).getProductCount());%></td>
                        <td style="width: 110px"><img src="images/<%out.print(productlist.get(i).getDefaultImg());%>"
                                                      style="width: 30px;height: 25px"></td>
                    </tr>
                    <%} %>
                </table>
                <%} %>
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


<script>
    region_init("select_province", "select_city", "select_area");
</script>


<script>
    $("#yin_middle_active2").hide();
    $("#active1").click(function () {
        $("#yin_middle_active1").show()
        $("#yin_middle_active2").hide()
    })
    $("#active2").click(function () {
        $("#yin_middle_active1").hide()
        $("#yin_middle_active2").show()

    })

</script>

<script>

    $("#yin_middle_address_button").click(function () {
        var str1 = $("#select_province").find("option:selected").text();
        var str2 = $("#select_city").find("option:selected").text();
        var str3 = $("#select_area").find("option:selected").text();
        var str4 = $("#select_street").val();
        var str5 = $("#yin_name").val();
        $.post("updateAddress", {
            "province": str1,
            "city": str2,
            "area": str3,
            "street": str4,
            "name": str5
        }, function (msg) {
            window.location.href = "userInfo.jsp";
        })

    })
</script>

</body>
</html>