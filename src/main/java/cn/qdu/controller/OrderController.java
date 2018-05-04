package cn.qdu.controller;

import cn.qdu.dao.AddressInfoDao;
import cn.qdu.dao.OrderInfoDao;
import cn.qdu.dao.OrderItemDao;
import cn.qdu.dao.ProductInfoDao;
import cn.qdu.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class OrderController {

    @Autowired
    OrderInfoDao orderInfoDao;
    @Autowired
    OrderItemDao orderItemDao;
    @Autowired
    AddressInfoDao addressInfoDao;
    @Autowired
    ProductInfoDao productInfoDao;

    /**
     * 购物车结算进入下单页面
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/countOrder")
    public String countOrder(HttpServletRequest request) {
        String userName = (String) request.getSession().getAttribute("name");
        if (userName == null) {
            return "false1";
        }
        Map<Integer, Integer> productIdAndCount = (HashMap<Integer, Integer>) request.getSession().getAttribute("productIdAndCount");
        if (productIdAndCount == null || productIdAndCount.isEmpty()) {
            return "false2";
        }
        Map<ProductInfo, Integer> productInfoAndCount = new HashMap<ProductInfo, Integer>();
        for (Integer productId : productIdAndCount.keySet()) {
            ProductInfo productInfo = productInfoDao.selectByPrimaryKey(productId);
            Integer count = productIdAndCount.get(productId);
            productInfoAndCount.put(productInfo, count);
        }
        request.getSession().setAttribute("productInfoAndCount", productInfoAndCount);
        return "true";
    }


    @RequestMapping("/orderSucceed")
    public String orderSuccessd(HttpServletRequest request, OrderInfo orderInfo) {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        orderInfo.setOrderDate(sdf.format(date));
        OrderStatusInfo orderStatusInfo = new OrderStatusInfo();
        orderStatusInfo.setOrderStatusId(0);
        orderInfo.setOrderStatusInfo(orderStatusInfo);
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("loginUserInfo");
        orderInfo.setUserInfo(userInfo);
        Map<ProductInfo, Integer> productInfoAndCount = (HashMap<ProductInfo, Integer>) request.getSession().getAttribute("productInfoAndCount");
        orderInfoDao.insert(orderInfo);
        int orderId = orderInfo.getOrderId();
        for (ProductInfo productInfo : productInfoAndCount.keySet()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setProductInfo(productInfo);
            orderItem.setProductCount(productInfoAndCount.get(productInfo));
            orderItemDao.insert(orderItem);
        }
        //下完单清空购物车
        request.getSession().setAttribute("productIdAndCount", new HashMap());
        request.getSession().setAttribute("productInfoAndCount", new HashMap());
        AddressInfo addressInfo = addressInfoDao.selectByAddressId(orderInfo.getAddressInfo().getAddressId());
        String address = addressInfo.getProvince()+"/" + addressInfo.getCity()+"/" + addressInfo.getArea()+"/" + addressInfo.getStreet();
        request.getSession().setAttribute("address",address);
        return "redirect:order_succeed.jsp?orderPrice=" + orderInfo.getOrderPrice() + "&orderId=" + orderId;
    }
}
