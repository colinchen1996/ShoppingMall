package cn.qdu.controller;

import cn.qdu.dao.AddressInfoDao;
import cn.qdu.dao.OrderInfoDao;
import cn.qdu.dao.OrderItemDao;
import cn.qdu.dao.ProductInfoDao;
import cn.qdu.entity.AddressInfo;
import cn.qdu.entity.OrderInfo;
import cn.qdu.entity.OrderItem;
import cn.qdu.entity.ProductInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

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

    @RequestMapping("/getOrderInfo")
    public void getOrderInfo(HttpServletRequest request, HttpServletResponse response) {
        //request.setCharacterEncoding("utf-8");
        String userId = request.getParameter("userId");
        int id = Integer.valueOf(userId).intValue();
        //User user = new User();
        //user.setUserId(i);
        //Object[] param = {user.getUserId()};
        // List<Order> orderlist = new OrderDaoImpl().select("SELECT * from orderinfo where userId = ?", param);
        List<OrderInfo> orderList = orderInfoDao.selectByUserId(id);
        request.getSession().setAttribute("orderlist", orderList);

        //Object[] param1 = {orderlist.get(0).getOrderId()};
        //Object[] param2 = {orderlist.get(0).getAddressId()};
        //List<OrderItem> orderItemlist = new OrderItemDaoImpl().select("SELECT * from orderItem where orderId = ?", param1);
        List<OrderItem> orderItemList = orderItemDao.selectByOrderId(orderList.get(0).getOrderId());
        //List<AddressInfo> addresslist = new AddressDaoImpl().selectAddress("SELECT * from addressinfo WHERE addressId= ?", param2);
        List<AddressInfo> addressList = addressInfoDao.selectByAddressId(orderList.get(0).getAddressInfo().getAddressId());
        request.getSession().setAttribute("orderItemlist", orderItemList);
        request.getSession().setAttribute("addresslist", addressList);

        //Object[] parma3 = {orderItemlist.get(0).getProductId()};
        //List<ProductInfo> productlist = new ProductDaoImpl().select("SELECT * from productinfo WHERE productId= ?",parma3);
        ProductInfo productInfo = productInfoDao.selectByPrimaryKey(orderItemList.get(0).getProductInfo().getProductId());

        request.getSession().setAttribute("productlist", productInfo);
        try {
            response.sendRedirect("userInfo.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/countOrder")
    public void countOrder(HttpServletRequest request,HttpServletResponse response) {
        Map productMap = (HashMap) request.getSession().getAttribute("productMap");
        //CartDaoImpl cartDaoImpl = new CartDaoImpl();
        List<ProductInfo> productInfoList = new ArrayList<ProductInfo>();
        List countList = new ArrayList();
        Iterator iter = productMap.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry entry = (Map.Entry) iter.next();
            int productId = (Integer) entry.getKey();
            int count = (Integer) entry.getValue();
            countList.add(count);
            //List<Product> cartList = cartDaoImpl.getProductById(productId);
            ProductInfo productInfo = productInfoDao.selectByPrimaryKey(productId);
            productInfoList.add(productInfo);
        }
        request.setAttribute("productInfoList", productInfoList);
        request.setAttribute("countList", countList);
        try {
            request.getRequestDispatcher("order_index.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
