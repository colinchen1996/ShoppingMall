<%@ page import="cn.qdu.entity.UserInfo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYspanE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单成功</title>
    <link rel="stylesheet" type="text/css" href="css/order_succeed.css">
    <script src="js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript"></script>
    <%
        String orderPrice = request.getParameter("orderPrice");
        String orderId = request.getParameter("orderId");
        String address = (String) request.getSession().getAttribute("address");
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("loginUserInfo");
    %>
</head>

<body>
<div id="content">
    <div id="left">
        <a href="index.jsp"><img src="images/true.png" width="250" height="260"></a>
    </div>
    <div id="right">
        <span class="right_1">您的订单已经提交成功！</span>
        <br>
        <span class="right_2">3天内发货</span>
        <br>
        <br>
        <span class="right_3"><span>金额：</span><span class="price"><%=orderPrice%></span><span
                class="unit">元</span></span>
        <br>
        <span class="right_3"><span>订单：</span><span class="orderId"><%=orderId%></span></span>
        <br>
        <span class="right_3"><span>联系人：</span><span class="userName"><%=userInfo.getUserName()%></span>
        <span>/</span><span class="phone"><%=userInfo.getPhoneNumber()%></span>
        <br>
        <span>配送至：</span><span class="address"><%=address%></span>
        </span>
    </div>
</div>

</body>
</html>